import request from '@/utils/request'

// 查询教师列表
export function listTeacher() {
  return request({
    url: '/teacher/list',
    method: 'get'
  })
}

// 查询教师详细
export function getTeacher(teacherId) {
  return request({
    url: '/teacher/' + teacherId,
    method: 'get'
  })
}

// 新增教师
export function addTeacher(data) {
  return request({
    url: '/teacher',
    method: 'post',
    data
  })
}

// 修改教师
export function updateTeacher(data) {
  return request({
    url: '/teacher',
    method: 'put',
    data
  })
}

// 删除教师
export function delTeacher(teacherId) {
  return request({
    url: '/teacher/' + teacherId,
    method: 'delete'
  })
}

// 获取教师待办数量
export function getTeacherTodoCount() {
  return request({
    url: '/teacher/todo/count',
    method: 'get'
  })
}
