import request from '@/utils/request'

// 查询全局报表列表
export function listMyGlobalReport(query) {
  return request({
    url: '/study/myGlobalReport/list',
    method: 'get',
    params: query
  })
}

// 查询全局报表详细
export function getMyGlobalReport(grId) {
  return request({
    url: '/study/myGlobalReport/' + grId,
    method: 'get'
  })
}

// 新增全局报表
export function addMyGlobalReport(data) {
  return request({
    url: '/study/myGlobalReport',
    method: 'post',
    data: data
  })
}

// 修改全局报表
export function updateMyGlobalReport(data) {
  return request({
    url: '/study/myGlobalReport',
    method: 'put',
    data: data
  })
}

// 删除全局报表
export function delMyGlobalReport(grId) {
  return request({
    url: '/study/myGlobalReport/' + grId,
    method: 'delete'
  })
}
