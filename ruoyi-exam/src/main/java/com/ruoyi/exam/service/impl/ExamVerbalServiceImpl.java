package com.ruoyi.exam.service.impl;

import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.exam.domain.ExamVerbalCard;
import com.ruoyi.exam.mapper.ExamVerbalMapper;
import com.ruoyi.exam.service.IExamVerbalService;
import com.ruoyi.exam.support.VerbalInterval;

/**
 * Verbal cards and the fixed review interval.
 */
@Service
public class ExamVerbalServiceImpl implements IExamVerbalService
{
    /** Cards in one day's deck */
    private static final int DECK_SIZE = 20;

    @Autowired
    private ExamVerbalMapper examVerbalMapper;

    @Override
    public List<ExamVerbalCard> selectCardList(ExamVerbalCard query)
    {
        query.setKeyword(trimKeyword(query.getKeyword()));
        return examVerbalMapper.selectCardList(query);
    }

    @Override
    public List<ExamVerbalCard> selectPublicCardList(ExamVerbalCard query)
    {
        query.setKeyword(trimKeyword(query.getKeyword()));
        query.setCardType(normalizeTypeFilter(query.getCardType()));
        List<ExamVerbalCard> rows = examVerbalMapper.selectPublicCardList(query);
        if (rows == null)
        {
            return Collections.emptyList();
        }
        for (ExamVerbalCard row : rows)
        {
            hideOwner(row);
        }
        return rows;
    }

    @Override
    public ExamVerbalCard selectCardById(Long cardId, Long ownerUserId)
    {
        return examVerbalMapper.selectCardById(cardId, ownerUserId);
    }

    @Override
    @Transactional
    public int buildDeck(Date day)
    {
        Date deckDate = startOfDay(day);
        int size = examVerbalMapper.countDeck(deckDate);
        int remaining = DECK_SIZE - size;
        if (remaining <= 0)
        {
            return 0;
        }
        List<ExamVerbalCard> due = examVerbalMapper.selectDueCards(deckDate, remaining);
        if (due == null || due.isEmpty())
        {
            return 0;
        }
        int added = 0;
        for (ExamVerbalCard card : due)
        {
            if (examVerbalMapper.insertDeckCard(deckDate, card.getCardId(), size + added) == 0)
            {
                continue;
            }
            int current = card.getIntervalDays() == null ? 0 : card.getIntervalDays();
            int next = VerbalInterval.nextDays(current, true);
            int count = card.getReviewCount() == null ? 0 : card.getReviewCount();
            card.setIntervalDays(next);
            card.setDueDate(plusDays(deckDate, next));
            card.setReviewCount(count + 1);
            examVerbalMapper.updateSchedule(card);
            added++;
        }
        return added;
    }

    @Override
    @Transactional
    public List<ExamVerbalCard> selectTodayDeck()
    {
        Date day = today();
        buildDeck(day);
        List<ExamVerbalCard> rows = examVerbalMapper.selectDeckCards(day);
        if (rows == null)
        {
            return Collections.emptyList();
        }
        for (ExamVerbalCard row : rows)
        {
            hideOwner(row);
        }
        return rows;
    }

    @Override
    @Transactional
    public ExamVerbalCard missToday(Long cardId)
    {
        if (cardId == null)
        {
            throw new ServiceException("\u5361\u7247\u4e0d\u5b58\u5728");
        }
        Date day = today();
        if (examVerbalMapper.markDeckMissed(day, cardId) == 0)
        {
            throw new ServiceException("\u53ea\u80fd\u628a\u4eca\u5929\u5361\u7ec4\u91cc\u7684\u5361\u63a8\u5230\u660e\u5929\uff0c\u4e14\u6bcf\u5929\u4e00\u6b21");
        }
        ExamVerbalCard card = examVerbalMapper.selectPublicCardById(cardId);
        if (card == null)
        {
            throw new ServiceException("\u5361\u7247\u4e0d\u5b58\u5728");
        }
        card.setIntervalDays(0);
        card.setDueDate(plusDays(day, 1));
        examVerbalMapper.updateSchedule(card);
        card.setMissed("1");
        hideOwner(card);
        return card;
    }

