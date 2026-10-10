import request from '@/utils/request.js'

export function getMyCourseListApi(stuId, status) {
  return request({
    url: '/course/appointment/myList',
    method: 'GET',
    params: { stu_id: stuId, status: status }
  })
}

export function cancelReserveApi(caId) {
  return request({
    url: '/course/appointment/cancel',
    method: 'POST',
    data: { ca_id: caId }
  })
}