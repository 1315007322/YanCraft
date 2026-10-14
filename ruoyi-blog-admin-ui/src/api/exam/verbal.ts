import request from "@/utils/request"
import type { AjaxResult, ExamVerbalCard, ExamVerbalQuery, TableDataInfo } from "@/types"

export function listVerbalCard(query: ExamVerbalQuery): Promise<TableDataInfo<ExamVerbalCard>> {
  return request({
    url: "/exam/verbal/list",
    method: "get",
    params: query
  })
}

export function getVerbalCard(cardId: number): Promise<AjaxResult<ExamVerbalCard>> {
  return request({
    url: "/exam/verbal/" + cardId,
    method: "get"
  })
}

export function addVerbalCard(data: ExamVerbalCard): Promise<AjaxResult> {
  return request({
    url: "/exam/verbal",
    method: "post",
    data
  })
}

export function updateVerbalCard(data: ExamVerbalCard): Promise<AjaxResult> {
  return request({
    url: "/exam/verbal",
    method: "put",
    data
  })
}

export function delVerbalCard(cardIds: number | number[]): Promise<AjaxResult> {
  return request({
    url: "/exam/verbal/" + cardIds,
    method: "delete"
  })
}
