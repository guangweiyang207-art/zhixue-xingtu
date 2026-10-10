import request from '@/utils/request'

export function getQuestionListApi(params) {
  return request({
    url: '/question/list',
    method: 'GET',
    params
  })
}

export function getQuestionDetailApi(qId) {
  return request({
    url: '/question/' + qId,
    method: 'GET'
  })
}

export function addQuestionApi(data) {
  return request({
    url: '/question',
    method: 'POST',
    data
  })
}

export function updateQuestionApi(data) {
  return request({
    url: '/question',
    method: 'PUT',
    data
  })
}

export function deleteQuestionApi(qId) {
  return request({
    url: '/question/' + qId,
    method: 'DELETE'
  })
}

export function getQuestionBankListApi(params) {
  return request({
    url: '/questionBank/list',
    method: 'GET',
    params
  })
}

export function getQuestionBankDetailApi(bId) {
  return request({
    url: '/questionBank/' + bId,
    method: 'GET'
  })
}

export function addQuestionBankApi(data) {
  return request({
    url: '/questionBank',
    method: 'POST',
    data
  })
}

export function updateQuestionBankApi(data) {
  return request({
    url: '/questionBank',
    method: 'PUT',
    data
  })
}

export function deleteQuestionBankApi(bId) {
  return request({
    url: '/questionBank/' + bId,
    method: 'DELETE'
  })
}

export function getBankQuestionsApi(bId) {
  return request({
    url: '/questionBank/' + bId + '/questions',
    method: 'GET'
  })
}

export function addQuestionToBankApi(data) {
  return request({
    url: '/questionBank/addQuestion',
    method: 'POST',
    data
  })
}