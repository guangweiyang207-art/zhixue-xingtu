import request from '@/utils/request'

export function getStudyRecordListApi(params) {
  return request({
    url: '/studyRecord/list',
    method: 'GET',
    params
  })
}

export function addStudyRecordApi(data) {
  return request({
    url: '/studyRecord',
    method: 'POST',
    data
  })
}

export function getTodayStudyRecordApi() {
  return request({
    url: '/studyRecord/today',
    method: 'GET'
  })
}

export function getStudyRecordStatsApi(params) {
  return request({
    url: '/studyRecord/stats',
    method: 'GET',
    params
  })
}

export function getWeeklyStudyRecordApi() {
  return request({
    url: '/studyRecord/weekly',
    method: 'GET'
  })
}

export function getStudyDurationRankApi() {
  return request({
    url: '/studyRecord/durationRank',
    method: 'GET'
  })
}