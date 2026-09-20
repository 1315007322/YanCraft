import type { PageDomain, BaseEntity } from "../common";

export interface TagQueryParams extends PageDomain {
  name?: string;
}

export interface CmsTag extends BaseEntity {
  tagId?: number;
  name?: string;
  slug?: string;
}
