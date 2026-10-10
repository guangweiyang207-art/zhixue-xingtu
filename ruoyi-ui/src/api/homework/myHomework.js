import request from '@/utils/request'

// 查询作业列表
export function listMyHomework(query) {
  return request({
    url: '/homework/myHomework/list',
    method: 'get',
    params: query
  })
}

// 查询作业详细
export function getMyHomework(hwId) {
  return request({
    url: '/homework/myHomework/' + hwId,
    method: 'get'
  })
}

// 新增作业
export function addMyHomework(data) {
  return request({
    url: '/homework/myHomework',
    method: 'post',
    data: data
  })
}

// 修改作业
export function updateMyHomework(data) {
  return request({
    url: '/homework/myHomework',
    method: 'put',
    data: data
  })
}

// 删除作业
export function delMyHomework(hwId) {
  return request({
    url: '/homework/myHomework/' + hwId,
    method: 'delete'
  })
}
