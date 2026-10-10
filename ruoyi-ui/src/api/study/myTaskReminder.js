import request from '@/utils/request'

// 查询任务提醒列表
export function listMyTaskReminder(query) {
  return request({
    url: '/study/myTaskReminder/list',
    method: 'get',
    params: query
  })
}

// 查询任务提醒详细
export function getMyTaskReminder(trId) {
  return request({
    url: '/study/myTaskReminder/' + trId,
    method: 'get'
  })
}

// 新增任务提醒
export function addMyTaskReminder(data) {
  return request({
    url: '/study/myTaskReminder',
    method: 'post',
    data: data
  })
}

// 修改任务提醒
export function updateMyTaskReminder(data) {
  return request({
    url: '/study/myTaskReminder',
    method: 'put',
    data: data
  })
}

// 删除任务提醒
export function delMyTaskReminder(trId) {
  return request({
    url: '/study/myTaskReminder/' + trId,
    method: 'delete'
  })
}
