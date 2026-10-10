import request from '@/utils/request'

// 查询题目列表
export function listMyQuestion(query) {
  return request({
    url: '/study/myQuestion/list',
    method: 'get',
    params: query
  })
}

// 查询题目详细
export function getMyQuestion(qId) {
  return request({
    url: '/study/myQuestion/' + qId,
    method: 'get'
  })
}

// 新增题目
export function addMyQuestion(data) {
  return request({
    url: '/study/myQuestion',
    method: 'post',
    data: data
  })
}

// 修改题目
export function updateMyQuestion(data) {
  return request({
    url: '/study/myQuestion',
    method: 'put',
    data: data
  })
}

// 删除题目
export function delMyQuestion(qId) {
  return request({
    url: '/study/myQuestion/' + qId,
    method: 'delete'
  })
}
