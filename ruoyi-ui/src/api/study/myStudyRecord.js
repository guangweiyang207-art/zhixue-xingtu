import request from '@/utils/request'

// 查询学习记录列表
export function listMyStudyRecord(query) {
  return request({
    url: '/study/myStudyRecord/list',
    method: 'get',
    params: query
  })
}

// 查询学习记录详细
export function getMyStudyRecord(srId) {
  return request({
    url: '/study/myStudyRecord/' + srId,
    method: 'get'
  })
}

// 新增学习记录
export function addMyStudyRecord(data) {
  return request({
    url: '/study/myStudyRecord',
    method: 'post',
    data: data
  })
}

// 修改学习记录
export function updateMyStudyRecord(data) {
  return request({
    url: '/study/myStudyRecord',
    method: 'put',
    data: data
  })
}

// 删除学习记录
export function delMyStudyRecord(srId) {
  return request({
    url: '/study/myStudyRecord/' + srId,
    method: 'delete'
  })
}
