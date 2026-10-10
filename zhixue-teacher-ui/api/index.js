import request from '@/utils/request'

// 获取待办数据
export function getTodoList() {
  return request({
    url: '/system/todo/list',
    method: 'GET'
  })
}

// 发布课程
export function publishCourse(data) {
  return request({
    url: '/system/course/add',
    method: 'POST',
    data
  })
}
// 获取系统通知
export function getNoticeList() {
  return request({
    url: '/system/notice/list',
    method: 'GET'
  })
}

// 发布通知(走 my_notification,教师端匿名接口 POST /mxy/notice)
export function publishNotice(data) {
  return request({
    url: '/mxy/notice',
    method: 'POST',
    data
  })
  }

// 发布作业
export function publishHomework(data) {
  return request({
    url: '/system/homework/add',
    method: 'POST',
    data
  })
  
}
export function searchData(data) {
  return request({
    url: '/system/search',
    method: 'POST',
    data
  })
}