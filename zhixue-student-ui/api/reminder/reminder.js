import request from '@/utils/request.js'

export function getReminderListApi(stuId) {
  return request({
    url: '/reminder/list',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

export function addReminderApi(stuId, data) {
  return request({
    url: '/reminder/add',
    method: 'POST',
    params: { stu_id: stuId },
    data
  })
}

export function deleteReminderApi(trId) {
  return request({
    url: '/reminder/' + trId,
    method: 'DELETE'
  })
}

export function getReminderByIdApi(trId) {
  return request({
    url: '/reminder/' + trId,
    method: 'GET'
  })
}

export function updateReminderApi(trId, data) {
  return request({
    url: '/reminder/' + trId,
    method: 'PUT',
    data
  })
}

export function countRemindersApi(stuId) {
  return request({
    url: '/reminder/count',
    method: 'GET',
    params: { stu_id: stuId }
  })
}