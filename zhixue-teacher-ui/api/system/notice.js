import request from '@/utils/request'

// 查询通知列表
export function listNotice(query) {
  return request({
    url: '/mxy/notice/list',
    method: 'get',
    params: query
  })
}

// 查询通知详细
export function getNotice(noticeId) {
  return request({
    url: '/mxy/notice/' + noticeId,
    method: 'get'
  })
}

// 新增通知
export function addNotice(data) {
  return request({
    url: '/mxy/notice',
    method: 'post',
    data: data
  })
}

// 修改通知
export function updateNotice(data) {
  return request({
    url: '/mxy/notice',
    method: 'put',
    data: data
  })
}

// 删除通知
export function delNotice(noticeId) {
  return request({
    url: '/mxy/notice/' + noticeId,
    method: 'delete'
  })
}

// 发布通知
export function publishNotice(data) {
  return request({
    url: '/mxy/notice/publish',
    method: 'post',
    data: data
  })
}
