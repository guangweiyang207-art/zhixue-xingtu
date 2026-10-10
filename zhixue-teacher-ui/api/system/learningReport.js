import request from '@/utils/request'

// 查询学情报表数据列表
export function listLearningReport(query) {
  return request({
    url: '/system/learningReport/list',
    method: 'get',
    params: query
  })
}

// 查询学情报表数据详细
export function getLearningReport(reportId) {
  return request({
    url: '/system/learningReport/' + reportId,
    method: 'get'
  })
}

// 新增学情报表数据
export function addLearningReport(data) {
  return request({
    url: '/system/learningReport',
    method: 'post',
    data: data
  })
}

// 修改学情报表数据
export function updateLearningReport(data) {
  return request({
    url: '/system/learningReport',
    method: 'put',
    data: data
  })
}

// 删除学情报表数据
export function delLearningReport(reportId) {
  return request({
    url: '/system/learningReport/' + reportId,
    method: 'delete'
  })
}

// 查询我的学情报表
export function getMyLearningReport(query) {
  return request({
    url: '/system/learningReport/my',
    method: 'get',
    params: query
  })
}
