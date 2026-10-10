import request from '@/utils/request'

export function getCourseListApi(params) {
  return request({
    url: '/course/list',
    method: 'GET',
    params
  })
}

export function getCourseDetailApi(cId) {
  return request({
    url: '/course/' + cId,
    method: 'GET'
  })
}

export function addCourseApi(data) {
  return request({
    url: '/course',
    method: 'POST',
    data
  })
}

export function updateCourseApi(data) {
  return request({
    url: '/course',
    method: 'PUT',
    data
  })
}

export function deleteCourseApi(cId) {
  return request({
    url: '/course/' + cId,
    method: 'DELETE'
  })
}

export function enrollCourseApi(data) {
  return request({
    url: '/course/enroll',
    method: 'POST',
    data
  })
}

export function getMyCoursesApi(params) {
  return request({
    url: '/course/myList',
    method: 'GET',
    params
  })
}

export function getCourseStudentsApi(cId) {
  return request({
    url: '/course/' + cId + '/students',
    method: 'GET'
  })
}