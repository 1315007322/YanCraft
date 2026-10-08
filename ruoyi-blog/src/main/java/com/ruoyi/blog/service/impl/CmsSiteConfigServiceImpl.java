package com.ruoyi.blog.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson2.JSON;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.blog.domain.CmsNavLink;
import com.ruoyi.blog.domain.CmsSiteConfig;
import com.ruoyi.blog.domain.CmsSiteSetting;
import com.ruoyi.blog.mapper.CmsSiteConfigMapper;
import com.ruoyi.blog.service.ICmsSiteConfigService;
import com.ruoyi.common.utils.StringUtils;

/**
 * Load and upsert first-version site keys.
 *
 * @author ruoyi
 */
@Service
public class CmsSiteConfigServiceImpl implements ICmsSiteConfigService
{
    private static final String KEY_SITE_NAME = "siteName";
    private static final String KEY_LOGO_PREFIX = "logoPrefix";
    private static final String KEY_LOGO_HIGHLIGHT = "logoHighlight";
    private static final String KEY_TAGLINE = "tagline";
    private static final String KEY_AUTHOR = "author";
    private static final String KEY_AUTHOR_SIGNATURE = "authorSignature";
    private static final String KEY_AVATAR_URL = "avatarUrl";
    private static final String KEY_AVATAR_LETTER = "avatarLetter";
    private static final String KEY_FOOTER = "footerText";
    private static final String KEY_BEIAN_TEXT = "beianText";
    private static final String KEY_BEIAN_URL = "beianUrl";
    private static final String KEY_SITE_URL = "siteUrl";
    private static final String KEY_ABOUT_TITLE = "aboutTitle";
    private static final String KEY_ABOUT_CONTENT = "aboutContent";
    private static final String KEY_ABOUT_ENABLED = "aboutEnabled";
    private static final String KEY_SEARCH_ENABLED = "searchEnabled";
    private static final String KEY_CATEGORY_ENABLED = "categoryEnabled";
    private static final String KEY_FRIEND_LINK_ENABLED = "friendLinkEnabled";
    private static final String KEY_LAB_ENABLED = "labEnabled";
    private static final String KEY_HOT_LIMIT = "hotLimit";
    private static final String KEY_HOME_PAGE_SIZE = "homePageSize";
    private static final String KEY_EXTRA_NAV_LINKS = "extraNavLinks";
    private static final String KEY_THEME_ID = "themeId";
    private static final String DEFAULT_THEME_ID = "paper";
    private static final String[] THEME_IDS = new String[] { "paper", "press", "celadon", "night", "ink", "harbor" };

    @Autowired
    private CmsSiteConfigMapper siteConfigMapper;

