package com.ruoyi.blog.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.blog.domain.CmsFriendLink;

/**
 * Friend link mapper.
 *
 * @author ruoyi
 */
public interface CmsFriendLinkMapper
{
    /**
     * Select by id (not deleted).
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
     * Soft delete.
     *
     * @param linkIds ids
     * @return rows
     */
    int deleteFriendLinkByIds(Long[] linkIds);

    /**
     * Find another live row with the same site url.
     *
     * @param siteUrl site url
     * @param linkId exclude id, null on insert
     * @return conflict or null
     */
    CmsFriendLink checkSiteUrlUnique(@Param("siteUrl") String siteUrl, @Param("linkId") Long linkId);
}
