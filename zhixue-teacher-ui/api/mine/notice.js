import request from '@/utils/request'

// 查询消息通知列表
export function listNotice(query) {
  return request({
    url: '/mine/notice/list',
    method: 'get',
    params: query
  })
}

// 查询消息通知详情
export function getNotice(noticeId) {
  return request({
    url: '/mine/notice/' + noticeId,
    method: 'get'
  })
}

// 标记消息为已读
export function readNotice(noticeId) {
  return request({
    url: '/mine/notice/read/' + noticeId,
    method: 'put'
  })
}

// 标记消息为未读
export function unreadNotice(noticeId) {
  return request({
    url: '/mine/notice/unread/' + noticeId,
    method: 'put'
  })
}

// 删除消息通知
export function delNotice(noticeId) {
  return request({
    url: '/mine/notice/' + noticeId,
    method: 'delete'
  })
}

// 查询未读消息数量
export function getUnreadCount() {
  return request({
    url: '/mine/notice/unreadCount',
    method: 'get'
  })
}
