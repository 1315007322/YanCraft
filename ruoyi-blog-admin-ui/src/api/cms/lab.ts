import request from '@/utils/request'
import type { LabProjectQueryParams, CmsLabProject, AjaxResult, TableDataInfo } from '@/types'

export function listLabProject(query: LabProjectQueryParams): Promise<TableDataInfo<CmsLabProject[]>> {
  return request({
    url: '/cms/lab/list',
    method: 'get',
    params: query
  })
}

export function getLabProject(projectId: number): Promise<AjaxResult<CmsLabProject>> {
  return request({
    url: '/cms/lab/' + projectId,
    method: 'get'
  })
}

export function addLabProject(data: CmsLabProject): Promise<AjaxResult> {
  return request({
    url: '/cms/lab',
    method: 'post',
    data: data
  })
}

export function updateLabProject(data: CmsLabProject): Promise<AjaxResult> {
  return request({
    url: '/cms/lab',
    method: 'put',
    data: data
  })
}

export function delLabProject(projectId: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/cms/lab/' + projectId,
    method: 'delete'
  })
}
