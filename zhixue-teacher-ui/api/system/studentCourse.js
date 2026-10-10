import request from '@/utils/request'

// 查询学生选课列表
export function listStudentCourse(query) {
  return request({
    url: '/system/studentCourse/list',
    method: 'get',
    params: query
  })
}

// 查询学生选课详细
export function getStudentCourse(id) {
  return request({
    url: '/system/studentCourse/' + id,
    method: 'get'
  })
}

// 新增学生选课
export function addStudentCourse(data) {
  return request({
    url: '/system/studentCourse',
    method: 'post',
    data: data
  })
}

// 退选课程
export function dropStudentCourse(id) {
  return request({
    url: '/system/studentCourse/drop/' + id,
    method: 'delete'
  })
}

// 查询我的课程
export function listMyCourse() {
  return request({
    url: '/system/studentCourse/my',
    method: 'get'
  })
}
