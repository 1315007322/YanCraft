package com.ruoyi.blog.constant;

/**
 * 博客模块常量。功能版本与 docs/CHANGELOG.md 对齐。
 *
 * @author ruoyi
 */
public class CmsConstants
{
    /** 功能版本 */
    public static final String MODULE_VERSION = "1.0.1";

    /** 未删除 */
    public static final String DEL_NORMAL = "0";

    /** 已删除 */
    public static final String DEL_DELETED = "2";

    /** 分类/标签启用 */
    public static final String STATUS_OK = "0";

    /** 分类停用 */
    public static final String STATUS_DISABLE = "1";

    /** 文章草稿 */
    public static final String ARTICLE_DRAFT = "0";

    /** 文章已发布 */
    public static final String ARTICLE_PUBLISHED = "1";

    /** 文章下线 */
    public static final String ARTICLE_OFFLINE = "2";

    /** 不置顶 */
    public static final String NOT_TOP = "0";

    /** 置顶 */
    public static final String TOP = "1";

    /** 中文约每分钟字数 */
    public static final int CN_CHARS_PER_MINUTE = 400;

    /** 英文约每分钟词数 */
    public static final int EN_WORDS_PER_MINUTE = 200;

    private CmsConstants()
    {
    }
}
