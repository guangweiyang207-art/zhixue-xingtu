import request from '@/utils/request'

// 账号密码登录
export function login(data) {
  return request({
    url: '/auth/login',
    method: 'post',
    data
  })
}

// 手机号验证码登录
export function loginPhone(data) {
  return request({
    url: '/auth/loginPhone',
    method: 'post',
    data
  })
}

// 注册
export function register(data) {
  return request({
    url: '/auth/register',
    method: 'post',
    data
  })
}

// 获取当前登录用户信息
export function getUserInfo() {
  return request({
    url: '/auth/info',
    method: 'get'
  })
}

// 退出登录
export function logout() {
  return request({
    url: '/auth/logout',
    method: 'post'
  })
}
