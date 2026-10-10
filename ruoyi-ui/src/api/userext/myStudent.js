import request from '@/utils/request'

// 查询学生列表
export function listMyStudent(query) {
  return request({
    url: '/userext/myStudent/list',
    method: 'get',
    params: query
  })
}

// 查询学生详细
export function getMyStudent(stuId) {
  return request({
    url: '/userext/myStudent/' + stuId,
    method: 'get'
  })
}

// 新增学生
export function addMyStudent(data) {
  return request({
    url: '/userext/myStudent',
    method: 'post',
    data: data
  })
}

// 修改学生
export function updateMyStudent(data) {
  return request({
    url: '/userext/myStudent',
    method: 'put',
    data: data
  })
}

// 删除学生
export function delMyStudent(stuId) {
  return request({
    url: '/userext/myStudent/' + stuId,
    method: 'delete'
  })
}
