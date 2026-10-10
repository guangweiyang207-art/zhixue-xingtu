import request from '@/utils/request'

export function getStudentInfoApi() {
  return request({
    url: '/student/myInfo',
    method: 'GET'
  })
}

export function updateStudentInfoApi(data) {
  return request({
    url: '/student/update',
    method: 'PUT',
    data
  })
}

export function getStudentListApi(params) {
  return request({
    url: '/student/list',
    method: 'GET',
    params
  })
}

export function getStudentDetailApi(stuId) {
  return request({
    url: '/student/' + stuId,
    method: 'GET'
  })
}

export function getStudentCoursesApi(params) {
  return request({
    url: '/student/myCourses',
    method: 'GET',
    params
  })
}

export function getStudentHomeworkStatusApi() {
  return request({
    url: '/student/homeworkStatus',
    method: 'GET'
  })
}

export function getStudentStudyStatsApi() {
  return request({
    url: '/student/studyStats',
    method: 'GET'
  })
}

export function getStudentRankApi() {
  return request({
    url: '/student/rank',
    method: 'GET'
  })
}