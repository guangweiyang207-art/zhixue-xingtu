import request from '@/utils/request'

// 课程列表
export function listCourse(query) {
  return request({
    url: '/mxy/course/list',
    method: 'get',
    params: query
  })
}

// 课程详情
export function getCourse(cId) {
  return request({
    url: '/mxy/course/' + cId,
    method: 'get'
  })
}

// 发布课程(后端 publish() 自动从 token 注入 teacher_id,字段全部由后端默认填齐)
export function publishCourse(data) {
  return request({
    url: '/mxy/course/publish',
    method: 'post',
    data: data
  })
}

// 发布课程(旧 add 入口,保留兼容)
export function addCourse(data) {
  return request({
    url: '/mxy/course',
    method: 'post',
    data: data
  })
}

// 修改课程
export function updateCourse(data) {
  return request({
    url: '/mxy/course',
    method: 'put',
    data: data
  })
}

// 删除课程
export function delCourse(cId) {
  return request({
    url: '/mxy/course/' + cId,
    method: 'delete'
  })
}
