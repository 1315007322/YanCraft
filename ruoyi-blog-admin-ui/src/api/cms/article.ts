import request from '@/utils/request'
import type { ArticleQueryParams, CmsArticle, AjaxResult, TableDataInfo } from '@/types'

export function listArticle(query: ArticleQueryParams): Promise<TableDataInfo<CmsArticle[]>> {
  return request({
    url: '/cms/article/list',
    method: 'get',
    params: query
  })
}

export function getArticle(articleId: number): Promise<AjaxResult<CmsArticle>> {
  return request({
    url: '/cms/article/' + articleId,
    method: 'get'
  })
}

export function addArticle(data: CmsArticle): Promise<AjaxResult> {
  return request({
    url: '/cms/article',
    method: 'post',
    data: data
  })
}

export function updateArticle(data: CmsArticle): Promise<AjaxResult> {
  return request({
    url: '/cms/article',
    method: 'put',
    data: data
  })
}

export function delArticle(articleId: number | number[]): Promise<AjaxResult> {
  return request({
    url: '/cms/article/' + articleId,
    method: 'delete'
  })
}

export function publishArticle(articleId: number): Promise<AjaxResult> {
  return request({
    url: '/cms/article/publish/' + articleId,
    method: 'put'
  })
}

export function offlineArticle(articleId: number): Promise<AjaxResult> {
  return request({
    url: '/cms/article/offline/' + articleId,
    method: 'put'
  })
}
