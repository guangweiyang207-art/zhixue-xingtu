import request from '@/utils/request'

// ============================
// 马孝银业务用户表 my_sys_user 的 CRUD
// 注意:不走 RuoYi 自带的 sys_user(管理员),那条路径保留给 /system/user
// ============================

// 查询用户列表
export function listMyUser(query) {
  return request({
    url: '/mxy/user/list',
    method: 'get',
    params: query
  })
}

// 查询用户详细
export function getMyUser(userId) {
  return request({
    url: '/mxy/user/' + userId,
    method: 'get'
  })
}

// 新增用户
export function addMyUser(data) {
  return request({
    url: '/mxy/user',
    method: 'post',
    data: data
  })
}

// 修改用户
export function updateMyUser(data) {
  return request({
    url: '/mxy/user',
    method: 'put',
    data: data
  })
}

// 删除用户
export function delMyUser(userId) {
  return request({
    url: '/mxy/user/' + userId,
    method: 'delete'
  })
}
