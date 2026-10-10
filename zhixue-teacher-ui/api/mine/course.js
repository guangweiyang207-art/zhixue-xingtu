import request from '@/utils/request'

// 查询"我发布的"课程列表(后端按 teacherId 自动过滤)
export function listMyCourses() {
  return request({
    url: '/mxy/teacher/courses',
    method: 'get'
  })
}

// 查询单个课程详情
export function getCourse(courseId) {
  return request({
    url: '/mxy/course/' + courseId,
    method: 'get'
  })
}

// 修改课程(走 MXYCourseController 通用 PUT)
export function updateCourse(data) {
  return request({
    url: '/mxy/course',
    method: 'put',
    data: data
  })
}

// 删除课程
export function delCourse(courseId) {
  return request({
    url: '/mxy/course/' + courseId,
    method: 'delete'
  })
}
