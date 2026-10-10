import request from '@/utils/request'

export function getMyStudyReportApi(type) {
  return request({
    url: '/studyReport/myReport',
    method: 'GET',
    params: { reportType: type }
  })
}

export function getStudyReportListApi(params) {
  return request({
    url: '/studyReport/list',
    method: 'GET',
    params
  })
}

export function getStudyReportDetailApi(reportId) {
  return request({
    url: '/studyReport/' + reportId,
    method: 'GET'
  })
}

export function generateStudyReportApi(reportType) {
  return request({
    url: '/studyReport/generate',
    method: 'POST',
    data: { reportType }
  })
}

export function getGlobalReportApi(params) {
  return request({
    url: '/studyReport/global',
    method: 'GET',
    params
  })
}

export function getRecentStudyTrendApi() {
  return request({
    url: '/studyReport/recentTrend',
    method: 'GET'
  })
}

export function getWeakPointsApi() {
  return request({
    url: '/studyReport/weakPoints',
    method: 'GET'
  })
}