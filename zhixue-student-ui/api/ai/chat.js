import request from '@/utils/request'

export function sendChatMessageApi(data) {
  return request({
    url: '/ai/chat',
    method: 'POST',
    data
  })
}

export function getChatHistoryApi(sessionId) {
  return request({
    url: '/ai/chat/history',
    method: 'GET',
    params: { sessionId }
  })
}

export function getChatSessionsApi() {
  return request({
    url: '/ai/chat/sessions',
    method: 'GET'
  })
}

export function createChatSessionApi() {
  return request({
    url: '/ai/chat/session',
    method: 'POST'
  })
}

export function deleteChatSessionApi(sessionId) {
  return request({
    url: '/ai/chat/session/' + sessionId,
    method: 'DELETE'
  })
}

export function rateChatAnswerApi(chatId, isSatisfied) {
  return request({
    url: '/ai/chat/rate',
    method: 'PUT',
    data: { chatId, isSatisfied }
  })
}