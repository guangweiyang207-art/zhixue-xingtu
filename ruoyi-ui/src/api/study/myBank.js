import request from '@/utils/request'

// 查询题库列表
export function listMyBank(query) {
  return request({
    url: '/study/myBank/list',
    method: 'get',
    params: query
  })
}

// 查询题库详细
export function getMyBank(hbId) {
  return request({
    url: '/study/myBank/' + hbId,
    method: 'get'
  })
}

// 新增题库
export function addMyBank(data) {
  return request({
    url: '/study/myBank',
    method: 'post',
    data: data
  })
}

// 修改题库
export function updateMyBank(data) {
  return request({
    url: '/study/myBank',
    method: 'put',
    data: data
  })
}

// 删除题库
export function delMyBank(hbId) {
  return request({
    url: '/study/myBank/' + hbId,
    method: 'delete'
  })
}
