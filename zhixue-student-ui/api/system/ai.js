import request from '@/utils/request'

export function aiChatApi(data) {
  return request({
    url: '/ai/assistant/chat',
    method: 'POST',
    data
  })
}
