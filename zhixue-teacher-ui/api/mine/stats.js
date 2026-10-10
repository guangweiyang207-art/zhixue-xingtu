import request from '@/utils/request'

// 教学统计聚合(后端一次性返回所有指标)
export function getTeacherStats() {
  return request({
    url: '/mxy/teacher/stats',
    method: 'get'
  })
}
