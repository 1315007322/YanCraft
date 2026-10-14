package com.ruoyi.exam.support;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class VerbalIntervalTest
{
    @Test
    public void shouldStepForwardWhenRemembered()
    {
        assertEquals(1, VerbalInterval.nextDays(0, true));
        assertEquals(3, VerbalInterval.nextDays(1, true));
        assertEquals(7, VerbalInterval.nextDays(3, true));
        assertEquals(14, VerbalInterval.nextDays(7, true));
        assertEquals(30, VerbalInterval.nextDays(14, true));
        assertEquals(30, VerbalInterval.nextDays(30, true));
    }

    @Test
    public void shouldReturnToOneDayWhenMissed()
    {
        assertEquals(1, VerbalInterval.nextDays(14, false));
        assertEquals(1, VerbalInterval.nextDays(0, false));
    }
}
