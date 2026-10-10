import request from '@/utils/request.js'

export function getSettingsApi(stuId) {
  return request({
    url: '/mine/user/settings',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

export function updateSettingsApi(stuId, data) {
  return request({
    url: '/mine/user/settings',
    method: 'PUT',
    params: { stu_id: stuId },
    data
  })
}