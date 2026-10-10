import request from '@/utils/request'

/**
 * 学生 ↔ 老师 问答接口
 *  - 列表:GET  /mxy/qa/list?stuId=xx&teacherId=xx&status=xx
 *  - 详情:GET  /mxy/qa/{id}
 *  - 提问:POST /mxy/qa/ask      { stuId, teacherId, question, createBy? }
 *  - 老师回答:PUT  /mxy/qa/answer { id, answer, updateBy? }
 *  - 修改:PUT  /mxy/qa           { id, status?, ... }
 *  - 删除:DELETE /mxy/qa/{id}
 */

/** 学生:我提的问题列表 */
export function listMyQuestionsApi(params) {
  return request({
    url: '/mxy/qa/list',
    method: 'GET',
    params
  })
}

/** 学生:提问 */
export function askQuestionApi(data) {
  return request({
    url: '/mxy/qa/ask',
    method: 'POST',
    data
  })
}

/** 老师:收到的提问列表 */
export function listTeacherInboxApi(params) {
  return request({
    url: '/mxy/qa/list',
    method: 'GET',
    params
  })
}

/** 老师:回答 */
export function answerQuestionApi(data) {
  return request({
    url: '/mxy/qa/answer',
    method: 'PUT',
    data
  })
}

/** 详情 */
export function getQaDetailApi(id) {
  return request({
    url: '/mxy/qa/' + id,
    method: 'GET'
  })
}

/** 删除 */
export function deleteQaApi(id) {
  return request({
    url: '/mxy/qa/' + id,
    method: 'DELETE'
  })
}
