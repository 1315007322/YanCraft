import type { PageDomain, BaseEntity } from "../common"

export type AiPurpose = "chat" | "image"

export interface AiConfigQueryParams extends PageDomain {
  configName?: string
  purpose?: AiPurpose | string
  status?: string
}

export interface SysAiConfig extends BaseEntity {
  configId?: number
  configName?: string
  purpose?: AiPurpose | string
  baseUrl?: string
  apiKey?: string
  hasApiKey?: string
  modelName?: string
  timeoutSeconds?: number
  maxTokens?: number
  imageSize?: string
  systemPrompt?: string
  isDefault?: string
  status?: string
  sort?: number
}
