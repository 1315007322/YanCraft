package com.ruoyi.exam.service;

import java.util.Date;
import java.util.List;
import com.ruoyi.exam.domain.ExamVerbalCard;

/**
 * Verbal memory cards.
 */
public interface IExamVerbalService
{
    List<ExamVerbalCard> selectCardList(ExamVerbalCard query);

    List<ExamVerbalCard> selectPublicCardList(ExamVerbalCard query);

    ExamVerbalCard selectCardById(Long cardId, Long ownerUserId);

    ExamVerbalCard selectRandomCard(String keyword, String cardType);

    int insertCard(ExamVerbalCard card);

    int updateCard(ExamVerbalCard card);

    int deleteCards(Long[] cardIds, Long ownerUserId, String updateBy);

    /**
     * Fill the deck for that day with due cards and step their interval forward.
     */
    int buildDeck(Date day);

    List<ExamVerbalCard> selectTodayDeck();

    ExamVerbalCard missToday(Long cardId);
}
