import type { PageDomain, BaseEntity } from "../common";
import type { CmsTag } from "./tag";

export interface ArticleQueryParams extends PageDomain {
  title?: string;
  status?: string;
  categoryId?: number;
}

export interface CmsArticle extends BaseEntity {
  articleId?: number;
  title?: string;
  slug?: string;
  summary?: string;
  cover?: string;
  content?: string;
  categoryId?: number;
  categoryName?: string;
  author?: string;
  status?: string;
  isTop?: string;
  viewCount?: number;
  wordCount?: number;
  readingTime?: number;
  publishTime?: string;
  tagIds?: number[];
  tags?: CmsTag[];
}
