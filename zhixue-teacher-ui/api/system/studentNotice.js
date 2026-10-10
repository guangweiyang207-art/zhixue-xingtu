import request from '@/utils/request'

// 查询学生通知阅读记录列表
export function listStudentNotice(query) {
  return request({
    url: '/system/studentNotice/list',
    method: 'get',
    params: query
  })
}

// 查询学生通知阅读记录详细
export function getStudentNotice(id) {
  return request({
    url: '/system/studentNotice/' + id,
    method: 'get'
  })
}

// 标记通知已读
export function readNotice(data) {
  return request({
    url: '/system/studentNotice/read',
    method: 'post',
    data: data
  })
}

// 查询我的通知
export function listMyNotice(query) {
  return request({
    url: '/system/studentNotice/my',
    method: 'get',
    params: query
  })
}

// 查询未读通知数量
export function getUnreadNoticeCount() {
  return request({
    url: '/system/studentNotice/unreadCount',
    method: 'get'
  })
}

// 标记所有通知已读
export function readAllNotice() {
  return request({
    url: '/system/studentNotice/readAll',
    method: 'put'
  })
}
