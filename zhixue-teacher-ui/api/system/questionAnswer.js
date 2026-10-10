import request from '@/utils/request'

/**
 * 教师 ↔ 学生 问答(后端 my_question_answer 表)
 *  - 待回答列表(教师):GET /mxy/qa/list?teacherId=xx&status=0
 *  - 已回答列表(教师):GET /mxy/qa/list?teacherId=xx&status=1
 *  - 详情:GET  /mxy/qa/{id}
 *  - 老师回答:PUT  /mxy/qa/answer { id, answer, updateBy? }
 *
 *  注意:teacherId 不传时,后端会从 token 解析当前登录老师
 */

/** 教师:待回答问题列表 */
export function listTeacherInboxApi(params) {
  return request({
    url: '/mxy/qa/list',
    method: 'GET',
    params
  })
}

/** 详情 */
export function getQaDetailApi(id) {
  return request({
    url: '/mxy/qa/' + id,
    method: 'GET'
  })
}

/** 老师回答 */
export function answerQuestionApi(data) {
  return request({
    url: '/mxy/qa/answer',
    method: 'PUT',
    data
  })
}
