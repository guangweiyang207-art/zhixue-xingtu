import request from '@/utils/request'

export function getStudentHomeworkList() {
  return request({
    url: '/homework/homework/todayTodos',
    method: 'GET'
  })
}

export function getRecommendCourseApi() {
  return request({
    url: '/resource/resource/top2',
    method: 'GET'
  })
}

export function getHomeStatsApi() {
  return request({
    url: '/studyreport/report/latestDaily',
    method: 'GET'
  })
}

export function getHomeBannerApi() {
  return request({
    url: '/index/banner',
    method: 'GET'
  })
}

export function getTodayStudyDurationApi() {
  return request({
    url: '/studyRecord/today',
    method: 'GET'
  })
}

export function getUnreadNotificationCountApi() {
  return request({
    url: '/notification/unreadCount',
    method: 'GET'
  })
}

export function getMyRankInfoApi() {
  return request({
    url: '/rank/myRank',
    method: 'GET'
  })
}

export function getStudentInfoApi() {
  return request({
    url: '/student/myInfo',
    method: 'GET'
  })
}
