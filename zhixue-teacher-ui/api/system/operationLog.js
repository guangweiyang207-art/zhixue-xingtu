import request from '@/utils/request'

// 查询操作日志列表
export function listOperationLog(query) {
  return request({
    url: '/system/operationLog/list',
    method: 'get',
    params: query
  })
}

// 查询操作日志详细
export function getOperationLog(operId) {
  return request({
    url: '/system/operationLog/' + operId,
    method: 'get'
  })
}

// 删除操作日志
export function delOperationLog(operId) {
  return request({
    url: '/system/operationLog/' + operId,
    method: 'delete'
  })
}

// 清空操作日志
export function cleanOperationLog() {
  return request({
    url: '/system/operationLog/clean',
    method: 'delete'
  })
}