    @Override
    public ExamVerbalCard selectRandomCard(String keyword, String cardType)
    {
        ExamVerbalCard card = examVerbalMapper.selectRandomCard(trimKeyword(keyword), normalizeTypeFilter(cardType));
        hideOwner(card);
        return card;
    }

    @Override
    public int insertCard(ExamVerbalCard card)
    {
        normalize(card);
        card.setIntervalDays(0);
        card.setDueDate(today());
        card.setReviewCount(0);
        return examVerbalMapper.insertCard(card);
    }

    @Override
    public int updateCard(ExamVerbalCard card)
    {
        if (card.getCardId() == null)
        {
            throw new ServiceException("\u5361\u7247\u4e0d\u5b58\u5728");
        }
        ExamVerbalCard existing = examVerbalMapper.selectCardById(card.getCardId(), card.getOwnerUserId());
        if (existing == null)
        {
            throw new ServiceException("\u5361\u7247\u4e0d\u5b58\u5728");
        }
        normalize(card);
        return examVerbalMapper.updateCard(card);
    }

    @Override
    public int deleteCards(Long[] cardIds, Long ownerUserId, String updateBy)
    {
        if (cardIds == null || cardIds.length == 0)
        {
            return 0;
        }
        return examVerbalMapper.deleteCards(cardIds, ownerUserId, updateBy);
    }

    private void normalize(ExamVerbalCard card)
    {
        card.setCardType(requiredType(card.getCardType()));
        card.setPrompt(requiredText(card.getPrompt(), 80, "\u6b63\u9762"));
        card.setDifference(requiredText(card.getDifference(), 500, "\u5dee\u522b"));
        card.setCollocation(optionalText(card.getCollocation(), 200, "\u642d\u914d"));
        card.setConfusion(optionalText(card.getConfusion(), 200, "\u6613\u6df7"));
        card.setOwnSentence(optionalText(card.getOwnSentence(), 300, "\u81ea\u5df1\u7684\u4e00\u53e5"));
        if (card.getRemark() != null && card.getRemark().length() > 500)
        {
            throw new ServiceException("\u5907\u6ce8\u592a\u957f");
        }
    }

    private String requiredType(String value)
    {
        String type = value == null ? "0" : value.trim();
        if (!"0".equals(type) && !"1".equals(type) && !"2".equals(type))
        {
            throw new ServiceException("\u7c7b\u578b\u4e0d\u6b63\u786e");
        }
        return type;
    }

    private String normalizeTypeFilter(String value)
    {
        if (StringUtils.isEmpty(value))
        {
            return null;
        }
        String type = value.trim();
        if (!"0".equals(type) && !"1".equals(type) && !"2".equals(type))
        {
            return null;
        }
        return type;
    }

    private String requiredText(String value, int max, String label)
    {
        String text = value == null ? "" : value.trim();
        if (text.isEmpty())
        {
            throw new ServiceException(label + "\u4e0d\u80fd\u4e3a\u7a7a");
        }
        if (text.length() > max)
        {
            throw new ServiceException(label + "\u592a\u957f");
        }
        return text;
    }

    private String optionalText(String value, int max, String label)
    {
        if (value == null)
        {
            return null;
        }
        String text = value.trim();
        if (text.isEmpty())
        {
            return null;
        }
        if (text.length() > max)
        {
            throw new ServiceException(label + "\u592a\u957f");
        }
        return text;
    }

    private String trimKeyword(String keyword)
    {
        if (keyword == null)
        {
            return null;
        }
        String text = keyword.trim();
        if (text.isEmpty())
        {
            return null;
        }
        return text.length() > 40 ? text.substring(0, 40) : text;
    }

    private void hideOwner(ExamVerbalCard card)
    {
        if (card == null)
        {
            return;
        }
        card.setOwnerUserId(null);
        card.setCreateBy(null);
        card.setUpdateBy(null);
        card.setRemark(null);
    }

    private Date today()
    {
        return startOfDay(new Date());
    }

    private Date startOfDay(Date day)
    {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(day == null ? new Date() : day);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    private Date plusDays(Date day, int days)
    {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(day);
        calendar.add(Calendar.DATE, days);
        return calendar.getTime();
    }
}
