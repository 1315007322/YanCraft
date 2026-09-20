package com.ruoyi.blog.service;

import java.util.List;
import com.ruoyi.blog.domain.CmsFriendLink;

/**
 * Friend link service.
 *
 * @author ruoyi
 */
public interface ICmsFriendLinkService
{
    /**
     * Select by id.
     *
     * @param linkId link id
     * @return link
     */
    CmsFriendLink selectFriendLinkById(Long linkId);

    /**
     * Query list.
     *
     * @param link query
     * @return rows
     */
    List<CmsFriendLink> selectFriendLinkList(CmsFriendLink link);

    /**
     * Insert.
     *
     * @param link entity
     * @return rows
     */
    int insertFriendLink(CmsFriendLink link);

    /**
     * Update.
     *
     * @param link entity
     * @return rows
     */
    int updateFriendLink(CmsFriendLink link);

    /**
     * Soft delete by ids.
     *
     * @param linkIds ids
     * @return rows
     */
    int deleteFriendLinkByIds(Long[] linkIds);
}