    /**
     * Merge stored keys onto SuperYan defaults.
     */
    @Override
    public CmsSiteSetting getSetting()
    {
        Map<String, String> map = toMap(siteConfigMapper.selectSiteConfigList());
        CmsSiteSetting setting = new CmsSiteSetting();
        setting.setSiteName(str(map, KEY_SITE_NAME, "SuperYan"));
        setting.setLogoPrefix(str(map, KEY_LOGO_PREFIX, "SUPER"));
        setting.setLogoHighlight(str(map, KEY_LOGO_HIGHLIGHT, "YAN"));
        setting.setTagline(str(map, KEY_TAGLINE, "Going to try and get something up eventually I hope"));
        setting.setAuthor(str(map, KEY_AUTHOR, "SuperYan"));
        setting.setAuthorSignature(str(map, KEY_AUTHOR_SIGNATURE, ""));
        setting.setAvatarUrl(str(map, KEY_AVATAR_URL, ""));
        setting.setAvatarLetter(str(map, KEY_AVATAR_LETTER, "SY"));
        setting.setFooterText(str(map, KEY_FOOTER, "SuperYan"));
        setting.setBeianText(str(map, KEY_BEIAN_TEXT, ""));
        setting.setBeianUrl(str(map, KEY_BEIAN_URL, "https://beian.miit.gov.cn/"));
        setting.setSiteUrl(str(map, KEY_SITE_URL, ""));
        setting.setAboutTitle(str(map, KEY_ABOUT_TITLE, "SuperYan"));
        setting.setAboutContent(str(map, KEY_ABOUT_CONTENT, ""));
        setting.setAboutEnabled(flag(map, KEY_ABOUT_ENABLED));
        setting.setSearchEnabled(flag(map, KEY_SEARCH_ENABLED));
        setting.setCategoryEnabled(flag(map, KEY_CATEGORY_ENABLED));
        setting.setFriendLinkEnabled(flag(map, KEY_FRIEND_LINK_ENABLED));
        setting.setLabEnabled(flag(map, KEY_LAB_ENABLED));
        setting.setHotLimit(num(map, KEY_HOT_LIMIT, 6));
        setting.setHomePageSize(num(map, KEY_HOME_PAGE_SIZE, 8));
        setting.setExtraNavLinks(parseNavLinks(map.get(KEY_EXTRA_NAV_LINKS)));
        setting.setThemeId(normalizeThemeId(map.get(KEY_THEME_ID)));
        return setting;
    }

    /**
     * Write each first-version key.
     */
    @Override
    public int saveSetting(CmsSiteSetting setting)
    {
        int rows = 0;
        rows += upsert(KEY_SITE_NAME, setting.getSiteName());
        rows += upsert(KEY_LOGO_PREFIX, setting.getLogoPrefix());
        rows += upsert(KEY_LOGO_HIGHLIGHT, setting.getLogoHighlight());
        rows += upsert(KEY_TAGLINE, setting.getTagline());
        rows += upsert(KEY_AUTHOR, setting.getAuthor());
        rows += upsert(KEY_AUTHOR_SIGNATURE, setting.getAuthorSignature());
        rows += upsert(KEY_AVATAR_URL, setting.getAvatarUrl());
        rows += upsert(KEY_AVATAR_LETTER, setting.getAvatarLetter());
        rows += upsert(KEY_FOOTER, setting.getFooterText());
        rows += upsert(KEY_BEIAN_TEXT, setting.getBeianText());
        rows += upsert(KEY_BEIAN_URL, setting.getBeianUrl());
        rows += upsert(KEY_SITE_URL, setting.getSiteUrl());
        rows += upsert(KEY_ABOUT_TITLE, setting.getAboutTitle());
        rows += upsert(KEY_ABOUT_CONTENT, setting.getAboutContent());
        rows += upsert(KEY_ABOUT_ENABLED, enabled(setting.getAboutEnabled()));
        rows += upsert(KEY_SEARCH_ENABLED, enabled(setting.getSearchEnabled()));
        rows += upsert(KEY_CATEGORY_ENABLED, enabled(setting.getCategoryEnabled()));
        rows += upsert(KEY_FRIEND_LINK_ENABLED, enabled(setting.getFriendLinkEnabled()));
        rows += upsert(KEY_LAB_ENABLED, enabled(setting.getLabEnabled()));
        rows += upsert(KEY_HOT_LIMIT, setting.getHotLimit() == null ? "6" : String.valueOf(setting.getHotLimit()));
        rows += upsert(KEY_HOME_PAGE_SIZE, setting.getHomePageSize() == null ? "8" : String.valueOf(setting.getHomePageSize()));
        rows += upsert(KEY_EXTRA_NAV_LINKS, JSON.toJSONString(normalizeNavLinks(setting.getExtraNavLinks())));
        rows += upsert(KEY_THEME_ID, normalizeThemeId(setting.getThemeId()));
        return rows;
    }

