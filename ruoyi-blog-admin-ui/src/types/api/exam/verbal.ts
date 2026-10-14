import type { BaseEntity, PageDomain } from "../../common"

export interface ExamVerbalQuery extends PageDomain {
  keyword?: string
  cardType?: string
}

export interface ExamVerbalCard extends BaseEntity {
  cardId?: number
  cardType?: string
  prompt?: string
  difference?: string
  collocation?: string
  confusion?: string
  ownSentence?: string
  intervalDays?: number
  dueDate?: string
  reviewCount?: number
}
