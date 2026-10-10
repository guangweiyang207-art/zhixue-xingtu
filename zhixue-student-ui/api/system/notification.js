import request from '@/utils/request'

export function getNotificationListApi(params) {
  return request({
    url: '/notification/list',
    method: 'GET',
    params
  })
}

export function getNotificationDetailApi(notiId) {
  return request({
    url: '/notification/' + notiId,
    method: 'GET'
  })
}

export function addNotificationApi(data) {
  return request({
    url: '/notification',
    method: 'POST',
    data
  })
}

export function updateNotificationApi(data) {
  return request({
    url: '/notification',
    method: 'PUT',
    data
  })
}

export function deleteNotificationApi(notiId) {
  return request({
    url: '/notification/' + notiId,
    method: 'DELETE'
  })
}

export function getMyNotificationsApi(params) {
  return request({
    url: '/notification/my',
    method: 'GET',
    params
  })
}

export function markNotificationReadApi(notiId) {
  return request({
    url: '/notification/read/' + notiId,
    method: 'PUT'
  })
}

export function markAllNotificationsReadApi() {
  return request({
    url: '/notification/readAll',
    method: 'PUT'
  })
}

export function getUnreadNotificationCountApi() {
  return request({
    url: '/notification/unreadCount',
    method: 'GET'
  })
}