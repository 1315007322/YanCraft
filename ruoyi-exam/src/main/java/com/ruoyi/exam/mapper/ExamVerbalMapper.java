package com.ruoyi.exam.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.exam.domain.ExamVerbalCard;

/**
 * Verbal memory card mapper.
 */
public interface ExamVerbalMapper
{
    List<ExamVerbalCard> selectCardList(ExamVerbalCard query);

    List<ExamVerbalCard> selectPublicCardList(ExamVerbalCard query);

    ExamVerbalCard selectCardById(@Param("cardId") Long cardId, @Param("ownerUserId") Long ownerUserId);

    ExamVerbalCard selectPublicCardById(@Param("cardId") Long cardId);

    List<ExamVerbalCard> selectDueCards(@Param("today") Date today, @Param("limit") int limit);

    ExamVerbalCard selectRandomCard(@Param("keyword") String keyword, @Param("cardType") String cardType);

    int countDeck(@Param("deckDate") Date deckDate);

    int insertDeckCard(@Param("deckDate") Date deckDate, @Param("cardId") Long cardId, @Param("sort") int sort);

    List<ExamVerbalCard> selectDeckCards(@Param("deckDate") Date deckDate);

    int markDeckMissed(@Param("deckDate") Date deckDate, @Param("cardId") Long cardId);

    int insertCard(ExamVerbalCard card);

    int updateCard(ExamVerbalCard card);

    int updateSchedule(ExamVerbalCard card);

    int deleteCards(@Param("cardIds") Long[] cardIds, @Param("ownerUserId") Long ownerUserId, @Param("updateBy") String updateBy);
}
