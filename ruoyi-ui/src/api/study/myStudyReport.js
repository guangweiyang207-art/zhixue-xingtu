import request from '@/utils/request'

// 查询学情报表列表
export function listMyStudyReport(query) {
  return request({
    url: '/study/myStudyReport/list',
    method: 'get',
    params: query
  })
}

// 查询学情报表详细
export function getMyStudyReport(reportId) {
  return request({
    url: '/study/myStudyReport/' + reportId,
    method: 'get'
  })
}

// 新增学情报表
export function addMyStudyReport(data) {
  return request({
    url: '/study/myStudyReport',
    method: 'post',
    data: data
  })
}

// 修改学情报表
export function updateMyStudyReport(data) {
  return request({
    url: '/study/myStudyReport',
    method: 'put',
    data: data
  })
}

// 删除学情报表
export function delMyStudyReport(reportId) {
  return request({
    url: '/study/myStudyReport/' + reportId,
    method: 'delete'
  })
}
