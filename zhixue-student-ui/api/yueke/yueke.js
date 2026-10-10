import request from '@/utils/request.js'
import {
  mockReserveCourse,
  mockGetMyReserve,
  mockCancelReserve,
  mockGetCourseList,
  mockGetHotCourse,
  mockGetCourseDetail,
  mockGetCourseTypes
} from './mock.js'

const USE_MOCK = false

export function getCourseDetailApi(cId) {
  if (USE_MOCK) return mockGetCourseDetail(cId)
  return request({
    url: '/course/detail',
    method: 'GET',
    params: { c_id: cId }
  })
}

export function getHotCourseApi() {
  if (USE_MOCK) return mockGetHotCourse()
  return request({
    url: '/course/hot',
    method: 'GET'
  })
}

export function reserveCourseApi(data) {
  if (USE_MOCK) return mockReserveCourse(data)
  return request({
    url: '/course/appointment/add',
    method: 'POST',
    data
  })
}

export function getMyReserveApi(stuId) {
  if (USE_MOCK) return mockGetMyReserve(stuId)
  return request({
    url: '/course/appointment/myList',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

export function cancelReserveApi(caId) {
  if (USE_MOCK) return mockCancelReserve(caId)
  return request({
    url: '/course/appointment/cancel',
    method: 'POST',
    data: { ca_id: caId }
  })
}

export function getCourseListApi(type) {
  if (USE_MOCK) return mockGetCourseList(type)
  return request({
    url: '/course/list',
    method: 'GET',
    params: { type }
  })
}

export function getCourseTypesApi() {
  if (USE_MOCK) return mockGetCourseTypes()
  return request({
    url: '/course/types',
    method: 'GET'
  })
}