package com.ruoyi.blog.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.blog.domain.CmsTag;
import com.ruoyi.blog.mapper.CmsTagMapper;
import com.ruoyi.blog.service.ICmsTagService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * 博客标签服务实现
 *
 * @author ruoyi
 */
@Service
public class CmsTagServiceImpl implements ICmsTagService
{
    @Autowired
    private CmsTagMapper tagMapper;

    /**
     * 按ID查询标签
     */
    @Override
    public CmsTag selectTagById(Long tagId)
    {
        return tagMapper.selectTagById(tagId);
    }

    /**
     * 查询标签列表
     */
    @Override
    public List<CmsTag> selectTagList(CmsTag tag)
    {
        return tagMapper.selectTagList(tag);
    }

    /**
     * 新增标签
     */
    @Override
    public int insertTag(CmsTag tag)
    {
        prepare(tag, null);
        return tagMapper.insertTag(tag);
    }

    /**
     * 修改标签
     */
    @Override
    public int updateTag(CmsTag tag)
    {
        prepare(tag, tag.getTagId());
        return tagMapper.updateTag(tag);
    }

    /**
     * 删除标签；仍被文章引用则拒绝
     */
    @Override
    public int deleteTagByIds(Long[] tagIds)
    {
        for (Long id : tagIds)
        {
            if (tagMapper.countArticleByTagId(id) > 0)
            {
                CmsTag tag = tagMapper.selectTagById(id);
                String name = tag == null ? String.valueOf(id) : tag.getName();
                throw new ServiceException("标签「" + name + "」已被文章使用，无法删除");
            }
        }
        return tagMapper.deleteTagByIds(tagIds);
    }

    /**
     * 规范化 slug，校验名称与 slug 唯一
     */
    private void prepare(CmsTag tag, Long excludeId)
    {
        tag.setSlug(blankToNull(tag.getSlug()));
        if (tagMapper.checkNameUnique(tag.getName(), excludeId) != null)
        {
            throw new ServiceException("标签名称已存在");
        }
        if (tag.getSlug() != null && tagMapper.checkSlugUnique(tag.getSlug(), excludeId) != null)
        {
            throw new ServiceException("标签访问标识已存在");
        }
    }

    /**
     * 空白 slug 存 null
     */
    private String blankToNull(String slug)
    {
        return StringUtils.isEmpty(slug) ? null : slug.trim();
    }
}
