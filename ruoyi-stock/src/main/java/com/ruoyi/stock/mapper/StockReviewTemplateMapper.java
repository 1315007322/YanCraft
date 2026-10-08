package com.ruoyi.stock.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.stock.domain.StockReviewTemplate;

/**
 * Review templates: system (owner 0) plus current user.
 */
public interface StockReviewTemplateMapper
{
    List<StockReviewTemplate> selectTemplateList(@Param("ownerUserId") Long ownerUserId);

    StockReviewTemplate selectTemplateById(@Param("templateId") Long templateId,
            @Param("ownerUserId") Long ownerUserId);

    int insertTemplate(StockReviewTemplate template);

    int deleteTemplate(@Param("templateId") Long templateId, @Param("ownerUserId") Long ownerUserId,
            @Param("updateBy") String updateBy);
}
