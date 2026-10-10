import request from '@/utils/request.js'
import { mockGetRankInfo, mockGetRecentRecords, mockGetUserProfile } from './mock.js'

const USE_MOCK = false

export function getUserProfileApi(stuId) {
  if (USE_MOCK) return mockGetUserProfile(stuId)
  return request({
    url: '/mine/user/profile',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

export function getRankInfoApi(stuId) {
  if (USE_MOCK) return mockGetRankInfo(stuId)
  return request({
    url: '/mine/rank/info',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

export function getRecentRecordsApi(stuId) {
  if (USE_MOCK) return mockGetRecentRecords(stuId)
  return request({
    url: '/mine/study/recent',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

/** 获取个人设置(姓名/手机/邮箱/学校班级) */
export function getSettingsApi(stuId) {
  return request({
    url: '/mine/user/settings',
    method: 'GET',
    params: { stu_id: stuId }
  })
}

/** 保存个人设置 */
export function updateSettingsApi(stuId, data) {
  return request({
    url: '/mine/user/settings',
    method: 'PUT',
    params: { stu_id: stuId },
    data
  })
}

/** 修改密码 */
export function updatePwdApi(stuId, data) {
  return request({
    url: '/mine/user/updatePwd',
    method: 'PUT',
    params: { stu_id: stuId },
    data
  })
}