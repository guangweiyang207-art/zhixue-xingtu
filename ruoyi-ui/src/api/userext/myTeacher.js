import request from '@/utils/request'

// 查询教师列表
export function listMyTeacher(query) {
  return request({
    url: '/userext/myTeacher/list',
    method: 'get',
    params: query
  })
}

// 查询教师详细
export function getMyTeacher(teacherId) {
  return request({
    url: '/userext/myTeacher/' + teacherId,
    method: 'get'
  })
}

// 新增教师
export function addMyTeacher(data) {
  return request({
    url: '/userext/myTeacher',
    method: 'post',
    data: data
  })
}

// 修改教师
export function updateMyTeacher(data) {
  return request({
    url: '/userext/myTeacher',
    method: 'put',
    data: data
  })
}

// 删除教师
export function delMyTeacher(teacherId) {
  return request({
    url: '/userext/myTeacher/' + teacherId,
    method: 'delete'
  })
}
