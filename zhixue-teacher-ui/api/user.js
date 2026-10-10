import request from '@/utils/request'

// 查询用户列表
export function listUser() {
  return request({
    url: '/sysUser/list',
    method: 'get'
  })
}

// 查询用户详细
export function getUser(userId) {
  return request({
    url: '/sysUser/' + userId,
    method: 'get'
  })
}

// 根据用户名查询
export function getUserByUsername(username) {
  return request({
    url: '/sysUser/getByUsername?username=' + username,
    method: 'get'
  })
}

// 新增用户
export function addUser(data) {
  return request({
    url: '/sysUser',
    method: 'post',
    data
  })
}

// 修改用户
export function updateUser(data) {
  return request({
    url: '/sysUser',
    method: 'put',
    data
  })
}

// 删除用户
export function delUser(userId) {
  return request({
    url: '/sysUser/' + userId,
    method: 'delete'
  })
}
