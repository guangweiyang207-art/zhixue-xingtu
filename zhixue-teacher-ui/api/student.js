import request from '@/utils/request'

// 获取所有不重复的班级名称(给发布作业表单用)
export function listClassNames() {
  return request({
    url: '/student/class-names',
    method: 'get'
  })
}
