import request from '@/utils/request'

// 作业列表
export function listHomework(query) {
  return request({
    url: '/homework/list',
    method: 'get',
    params: query
  })
}

// 待批改作业详情(根据提交记录 shId)
export function getHomeworkDetail(shId) {
  return request({
    url: '/homework/detail/' + shId,
    method: 'get'
  })
}

// 提交批改
export function submitGrade(data) {
  return request({
    url: '/homework/grade',
    method: 'post',
    data: data
  })
}

// 作业详情
export function getHomework(homeworkId) {
  return request({
    url: '/homework/' + homeworkId,
    method: 'get'
  })
}

// 教师"发布作业"专用接口(按班级自动派发给所有学生)
export function publishHomework(data) {
  return request({
    url: '/homework/publish',
    method: 'post',
    data: data
  })
}

// 兼容旧调用(等同 publishHomework)
export function addHomework(data) {
  return request({
    url: '/homework/publish',
    method: 'post',
    data: data
  })
}

// 新增作业(草稿)
export function addHomeworkDraft(data) {
  return request({
    url: '/homework',
    method: 'post',
    data: data
  })
}

// 修改作业
export function updateHomework(data) {
  return request({
    url: '/homework',
    method: 'put',
    data: data
  })
}

// 删除作业
export function delHomework(homeworkId) {
  return request({
    url: '/homework/' + homeworkId,
    method: 'delete'
  })
}
