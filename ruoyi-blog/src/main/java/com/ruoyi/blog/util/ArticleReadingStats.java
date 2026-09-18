package com.ruoyi.blog.util;

import java.util.regex.Pattern;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.common.utils.StringUtils;

/**
 * 按 Markdown 估算字数与阅读时长。规则见 docs/versions/v1.0.0.md。
 *
 * @author ruoyi
 */
public class ArticleReadingStats
{
    /** 总字数 = 中文字数 + 英文词数 */
    private int wordCount;

    /** CJK 字符数 */
    private int chineseCount;

    /** 拉丁词数 */
    private int englishCount;

    /** 预计阅读分钟数，空文为 0，有正文至少 1 */
    private int readingTime;

    private static final Pattern FENCE = Pattern.compile("(?s)```.*?```");

    private static final Pattern HTML = Pattern.compile("(?s)<[^>]+>");

    private static final Pattern IMAGE = Pattern.compile("!\\[[^\\]]*\\]\\([^)]*\\)");

    private static final Pattern LINK = Pattern.compile("\\[([^\\]]+)\\]\\([^)]*\\)");

    private ArticleReadingStats(int chineseCount, int englishCount)
    {
        this.chineseCount = chineseCount;
        this.englishCount = englishCount;
        this.wordCount = chineseCount + englishCount;
        if (this.wordCount <= 0)
        {
            this.readingTime = 0;
        }
        else
        {
            double minutes = (double) chineseCount / CmsConstants.CN_CHARS_PER_MINUTE
                    + (double) englishCount / CmsConstants.EN_WORDS_PER_MINUTE;
            this.readingTime = Math.max(1, (int) Math.ceil(minutes));
        }
    }

    /**
     * 根据 Markdown 正文计算统计结果。去掉围栏代码、图片、链接地址和 HTML 后再计数。
     *
     * @param markdown 正文，可空
     * @return 统计结果，不会返回 null
     */
    public static ArticleReadingStats of(String markdown)
    {
        if (StringUtils.isEmpty(markdown))
        {
            return new ArticleReadingStats(0, 0);
        }
        String text = FENCE.matcher(markdown).replaceAll(" ");
        text = IMAGE.matcher(text).replaceAll(" ");
        text = LINK.matcher(text).replaceAll("$1");
        text = HTML.matcher(text).replaceAll(" ");
        int chinese = 0;
        StringBuilder latin = new StringBuilder();
        for (int i = 0; i < text.length(); )
        {
            int cp = text.codePointAt(i);
            i += Character.charCount(cp);
            if (isCjk(cp))
            {
                chinese++;
                latin.append(' ');
            }
            else
            {
                latin.appendCodePoint(cp);
            }
        }
        int english = 0;
        for (String token : latin.toString().split("[^A-Za-z0-9]+"))
        {
            if (token.length() > 0)
            {
                english++;
            }
        }
        return new ArticleReadingStats(chinese, english);
    }

    /**
     * 是否按「一个字」计的 CJK 字符
     */
    private static boolean isCjk(int cp)
    {
        Character.UnicodeScript script = Character.UnicodeScript.of(cp);
        return script == Character.UnicodeScript.HAN
                || script == Character.UnicodeScript.HIRAGANA
                || script == Character.UnicodeScript.KATAKANA
                || script == Character.UnicodeScript.HANGUL;
    }

    public int getWordCount()
    {
        return wordCount;
    }

    public int getChineseCount()
    {
        return chineseCount;
    }

    public int getEnglishCount()
    {
        return englishCount;
    }

    public int getReadingTime()
    {
        return readingTime;
    }
}
