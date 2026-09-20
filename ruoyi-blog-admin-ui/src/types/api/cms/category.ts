import type { PageDomain, BaseEntity } from "../common";

export interface CategoryQueryParams extends PageDomain {
  name?: string;
  status?: string;
}

export interface CmsCategory extends BaseEntity {
  categoryId?: number;
  parentId?: number;
  name?: string;
  slug?: string;
  sort?: number;
  status?: string;
}
