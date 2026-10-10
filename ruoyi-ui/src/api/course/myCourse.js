import request from '@/utils/request'

// 查询课程列表
export function listMyCourse(query) {
  return request({
    url: '/course/myCourse/list',
    method: 'get',
    params: query
  })
}

// 查询课程详细
export function getMyCourse(cId) {
  return request({
    url: '/course/myCourse/' + cId,
    method: 'get'
  })
}

// 新增课程
export function addMyCourse(data) {
  return request({
    url: '/course/myCourse',
    method: 'post',
    data: data
  })
}

// 修改课程
export function updateMyCourse(data) {
  return request({
    url: '/course/myCourse',
    method: 'put',
    data: data
  })
}

// 删除课程
export function delMyCourse(cId) {
  return request({
    url: '/course/myCourse/' + cId,
    method: 'delete'
  })
}
