import request from "@/utils/request"
import type { AiConfigQueryParams, AjaxResult, SysAiConfig, TableDataInfo } from "@/types"

export function listAiConfig(query: AiConfigQueryParams): Promise<TableDataInfo<SysAiConfig>> {
  return request({
    url: "/system/ai/list",
    method: "get",
    params: query
  })
}

export function getAiConfig(configId: number): Promise<AjaxResult<SysAiConfig>> {
  return request({
    url: "/system/ai/" + configId,
    method: "get"
  })
}

export function listAiOptions(purpose?: string): Promise<AjaxResult<SysAiConfig[]>> {
  return request({
    url: "/system/ai/options",
    method: "get",
    params: purpose ? { purpose } : {}
  })
}

export function addAiConfig(data: SysAiConfig): Promise<AjaxResult> {
  return request({
    url: "/system/ai",
    method: "post",
    data
  })
}

export function updateAiConfig(data: SysAiConfig): Promise<AjaxResult> {
  return request({
    url: "/system/ai",
    method: "put",
    data
  })
}

export function delAiConfig(configId: number | number[]): Promise<AjaxResult> {
  return request({
    url: "/system/ai/" + configId,
    method: "delete"
  })
}

export function generateAiImage(data: { configId?: number; prompt: string; size?: string }): Promise<AjaxResult<string> & { url?: string; fileName?: string }> {
  return request({
    url: "/system/ai/image",
    method: "post",
    data,
    timeout: 180000,
    headers: { repeatSubmit: false }
  })
}

export function generateAiChat(data: { configId?: number; prompt: string }): Promise<AjaxResult<string>> {
  return request({
    url: "/system/ai/chat",
    method: "post",
    data,
    timeout: 120000,
    headers: { repeatSubmit: false }
  })
}
