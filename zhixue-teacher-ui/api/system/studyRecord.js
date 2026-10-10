import request from '@/utils/request'

// 查询学习记录列表
export function listStudyRecord(query) {
  return request({
    url: '/system/studyRecord/list',
    method: 'get',
    params: query
  })
}

// 查询学习记录详细
export function getStudyRecord(recordId) {
  return request({
    url: '/system/studyRecord/' + recordId,
    method: 'get'
  })
}

// 新增学习记录
export function addStudyRecord(data) {
  return request({
    url: '/system/studyRecord',
    method: 'post',
    data: data
  })
}

// 修改学习记录
export function updateStudyRecord(data) {
  return request({
    url: '/system/studyRecord',
    method: 'put',
    data: data
  })
}

// 删除学习记录
export function delStudyRecord(recordId) {
  return request({
    url: '/system/studyRecord/' + recordId,
    method: 'delete'
  })
}

// 查询我的学习记录
export function listMyStudyRecord(query) {
  return request({
    url: '/system/studyRecord/my',
    method: 'get',
    params: query
  })
}

// 统计学习时长
export function getStudyDuration() {
  return request({
    url: '/system/studyRecord/duration',
    method: 'get'
  })
}