    private int upsert(String key, String value)
    {
        CmsSiteConfig row = new CmsSiteConfig();
        row.setConfigKey(key);
        row.setConfigValue(value == null ? "" : value);
        int updated = siteConfigMapper.updateSiteConfigByKey(row);
        if (updated > 0)
        {
            return updated;
        }
        return siteConfigMapper.insertSiteConfig(row);
    }

    private Map<String, String> toMap(List<CmsSiteConfig> rows)
    {
        Map<String, String> map = new HashMap<String, String>();
        if (rows == null)
        {
            return map;
        }
        for (CmsSiteConfig row : rows)
        {
            if (row.getConfigKey() != null)
            {
                map.put(row.getConfigKey(), row.getConfigValue());
            }
        }
        return map;
    }

    private String normalizeThemeId(String value)
    {
        if (StringUtils.isEmpty(value))
        {
            return DEFAULT_THEME_ID;
        }
        String id = value.trim();
        for (int i = 0; i < THEME_IDS.length; i++)
        {
            if (THEME_IDS[i].equals(id))
            {
                return id;
            }
        }
        return DEFAULT_THEME_ID;
    }

    private String str(Map<String, String> map, String key, String fallback)
    {
        if (!map.containsKey(key))
        {
            return fallback;
        }
        String value = map.get(key);
        return value == null ? "" : value;
    }

    private String flag(Map<String, String> map, String key)
    {
        String value = map.get(key);
        return CmsConstants.STATUS_DISABLE.equals(value) ? CmsConstants.STATUS_DISABLE : CmsConstants.STATUS_OK;
    }

    private String enabled(String value)
    {
        return CmsConstants.STATUS_DISABLE.equals(value) ? CmsConstants.STATUS_DISABLE : CmsConstants.STATUS_OK;
    }

    private Integer num(Map<String, String> map, String key, int fallback)
    {
        String value = map.get(key);
        if (StringUtils.isEmpty(value))
        {
            return fallback;
        }
        try
        {
            int parsed = Integer.parseInt(value.trim());
            if (parsed < 1)
            {
                return fallback;
            }
            return parsed;
        }
        catch (NumberFormatException ex)
        {
            return fallback;
        }
    }

    private List<CmsNavLink> parseNavLinks(String json)
    {
        if (StringUtils.isEmpty(json))
        {
            return new ArrayList<CmsNavLink>();
        }
        try
        {
            List<CmsNavLink> links = JSON.parseArray(json, CmsNavLink.class);
            return normalizeNavLinks(links);
        }
        catch (Exception ex)
        {
            return new ArrayList<CmsNavLink>();
        }
    }

    private List<CmsNavLink> normalizeNavLinks(List<CmsNavLink> source)
    {
        List<CmsNavLink> links = new ArrayList<CmsNavLink>();
        if (source == null)
        {
            return links;
        }
        for (CmsNavLink item : source)
        {
            if (item == null || StringUtils.isEmpty(item.getName()) || StringUtils.isEmpty(item.getUrl()))
            {
                continue;
            }
            String url = item.getUrl().trim();
            if (!url.startsWith("http://") && !url.startsWith("https://"))
            {
                continue;
            }
            CmsNavLink link = new CmsNavLink();
            String name = item.getName().trim();
            if (name.length() > 20)
            {
                name = name.substring(0, 20);
            }
            link.setName(name);
            link.setUrl(url);
            link.setOpenInNew(enabled(item.getOpenInNew()));
            link.setEnabled(enabled(item.getEnabled()));
            link.setSort(item.getSort() == null ? 0 : item.getSort());
            links.add(link);
            if (links.size() >= 20)
            {
                break;
            }
        }
        Collections.sort(links, new Comparator<CmsNavLink>()
        {
            @Override
            public int compare(CmsNavLink a, CmsNavLink b)
            {
                int sa = a.getSort() == null ? 0 : a.getSort();
                int sb = b.getSort() == null ? 0 : b.getSort();
                return Integer.compare(sa, sb);
            }
        });
        return links;
    }
}
