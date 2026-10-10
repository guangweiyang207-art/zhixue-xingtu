import request from '@/utils/request'

// 查询任务提醒列表
export function listTaskReminder(query) {
  return request({
    url: '/system/taskReminder/list',
    method: 'get',
    params: query
  })
}

// 查询任务提醒详细
export function getTaskReminder(taskId) {
  return request({
    url: '/system/taskReminder/' + taskId,
    method: 'get'
  })
}

// 新增任务提醒
export function addTaskReminder(data) {
  return request({
    url: '/system/taskReminder',
    method: 'post',
    data: data
  })
}

// 修改任务提醒
export function updateTaskReminder(data) {
  return request({
    url: '/system/taskReminder',
    method: 'put',
    data: data
  })
}

// 删除任务提醒
export function delTaskReminder(taskId) {
  return request({
    url: '/system/taskReminder/' + taskId,
    method: 'delete'
  })
}

// 查询我的任务提醒
export function listMyTaskReminder(query) {
  return request({
    url: '/system/taskReminder/my',
    method: 'get',
    params: query
  })
}

// 标记任务完成
export function completeTaskReminder(taskId) {
  return request({
    url: '/system/taskReminder/complete/' + taskId,
    method: 'put'
  })
}
