import request from '@/utils/request'

export function getTeacherInfoApi() {
  return request({
    url: '/teacher/myInfo',
    method: 'GET'
  })
}

export function updateTeacherInfoApi(data) {
  return request({
    url: '/teacher/update',
    method: 'PUT',
    data
  })
}

export function getTeacherListApi(params) {
  return request({
    url: '/teacher/list',
    method: 'GET',
    params
  })
}

export function getTeacherDetailApi(teacherId) {
  return request({
    url: '/teacher/' + teacherId,
    method: 'GET'
  })
}

export function getTeacherCoursesApi() {
  return request({
    url: '/teacher/myCourses',
    method: 'GET'
  })
}

export function getTeacherStudentsApi(params) {
  return request({
    url: '/teacher/myStudents',
    method: 'GET',
    params
  })
}

export function getTeacherStatsApi() {
  return request({
    url: '/teacher/stats',
    method: 'GET'
  })
}