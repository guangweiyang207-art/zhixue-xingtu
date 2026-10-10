import request from '@/utils/request'

// 查询错题本列表
export function listMyErrorBook(query) {
  return request({
    url: '/study/myErrorBook/list',
    method: 'get',
    params: query
  })
}

// 查询错题本详细
export function getMyErrorBook(ebId) {
  return request({
    url: '/study/myErrorBook/' + ebId,
    method: 'get'
  })
}

// 新增错题本
export function addMyErrorBook(data) {
  return request({
    url: '/study/myErrorBook',
    method: 'post',
    data: data
  })
}

// 修改错题本
export function updateMyErrorBook(data) {
  return request({
    url: '/study/myErrorBook',
    method: 'put',
    data: data
  })
}

// 删除错题本
export function delMyErrorBook(ebId) {
  return request({
    url: '/study/myErrorBook/' + ebId,
    method: 'delete'
  })
}
