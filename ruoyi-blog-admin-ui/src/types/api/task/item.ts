import type { BaseEntity, PageDomain } from "../../common"

export interface TaskItemQueryParams extends PageDomain {
  keyword?: string
  status?: string
  priority?: string
  params?: Record<string, any>
}

export interface TaskItem extends BaseEntity {
  taskId?: number
  parentId?: number
  ownerUserId?: number
  taskName?: string
  description?: string
  status?: string
  priority?: string
  progress?: number
  totalQuantity?: number
  completedQuantity?: number
  planStartDate?: string
  dueDate?: string
  completedTime?: string
  sort?: number
  overdue?: boolean
  hasChildren?: boolean
  children?: TaskItem[]
}

export interface TaskStatistics {
  total: number
  inProgress: number
  upcoming: number
  overdue: number
  completed: number
}
