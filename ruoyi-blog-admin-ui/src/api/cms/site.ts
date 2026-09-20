import request from '@/utils/request'
import type { AjaxResult, CmsSiteSetting } from '@/types'

export function getSiteSetting(): Promise<AjaxResult<CmsSiteSetting>> {
  return request({
    url: '/cms/site',
    method: 'get'
  })
}

export function updateSiteSetting(data: CmsSiteSetting): Promise<AjaxResult> {
  return request({
    url: '/cms/site',
    method: 'put',
    data
  })
}
