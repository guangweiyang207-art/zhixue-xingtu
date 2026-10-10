import request from '@/utils/request'

export function getRankConfigListApi() {
  return request({
    url: '/rank/configList',
    method: 'GET'
  })
}

export function getMyRankApi() {
  return request({
    url: '/rank/myRank',
    method: 'GET'
  })
}

export function getRankListApi() {
  return request({
    url: '/rank/list',
    method: 'GET'
  })
}

export function getStudentRankingApi(params) {
  return request({
    url: '/rank/studentRanking',
    method: 'GET',
    params
  })
}

export function getRankProgressApi() {
  return request({
    url: '/rank/progress',
    method: 'GET'
  })
}