import request from '@/utils/request'

// 查询AI问答记录列表
export function listAiChat(query) {
  return request({
    url: '/mxy/aiChat/list',
    method: 'get',
    params: query
  })
}

// 查询AI问答记录详细
export function getAiChat(chatId) {
  return request({
    url: '/mxy/aiChat/' + chatId,
    method: 'get'
  })
}

// 新增AI问答记录
export function addAiChat(data) {
  return request({
    url: '/mxy/aiChat',
    method: 'post',
    data: data
  })
}

// 删除AI问答记录
export function delAiChat(chatId) {
  return request({
    url: '/mxy/aiChat/' + chatId,
    method: 'delete'
  })
}

// 查询我的AI问答记录
export function listMyAiChat(query) {
  return request({
    url: '/mxy/aiChat/my',
    method: 'get',
    params: query
  })
}

// 发送AI消息
export function sendAiMessage(data) {
  return request({
    url: '/system/aiChat/send',
    method: 'post',
    data: data
  })
}
