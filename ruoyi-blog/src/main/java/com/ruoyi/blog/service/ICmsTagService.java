package com.ruoyi.blog.service;

import java.util.List;
import com.ruoyi.blog.domain.CmsTag;

/**
 * 博客标签服务
 *
 * @author ruoyi
 */
public interface ICmsTagService
{
    /**
     * 按ID查询标签
     *
     * @param tagId 标签ID
     * @return 标签
     */
    CmsTag selectTagById(Long tagId);

    /**
     * 查询标签列表
     *
     * @param tag 查询条件
     * @return 标签集合
     */
    List<CmsTag> selectTagList(CmsTag tag);

    /**
     * 新增标签
     *
     * @param tag 标签
     * @return 影响行数
     */
    int insertTag(CmsTag tag);

    /**
     * 修改标签
     *
     * @param tag 标签
     * @return 影响行数
     */
    int updateTag(CmsTag tag);

    /**
     * 删除标签。仍被文章引用时抛出业务异常。
     *
     * @param tagIds 标签ID数组
     * @return 影响行数
     */
    int deleteTagByIds(Long[] tagIds);
}
