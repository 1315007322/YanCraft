package com.ruoyi.exam.support;

/**
 * Fixed review steps: 1, 3, 7, 14, 30 days. A miss returns to 1 day.
 */
public final class VerbalInterval
{
    private VerbalInterval()
    {
    }

    public static int nextDays(int current, boolean remembered)
    {
        if (!remembered)
        {
            return 1;
        }
        if (current < 1)
        {
            return 1;
        }
        if (current < 3)
        {
            return 3;
        }
        if (current < 7)
        {
            return 7;
        }
        if (current < 14)
        {
            return 14;
        }
        return 30;
    }
}
