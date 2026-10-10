import request from '@/utils/request'

export function getHomeworkListApi(params) {
  return request({
    url: '/homework/homework/list',
    method: 'GET',
    params
  })
}

export function getHomeworkDetailApi(hwId) {
  return request({
    url: '/studenthomework/homework/detail/' + hwId,
    method: 'GET'
  })
}

export function getStudentHomeworkList() {
  return request({
    url: '/homework/homework/todayTodos',
    method: 'GET'
  })
}

export function getStudentHomeworkListApi(params) {
  return request({
    url: '/studenthomework/homework/list',
    method: 'GET',
    params
  })
}

export function submitHomeworkApi(data) {
  return request({
    url: '/studenthomework/homework/submit',
    method: 'POST',
    data
  })
}

/** 学生端"我的作业":返回当前登录学生所有作业(待完成/已提交/已批改) */
export function getMyHomeworkListApi() {
  return request({
    url: '/studenthomework/homework/myList',
    method: 'GET',
    params: { _t: Date.now() }
  })
}

/** 学生作答用题目列表(不含正确答案) */
export function getHomeworkQuestionsApi(hwId) {
  return request({
    url: '/studenthomework/homework/questions/' + hwId,
    method: 'GET'
  })
}
