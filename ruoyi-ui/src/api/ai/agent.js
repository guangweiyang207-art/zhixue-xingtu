import request from '@/utils/request'

// 发送消息给AI助手
// AI调用（尤其是带数据库分析上下文时）耗时较长，默认10秒超时不够，这里显式延长到120秒
export function sendMessage(data) {
  return request({
    url: '/ai/agent/chat',
    method: 'post',
    data: data,
    timeout: 120000
  })
}

// 获取AI配置
export function getAiConfig() {
  return request({
    url: '/ai/agent/config',
    method: 'get'
  })
}

// 更新AI配置
export function updateAiConfig(data) {
  return request({
    url: '/ai/agent/config',
    method: 'post',
    data: data
  })
}
