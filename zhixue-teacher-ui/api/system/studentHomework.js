import request from '@/utils/request'

// 查询学生作业提交列表
export function listStudentHomework(query) {
  return request({
    url: '/system/studentHomework/list',
    method: 'get',
    params: query
  })
}

// 查询学生作业提交详细
export function getStudentHomework(id) {
  return request({
    url: '/system/studentHomework/' + id,
    method: 'get'
  })
}

// 提交作业
export function submitHomework(data) {
  return request({
    url: '/system/studentHomework',
    method: 'post',
    data: data
  })
}

// 批改作业
export function gradeHomework(data) {
  return request({
    url: '/system/studentHomework/grade',
    method: 'put',
    data: data
  })
}

// 查询我的作业
export function listMyHomework(query) {
  return request({
    url: '/system/studentHomework/my',
    method: 'get',
    params: query
  })
}
