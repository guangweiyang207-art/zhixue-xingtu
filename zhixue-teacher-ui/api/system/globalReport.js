import request from '@/utils/request'

// 查询全局数据报表统计列表
export function listGlobalReport(query) {
  return request({
    url: '/system/globalReport/list',
    method: 'get',
    params: query
  })
}

// 查询全局数据报表统计详细
export function getGlobalReport(reportId) {
  return request({
    url: '/system/globalReport/' + reportId,
    method: 'get'
  })
}

// 新增全局数据报表统计
export function addGlobalReport(data) {
  return request({
    url: '/system/globalReport',
    method: 'post',
    data: data
  })
}

// 修改全局数据报表统计
export function updateGlobalReport(data) {
  return request({
    url: '/system/globalReport',
    method: 'put',
    data: data
  })
}

// 删除全局数据报表统计
export function delGlobalReport(reportId) {
  return request({
    url: '/system/globalReport/' + reportId,
    method: 'delete'
  })
}

// 获取全局统计数据
export function getGlobalStatistics() {
  return request({
    url: '/system/globalReport/statistics',
    method: 'get'
  })
}
