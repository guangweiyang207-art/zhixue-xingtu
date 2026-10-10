import request from '@/utils/request'

// 查询段位配置列表
export function listRankConfig(query) {
  return request({
    url: '/system/rankConfig/list',
    method: 'get',
    params: query
  })
}

// 查询段位配置详细
export function getRankConfig(rankId) {
  return request({
    url: '/system/rankConfig/' + rankId,
    method: 'get'
  })
}

// 新增段位配置
export function addRankConfig(data) {
  return request({
    url: '/system/rankConfig',
    method: 'post',
    data: data
  })
}

// 修改段位配置
export function updateRankConfig(data) {
  return request({
    url: '/system/rankConfig',
    method: 'put',
    data: data
  })
}

// 删除段位配置
export function delRankConfig(rankId) {
  return request({
    url: '/system/rankConfig/' + rankId,
    method: 'delete'
  })
}

// 查询所有段位
export function listAllRank() {
  return request({
    url: '/system/rankConfig/all',
    method: 'get'
  })
}
