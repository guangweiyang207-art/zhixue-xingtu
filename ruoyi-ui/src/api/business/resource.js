import request from '@/utils/request'

// 查询资源模块列表
export function listResource(query) {
  return request({
    url: '/business/resource/list',
    method: 'get',
    params: query
  })
}

// 查询资源模块详细
export function getResource(reId) {
  return request({
    url: '/business/resource/' + reId,
    method: 'get'
  })
}

// 新增资源模块
export function addResource(data) {
  return request({
    url: '/business/resource',
    method: 'post',
    data: data
  })
}

// 修改资源模块
export function updateResource(data) {
  return request({
    url: '/business/resource',
    method: 'put',
    data: data
  })
}

// 删除资源模块
export function delResource(reId) {
  return request({
    url: '/business/resource/' + reId,
    method: 'delete'
  })
}
