import request from "@/utils/request"
import type { AjaxResult, TableDataInfo, TaskItem, TaskItemQueryParams, TaskStatistics } from "@/types"

export function listTask(query: TaskItemQueryParams): Promise<TableDataInfo<TaskItem>> {
  return request({
    url: "/task/item/list",
    method: "get",
    params: query
  })
}

export function getTask(taskId: number): Promise<AjaxResult<TaskItem>> {
  return request({
    url: "/task/item/" + taskId,
    method: "get"
  })
}

export function getTaskStatistics(): Promise<AjaxResult<TaskStatistics>> {
  return request({
    url: "/task/item/statistics",
    method: "get"
  })
}

export function listRootTaskOptions(excludeTaskId?: number): Promise<AjaxResult<TaskItem[]>> {
  return request({
    url: "/task/item/root-options",
    method: "get",
    params: { excludeTaskId }
  })
}

export function addTask(data: TaskItem): Promise<AjaxResult> {
  return request({
    url: "/task/item",
    method: "post",
    data
  })
}

export function updateTask(data: TaskItem): Promise<AjaxResult> {
  return request({
    url: "/task/item",
    method: "put",
    data
  })
}

export function updateTaskProgress(taskId: number, progress: number): Promise<AjaxResult> {
  return request({
    url: `/task/item/${taskId}/progress`,
    method: "put",
    data: { progress }
  })
}

export function updateTaskQuantity(taskId: number, completedQuantity: number): Promise<AjaxResult> {
  return request({
    url: `/task/item/${taskId}/quantity`,
    method: "put",
    data: { completedQuantity }
  })
}

export function delTask(taskIds: number | number[]): Promise<AjaxResult> {
  return request({
    url: "/task/item/" + taskIds,
    method: "delete"
  })
}
