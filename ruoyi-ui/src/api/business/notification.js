import request from '@/utils/request'

// 查询通知模块列表
export function listNotification(query) {
  return request({
    url: '/business/notification/list',
    method: 'get',
    params: query
  })
}

// 查询通知模块详细
export function getNotification(notiId) {
  return request({
    url: '/business/notification/' + notiId,
    method: 'get'
  })
}

// 新增通知模块
export function addNotification(data) {
  return request({
    url: '/business/notification',
    method: 'post',
    data: data
  })
}

// 修改通知模块
export function updateNotification(data) {
  return request({
    url: '/business/notification',
    method: 'put',
    data: data
  })
}

// 删除通知模块
export function delNotification(notiId) {
  return request({
    url: '/business/notification/' + notiId,
    method: 'delete'
  })
}
