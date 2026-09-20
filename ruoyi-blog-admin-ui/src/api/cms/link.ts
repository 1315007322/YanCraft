import request from '@/utils/request'
import type { FriendLinkQueryParams, CmsFriendLink, AjaxResult, TableDataInfo } from '@/types'

export function listFriendLink(query: FriendLinkQueryParams): Promise<TableDataInfo<CmsFriendLink[]>> {
  return request({
    url: '/cms/link/list',
    method: 'get',
    params: query
  })
}

export function getFriendLink(linkId: number): Promise<AjaxResult<CmsFriendLink>> {
  return request({
    url: '/cms/link/' + linkId,
    method: 'get'
  })
}

export function addFriendLink(data: CmsFriendLink): Promise<AjaxResult> {
  return request({
    url: '/cms/link',
    method: 'post',
    data: data
  })
}

export function updateFriendLink(data: CmsFriendLink): Promise<AjaxResult> {
  return request({
    url: '/cms/link',
    method: 'put',
    data: data
  })
}

export function delFriendLink(linkId: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/cms/link/' + linkId,
    method: 'delete'
  })
}
