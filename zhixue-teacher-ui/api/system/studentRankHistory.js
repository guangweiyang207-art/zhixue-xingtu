import request from '@/utils/request'

// 查询学生段位历史记录列表
export function listStudentRankHistory(query) {
  return request({
    url: '/system/studentRankHistory/list',
    method: 'get',
    params: query
  })
}

// 查询学生段位历史记录详细
export function getStudentRankHistory(id) {
  return request({
    url: '/system/studentRankHistory/' + id,
    method: 'get'
  })
}

// 新增学生段位历史记录
export function addStudentRankHistory(data) {
  return request({
    url: '/system/studentRankHistory',
    method: 'post',
    data: data
  })
}

// 删除学生段位历史记录
export function delStudentRankHistory(id) {
  return request({
    url: '/system/studentRankHistory/' + id,
    method: 'delete'
  })
}

// 查询我的段位历史
export function listMyRankHistory(query) {
  return request({
    url: '/system/studentRankHistory/my',
    method: 'get',
    params: query
  })
}

// 查询当前段位
export function getCurrentRank() {
  return request({
    url: '/system/studentRankHistory/current',
    method: 'get'
  })
}
