package com.ruoyi.blog.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.blog.domain.CmsFriendLink;
import com.ruoyi.blog.mapper.CmsFriendLinkMapper;
import com.ruoyi.blog.service.ICmsFriendLinkService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * Friend link service implementation.
 *
 * @author ruoyi
 */
@Service
public class CmsFriendLinkServiceImpl implements ICmsFriendLinkService
{
    @Autowired
    private CmsFriendLinkMapper friendLinkMapper;

    /**
     * Select by id.
     */
    @Override
    public CmsFriendLink selectFriendLinkById(Long linkId)
    {
        return friendLinkMapper.selectFriendLinkById(linkId);
    }

    /**
     * Query list.
     */
    @Override
    public List<CmsFriendLink> selectFriendLinkList(CmsFriendLink link)
    {
        return friendLinkMapper.selectFriendLinkList(link);
    }

    /**
     * Insert with default status and sort.
     */
    @Override
    public int insertFriendLink(CmsFriendLink link)
    {
        prepare(link, null);
        if (StringUtils.isEmpty(link.getStatus()))
        {
            link.setStatus(CmsConstants.STATUS_OK);
        }
        if (link.getSort() == null)
        {
            link.setSort(0);
        }
        return friendLinkMapper.insertFriendLink(link);
    }

    /**
     * Update.
     */
    @Override
    public int updateFriendLink(CmsFriendLink link)
    {
        prepare(link, link.getLinkId());
        return friendLinkMapper.updateFriendLink(link);
    }

    /**
     * Soft delete.
     */
    @Override
    public int deleteFriendLinkByIds(Long[] linkIds)
    {
        return friendLinkMapper.deleteFriendLinkByIds(linkIds);
    }

    /**
     * Trim url and reject duplicates among live rows.
     */
    private void prepare(CmsFriendLink link, Long excludeId)
    {
        if (StringUtils.isNotEmpty(link.getSiteUrl()))
        {
            link.setSiteUrl(link.getSiteUrl().trim());
        }
        if (StringUtils.isNotEmpty(link.getNickname()))
        {
            link.setNickname(link.getNickname().trim());
        }
        if (StringUtils.isNotEmpty(link.getDescription()))
        {
            link.setDescription(link.getDescription().trim());
        }
        else
        {
            link.setDescription(null);
        }
        if (friendLinkMapper.checkSiteUrlUnique(link.getSiteUrl(), excludeId) != null)
        {
            throw new ServiceException("\u7f51\u7ad9\u5730\u5740\u5df2\u5b58\u5728");
        }
    }
}
