import request from '@/utils/request'

// 查询AI问答记录列表
export function listMyAiChat(query) {
  return request({
    url: '/study/myAiChat/list',
    method: 'get',
    params: query
  })
}

// 查询AI问答记录详细
export function getMyAiChat(chatId) {
  return request({
    url: '/study/myAiChat/' + chatId,
    method: 'get'
  })
}

// 新增AI问答记录
export function addMyAiChat(data) {
  return request({
    url: '/study/myAiChat',
    method: 'post',
    data: data
  })
}

// 修改AI问答记录
export function updateMyAiChat(data) {
  return request({
    url: '/study/myAiChat',
    method: 'put',
    data: data
  })
}

// 删除AI问答记录
export function delMyAiChat(chatId) {
  return request({
    url: '/study/myAiChat/' + chatId,
    method: 'delete'
  })
}
