import type { PageDomain, BaseEntity } from "../common";

export interface FriendLinkQueryParams extends PageDomain {
  nickname?: string;
  status?: string;
  siteUrl?: string;
}

export interface CmsFriendLink extends BaseEntity {
  linkId?: number;
  nickname?: string;
  description?: string;
  siteUrl?: string;
  sort?: number;
  status?: string;
}
