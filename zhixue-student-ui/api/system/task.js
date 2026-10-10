import request from '@/utils/request'

export function getTaskReminderListApi(params) {
  return request({
    url: '/task/list',
    method: 'GET',
    params
  })
}

export function getTaskReminderDetailApi(trId) {
  return request({
    url: '/task/' + trId,
    method: 'GET'
  })
}

export function addTaskReminderApi(data) {
  return request({
    url: '/task',
    method: 'POST',
    data
  })
}

export function updateTaskReminderApi(data) {
  return request({
    url: '/task',
    method: 'PUT',
    data
  })
}

export function deleteTaskReminderApi(trId) {
  return request({
    url: '/task/' + trId,
    method: 'DELETE'
  })
}

export function getMyTaskRemindersApi() {
  return request({
    url: '/task/my',
    method: 'GET'
  })
}

export function markTaskReadApi(trId) {
  return request({
    url: '/task/read/' + trId,
    method: 'PUT'
  })
}

export function cancelTaskReminderApi(trId) {
  return request({
    url: '/task/cancel/' + trId,
    method: 'PUT'
  })
}