import request from '@/utils/request'

// 查询课程资源列表
export function listCourseResource(query) {
  return request({
    url: '/system/courseResource/list',
    method: 'get',
    params: query
  })
}

// 查询课程资源详细
export function getCourseResource(resourceId) {
  return request({
    url: '/system/courseResource/' + resourceId,
    method: 'get'
  })
}

// 新增课程资源
export function addCourseResource(data) {
  return request({
    url: '/system/courseResource',
    method: 'post',
    data: data
  })
}

// 修改课程资源
export function updateCourseResource(data) {
  return request({
    url: '/system/courseResource',
    method: 'put',
    data: data
  })
}

// 删除课程资源
export function delCourseResource(resourceId) {
  return request({
    url: '/system/courseResource/' + resourceId,
    method: 'delete'
  })
}
