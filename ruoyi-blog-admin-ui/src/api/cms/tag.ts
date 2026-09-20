import request from '@/utils/request'
import type { TagQueryParams, CmsTag, AjaxResult, TableDataInfo } from '@/types'

export function listTag(query: TagQueryParams): Promise<TableDataInfo<CmsTag[]>> {
  return request({
    url: '/cms/tag/list',
    method: 'get',
    params: query
  })
}

export function getTag(tagId: number): Promise<AjaxResult<CmsTag>> {
  return request({
    url: '/cms/tag/' + tagId,
    method: 'get'
  })
}

export function addTag(data: CmsTag): Promise<AjaxResult> {
  return request({
    url: '/cms/tag',
    method: 'post',
    data: data
  })
}

export function updateTag(data: CmsTag): Promise<AjaxResult> {
  return request({
    url: '/cms/tag',
    method: 'put',
    data: data
  })
}

export function delTag(tagId: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/cms/tag/' + tagId,
    method: 'delete'
  })
}
