import request from '@/utils/request'

// 查询作业题目列表
export function listHomeworkQuestion(query) {
  return request({
    url: '/system/homeworkQuestion/list',
    method: 'get',
    params: query
  })
}

// 查询作业题目详细
export function getHomeworkQuestion(questionId) {
  return request({
    url: '/system/homeworkQuestion/' + questionId,
    method: 'get'
  })
}

// 新增作业题目
export function addHomeworkQuestion(data) {
  return request({
    url: '/system/homeworkQuestion',
    method: 'post',
    data: data
  })
}

// 修改作业题目
export function updateHomeworkQuestion(data) {
  return request({
    url: '/system/homeworkQuestion',
    method: 'put',
    data: data
  })
}

// 删除作业题目
export function delHomeworkQuestion(questionId) {
  return request({
    url: '/system/homeworkQuestion/' + questionId,
    method: 'delete'
  })
}

// 根据作业ID查询题目列表
export function listQuestionByHomeworkId(homeworkId) {
  return request({
    url: '/system/homeworkQuestion/homework/' + homeworkId,
    method: 'get'
  })
}
