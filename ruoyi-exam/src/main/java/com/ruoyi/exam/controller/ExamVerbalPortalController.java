package com.ruoyi.exam.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.exam.domain.ExamVerbalCard;
import com.ruoyi.exam.domain.ExamVerbalGrade;
import com.ruoyi.exam.service.IExamVerbalService;

/**
 * Blog-facing verbal cards. The schedule only moves through the daily deck;
 * visitors can at most push a card in today's deck back to tomorrow, once.
 */
@Anonymous
@RestController
@RequestMapping("/portal/exam/verbal")
public class ExamVerbalPortalController extends BaseController
{
    @Autowired
    private IExamVerbalService examVerbalService;

    @GetMapping("/list")
    public TableDataInfo list(ExamVerbalCard query)
    {
        startPage();
        List<ExamVerbalCard> list = examVerbalService.selectPublicCardList(query);
        return getDataTable(list);
    }

    @GetMapping("/today")
    public AjaxResult today()
    {
        return success(examVerbalService.selectTodayDeck());
    }

    @GetMapping("/random")
    public AjaxResult random(@RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "cardType", required = false) String cardType)
    {
        ExamVerbalCard card = examVerbalService.selectRandomCard(keyword, cardType);
        return card == null ? error("\u6ca1\u6709\u53ef\u8bfb\u7684\u5361\u7247") : success(card);
    }

    @PostMapping("/miss")
    public AjaxResult miss(@RequestBody ExamVerbalGrade body)
    {
        return success(examVerbalService.missToday(body == null ? null : body.getCardId()));
    }
}
