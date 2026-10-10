import store from '@/store'
import config from '@/config'
import { getToken } from '@/utils/auth'
import errorCode from '@/utils/errorCode'
import { toast, showConfirm, tansParams } from '@/utils/common'

let timeout = 10000
const baseUrl = config.baseUrl

const request = config => {
  // 是否需要设置 token
  const isToken = (config.headers || {}).isToken === false
  config.header = config.header || {}
  if (getToken() && !isToken) {
    config.header['Authorization'] = 'Bearer ' + getToken()
  }
  // get请求映射params参数
  if (config.params) {
    let url = config.url + '?' + tansParams(config.params)
    url = url.slice(0, -1)
    config.url = url
  }
  return new Promise((resolve, reject) => {
    uni.request({
        method: config.method || 'get',
        timeout: config.timeout ||  timeout,
        url: config.baseUrl || baseUrl + config.url,
        data: config.data,
        header: config.header,
        dataType: 'json',
        success: res => {
        const data = res.data || {}
        const code = Number(data.code === undefined ? res.statusCode : data.code)
        const msg = data.msg || errorCode[code] || errorCode['default']
        if (code === 401 && !isToken) {
          showConfirm('登录状态已过期，您可以继续留在该页面，或者重新登录?').then(res => {
            if (res.confirm) {
              store.dispatch('LogOut').then(res => {
                uni.reLaunch({ url: '/pages/login' })
              })
            }
          })
          const error = new Error(msg)
          error.code = code
          reject(error)
          return
        } else if (code !== 200) {
          if (config.showError !== false) toast(msg)
          const error = new Error(msg)
          error.code = code
          reject(error)
          return
        }
        resolve(data)
      },
      fail: error => {
        let message = error.message || error.errMsg || '后端接口连接异常'
        if (message === 'Network Error') {
          message = '后端接口连接异常'
        } else if (/timeout/i.test(message)) {
          message = '系统接口请求超时'
        } else if (message.includes('Request failed with status code')) {
          message = '系统接口' + message.slice(-3) + '异常'
        } else if (message.includes('request:fail')) {
          message = '后端接口连接异常，请检查后端服务和网络'
        }
        if (config.showError !== false) toast(message)
        reject(new Error(message))
      }
      })
  })
}

export default request
