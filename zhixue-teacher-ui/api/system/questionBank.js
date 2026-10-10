import request from '@/utils/request'

// 查询题库列表
export function listQuestionBank(query) {
  return request({
    url: '/mxy/questionBank/list',
    method: 'get',
    params: query
  })
}

// 查询题库详细
export function getQuestionBank(questionId) {
  return request({
    url: '/mxy/questionBank/' + questionId,
    method: 'get'
  })
}

// 新增题库
export function addQuestionBank(data) {
  return request({
    url: '/mxy/questionBank',
    method: 'post',
    data: data
  })
}

// 修改题库
export function updateQuestionBank(data) {
  return request({
    url: '/mxy/questionBank',
    method: 'put',
    data: data
  })
}

// 删除题库
export function delQuestionBank(questionId) {
  return request({
    url: '/mxy/questionBank/' + questionId,
    method: 'delete'
  })
}

// 批量导入题目
export function importQuestionBank(data) {
  return request({
    url: '/mxy/questionBank/import',
    method: 'post',
    data: data
  })
}

// 根据分类查询题目
export function listQuestionByCategory(categoryId) {
  return request({
    url: '/mxy/questionBank/category/' + categoryId,
    method: 'get'
  })
}
