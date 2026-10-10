import request from '@/utils/request'

// 登录方法
export function login(username, password, code, uuid) {
  const data = {
    username,
    password,
    code,
    uuid
  }
  return request({
    'url': '/login',
    headers: {
      isToken: false
    },
    'method': 'post',
    'data': data
  })
}

// my_sys_user 登录方法
export function myLogin(username, password, code, uuid) {
  const data = {
    username,
    password,
    code,
    uuid
  }
  return request({
    'url': '/myauth/login',
    showError: false,
    headers: {
      isToken: false
    },
    'method': 'post',
    'data': data
  })
}

// 注册方法(my_sys_user 体系,注册后可直接用 /myauth/login 登录)
export function register(data) {
  return request({
    url: '/myauth/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 获取用户详细信息
export function getInfo() {
  return request({
    'url': '/getInfo',
    'method': 'get'
  })
}

// 退出方法
export function logout() {
  return request({
    'url': '/logout',
    'method': 'post'
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    'url': '/captchaImage',
    headers: {
      isToken: false
    },
    method: 'get',
    timeout: 20000
  })
}
