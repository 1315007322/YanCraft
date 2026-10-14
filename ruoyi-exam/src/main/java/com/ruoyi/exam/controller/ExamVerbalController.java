package com.ruoyi.exam.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.exam.domain.ExamVerbalCard;
import com.ruoyi.exam.service.IExamVerbalService;

/**
 * Admin CRUD for verbal memory cards.
 */
@RestController
@RequestMapping("/exam/verbal")
public class ExamVerbalController extends BaseController
{
    @Autowired
    private IExamVerbalService examVerbalService;

    @PreAuthorize("@ss.hasPermi('exam:verbal:list')")
    @GetMapping("/list")
    public TableDataInfo list(ExamVerbalCard query)
    {
        query.setOwnerUserId(getUserId());
        startPage();
        List<ExamVerbalCard> list = examVerbalService.selectCardList(query);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('exam:verbal:query')")
    @GetMapping("/{cardId}")
    public AjaxResult getInfo(@PathVariable Long cardId)
    {
        return success(examVerbalService.selectCardById(cardId, getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('exam:verbal:add')")
    @Log(title = "Verbal Card", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamVerbalCard card)
    {
        card.setOwnerUserId(getUserId());
        card.setCreateBy(getUsername());
        return toAjax(examVerbalService.insertCard(card));
    }

    @PreAuthorize("@ss.hasPermi('exam:verbal:edit')")
    @Log(title = "Verbal Card", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamVerbalCard card)
    {
        card.setOwnerUserId(getUserId());
        card.setUpdateBy(getUsername());
        return toAjax(examVerbalService.updateCard(card));
    }

    @PreAuthorize("@ss.hasPermi('exam:verbal:remove')")
    @Log(title = "Verbal Card", businessType = BusinessType.DELETE)
    @DeleteMapping("/{cardIds}")
    public AjaxResult remove(@PathVariable Long[] cardIds)
    {
        return toAjax(examVerbalService.deleteCards(cardIds, getUserId(), getUsername()));
    }
}
