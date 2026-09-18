package com.ruoyi.blog.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.blog.domain.CmsTag;

/**
 * 标签数据层
 *
 * @author ruoyi
 */
public interface CmsTagMapper
{
    /**
     * 按ID查询未删除标签
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
     * 查询文章已绑定的标签
     *
     * @param articleId 文章ID
     * @return 标签集合
     */
    List<CmsTag> selectTagsByArticleId(Long articleId);

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
     * 逻辑删除标签
     *
     * @param tagIds 标签ID数组
     * @return 影响行数
     */
    int deleteTagByIds(Long[] tagIds);

    /**
     * 校验名称是否已被其它未删除标签占用
     *
     * @param name 标签名
     * @param tagId 排除的标签ID，新增传 null
     * @return 冲突记录；无冲突则 null
     */
    CmsTag checkNameUnique(@Param("name") String name, @Param("tagId") Long tagId);

    /**
     * 校验 slug 是否已被其它未删除标签占用
     *
     * @param slug 访问标识
     * @param tagId 排除的标签ID，新增传 null
     * @return 冲突记录；无冲突则 null
     */
    CmsTag checkSlugUnique(@Param("slug") String slug, @Param("tagId") Long tagId);

    /**
     * 统计标签被未删除文章引用的次数
     *
     * @param tagId 标签ID
     * @return 引用数
     */
    int countArticleByTagId(Long tagId);
}
