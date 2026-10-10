import request from '@/utils/request'
import upload from '@/utils/upload'

// 我的"页面头部基本信息(姓名/头像/教龄/学生数等)
export function getTeacherInfo() {
  return request({
    url: '/mxy/teacher/info',
    method: 'get'
  })
}

// ===== 账号设置 =====

// 获取完整账号信息
export function getTeacherAccount() {
  return request({
    url: '/mxy/teacher/account',
    method: 'get'
  })
}

// 更新账号信息
export function updateTeacherAccount(data) {
  return request({
    url: '/mxy/teacher/account',
    method: 'put',
    data: data
  })
}

// 上传头像
export function uploadTeacherAvatar(filePath) {
  return upload({
    url: '/mxy/teacher/avatar',
    name: 'file',
    filePath: filePath
  })
}

// 修改密码
export function updateTeacherPwd(oldPassword, newPassword) {
  return request({
    url: '/mxy/teacher/password',
    method: 'put',
    data: { oldPassword, newPassword }
  })
}
