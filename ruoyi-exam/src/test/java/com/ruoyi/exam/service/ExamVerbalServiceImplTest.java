package com.ruoyi.exam.service;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.exam.domain.ExamVerbalCard;
import com.ruoyi.exam.mapper.ExamVerbalMapper;
import com.ruoyi.exam.service.impl.ExamVerbalServiceImpl;

@RunWith(MockitoJUnitRunner.class)
public class ExamVerbalServiceImplTest
{
    @Mock
    private ExamVerbalMapper examVerbalMapper;

    @InjectMocks
    private ExamVerbalServiceImpl examVerbalService;

    @Test
    public void shouldStepDueCardsWhenBuildingDeck()
    {
        Date day = day(2026, 10, 14);
        ExamVerbalCard fresh = card(1L, 0, 0);
        ExamVerbalCard seen = card(2L, 3, 2);
        when(examVerbalMapper.countDeck(any(Date.class))).thenReturn(0);
        when(examVerbalMapper.selectDueCards(any(Date.class), eq(20))).thenReturn(Arrays.asList(fresh, seen));
        when(examVerbalMapper.insertDeckCard(any(Date.class), anyLong(), anyInt())).thenReturn(1);

        assertEquals(2, examVerbalService.buildDeck(day));

        assertEquals(Integer.valueOf(1), fresh.getIntervalDays());
        assertEquals(day(2026, 10, 15), fresh.getDueDate());
        assertEquals(Integer.valueOf(1), fresh.getReviewCount());
        assertEquals(Integer.valueOf(7), seen.getIntervalDays());
        assertEquals(day(2026, 10, 21), seen.getDueDate());
        verify(examVerbalMapper).updateSchedule(fresh);
        verify(examVerbalMapper).updateSchedule(seen);
    }

    @Test
    public void shouldNotStepCardAlreadyInDeck()
    {
        ExamVerbalCard card = card(1L, 1, 1);
        when(examVerbalMapper.countDeck(any(Date.class))).thenReturn(5);
        when(examVerbalMapper.selectDueCards(any(Date.class), eq(15))).thenReturn(Arrays.asList(card));
        when(examVerbalMapper.insertDeckCard(any(Date.class), eq(1L), eq(5))).thenReturn(0);

        assertEquals(0, examVerbalService.buildDeck(day(2026, 10, 14)));
        verify(examVerbalMapper, never()).updateSchedule(any(ExamVerbalCard.class));
    }

    @Test
    public void shouldSkipFullDeck()
    {
        when(examVerbalMapper.countDeck(any(Date.class))).thenReturn(20);

        assertEquals(0, examVerbalService.buildDeck(day(2026, 10, 14)));
        verify(examVerbalMapper, never()).selectDueCards(any(Date.class), anyInt());
    }

    @Test
    public void shouldSendMissedCardBackToTomorrow()
    {
        ExamVerbalCard card = card(3L, 7, 4);
        when(examVerbalMapper.markDeckMissed(any(Date.class), eq(3L))).thenReturn(1);
        when(examVerbalMapper.selectPublicCardById(3L)).thenReturn(card);

        ExamVerbalCard result = examVerbalService.missToday(3L);

        assertEquals(Integer.valueOf(0), result.getIntervalDays());
        assertEquals(Integer.valueOf(4), result.getReviewCount());
        assertEquals("1", result.getMissed());
        verify(examVerbalMapper).updateSchedule(card);
    }

    @Test(expected = ServiceException.class)
    public void shouldMissOnlyOncePerDay()
    {
        when(examVerbalMapper.markDeckMissed(any(Date.class), eq(3L))).thenReturn(0);

        examVerbalService.missToday(3L);
    }

    private ExamVerbalCard card(Long id, int interval, int reviews)
    {
        ExamVerbalCard card = new ExamVerbalCard();
        card.setCardId(id);
        card.setIntervalDays(interval);
        card.setReviewCount(reviews);
        return card;
    }

    private Date day(int year, int month, int date)
    {
        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.set(year, month - 1, date);
        return calendar.getTime();
    }
}
