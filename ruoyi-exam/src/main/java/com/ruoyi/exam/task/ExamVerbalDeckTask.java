package com.ruoyi.exam.task;

import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import com.ruoyi.exam.service.IExamVerbalService;

/**
 * Builds the first deck of each day from the interval schedule.
 * Also runs at startup so a server that was down at midnight still has one.
 */
@Configuration
@EnableScheduling
public class ExamVerbalDeckTask
{
    private static final Logger log = LoggerFactory.getLogger(ExamVerbalDeckTask.class);

    @Autowired
    private IExamVerbalService examVerbalService;

    @Scheduled(cron = "0 5 0 * * ?")
    public void daily()
    {
        build("daily");
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onReady()
    {
        build("startup");
    }

    private void build(String reason)
    {
        try
        {
            int added = examVerbalService.buildDeck(new Date());
            log.info("verbal deck {}: {} cards added", reason, added);
        }
        catch (Exception ex)
        {
            log.warn("verbal deck {} failed: {}", reason, ex.getMessage());
        }
    }
}
