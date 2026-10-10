import request from '@/utils/request'

// 查询段位配置列表
export function listMyRankConfig(query) {
  return request({
    url: '/study/myRankConfig/list',
    method: 'get',
    params: query
  })
}

// 查询段位配置详细
export function getMyRankConfig(rankId) {
  return request({
    url: '/study/myRankConfig/' + rankId,
    method: 'get'
  })
}

// 新增段位配置
export function addMyRankConfig(data) {
  return request({
    url: '/study/myRankConfig',
    method: 'post',
    data: data
  })
}

// 修改段位配置
export function updateMyRankConfig(data) {
  return request({
    url: '/study/myRankConfig',
    method: 'put',
    data: data
  })
}

// 删除段位配置
export function delMyRankConfig(rankId) {
  return request({
    url: '/study/myRankConfig/' + rankId,
    method: 'delete'
  })
}
