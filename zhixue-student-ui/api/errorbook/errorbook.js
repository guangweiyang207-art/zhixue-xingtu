import request from '@/utils/request.js'

/**
 * 获取错题列表
 * @param {Object} params - { stu_id: number, subject: string }
 */
export function getErrorListApi(params) {
  return request({
    url: '/errorbook/list',
    method: 'GET',
    params
  })
}

/**
 * 获取错题统计概览
 * @param {Object} params - { stu_id: number }
 */
export function getErrorStatsApi(params) {
  return request({
    url: '/errorbook/stats',
    method: 'GET',
    params
  })
}