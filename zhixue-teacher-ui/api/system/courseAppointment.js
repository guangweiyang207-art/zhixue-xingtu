import request from '@/utils/request'

// 查询课程预约列表
export function listCourseAppointment(query) {
  return request({
    url: '/system/courseAppointment/list',
    method: 'get',
    params: query
  })
}

// 查询课程预约详细
export function getCourseAppointment(appointmentId) {
  return request({
    url: '/system/courseAppointment/' + appointmentId,
    method: 'get'
  })
}

// 新增课程预约
export function addCourseAppointment(data) {
  return request({
    url: '/system/courseAppointment',
    method: 'post',
    data: data
  })
}

// 修改课程预约
export function updateCourseAppointment(data) {
  return request({
    url: '/system/courseAppointment',
    method: 'put',
    data: data
  })
}

// 删除课程预约
export function delCourseAppointment(appointmentId) {
  return request({
    url: '/system/courseAppointment/' + appointmentId,
    method: 'delete'
  })
}

// 审核课程预约
export function auditCourseAppointment(data) {
  return request({
    url: '/system/courseAppointment/audit',
    method: 'put',
    data: data
  })
}
