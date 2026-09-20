import request from '@/utils/request'
import type { CategoryQueryParams, CmsCategory, AjaxResult, TableDataInfo } from '@/types'

export function listCategory(query: CategoryQueryParams): Promise<TableDataInfo<CmsCategory[]>> {
  return request({
    url: '/cms/category/list',
    method: 'get',
    params: query
  })
}

export function getCategory(categoryId: number): Promise<AjaxResult<CmsCategory>> {
  return request({
    url: '/cms/category/' + categoryId,
    method: 'get'
  })
}

export function addCategory(data: CmsCategory): Promise<AjaxResult> {
  return request({
    url: '/cms/category',
    method: 'post',
    data: data
  })
}

export function updateCategory(data: CmsCategory): Promise<AjaxResult> {
  return request({
    url: '/cms/category',
    method: 'put',
    data: data
  })
}

export function delCategory(categoryId: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/cms/category/' + categoryId,
    method: 'delete'
  })
}
