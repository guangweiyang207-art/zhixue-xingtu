import request from '@/utils/request'

// 查询错题本列表
export function listWrongQuestion(query) {
  return request({
    url: '/system/wrongQuestion/list',
    method: 'get',
    params: query
  })
}

// 查询错题本详细
export function getWrongQuestion(id) {
  return request({
    url: '/system/wrongQuestion/' + id,
    method: 'get'
  })
}

// 新增错题
export function addWrongQuestion(data) {
  return request({
    url: '/system/wrongQuestion',
    method: 'post',
    data: data
  })
}

// 修改错题
export function updateWrongQuestion(data) {
  return request({
    url: '/system/wrongQuestion',
    method: 'put',
    data: data
  })
}

// 删除错题
export function delWrongQuestion(id) {
  return request({
    url: '/system/wrongQuestion/' + id,
    method: 'delete'
  })
}

// 标记错题已掌握
export function masterWrongQuestion(id) {
  return request({
    url: '/system/wrongQuestion/master/' + id,
    method: 'put'
  })
}

// 查询我的错题本
export function listMyWrongQuestion(query) {
  return request({
    url: '/system/wrongQuestion/my',
    method: 'get',
    params: query
  })
}
