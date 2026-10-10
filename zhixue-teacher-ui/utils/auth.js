const TokenKey = 'App-Token'
const TeacherIdKey = 'App-TeacherId'
const RealNameKey = 'App-RealName'
const RememberTokenKey = 'App-RememberToken'

export function getToken() {
  return uni.getStorageSync(TokenKey)
}

export function setToken(token) {
  return uni.setStorageSync(TokenKey, token)
}

export function removeToken() {
  uni.removeStorageSync(TokenKey)
  uni.removeStorageSync(TeacherIdKey)
  uni.removeStorageSync(RealNameKey)
}

export function getTeacherId() {
  return uni.getStorageSync(TeacherIdKey)
}

export function setTeacherId(teacherId) {
  return uni.setStorageSync(TeacherIdKey, teacherId)
}

export function removeTeacherId() {
  return uni.removeStorageSync(TeacherIdKey)
}

export function getRealName() {
  return uni.getStorageSync(RealNameKey)
}

export function setRealName(name) {
  return uni.setStorageSync(RealNameKey, name)
}

// 记住登录凭据(后端 Redis 30 天有效),仅本设备免密自动登录用
export function getRememberToken() {
  return uni.getStorageSync(RememberTokenKey)
}

export function setRememberToken(token) {
  return uni.setStorageSync(RememberTokenKey, token)
}

export function removeRememberToken() {
  return uni.removeStorageSync(RememberTokenKey)
}
