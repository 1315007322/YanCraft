import type { PageDomain, BaseEntity } from "../common";

export interface LabProjectQueryParams extends PageDomain {
  projectName?: string;
  status?: string;
}

export interface CmsLabProject extends BaseEntity {
  projectId?: number;
  projectName?: string;
  description?: string;
  repoUrl?: string;
  previewUrl?: string;
  cover?: string;
  sort?: number;
  status?: string;
}
