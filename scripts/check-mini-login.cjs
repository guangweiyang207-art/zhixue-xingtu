const assert = require('node:assert/strict')
const fs = require('node:fs')
const path = require('node:path')
const vm = require('node:vm')

async function checkClient(project) {
  const source = fs.readFileSync(path.join(__dirname, '..', project, 'utils/request.js'), 'utf8')
    .replace(/^import .*$/gm, '')
    .replace('export default request', 'module.exports = request')
  const toasts = []
  let reply
  let confirms = 0
  const context = {
    module: { exports: {} },
    config: { baseUrl: 'http://localhost:8081' },
    getToken: () => '',
    errorCode: { default: '未知错误' },
    toast: message => toasts.push(message),
    showConfirm: () => { confirms++; return Promise.resolve({ confirm: false }) },
    tansParams: () => '',
    store: {},
    uni: { request: options => reply(options) }
  }
  vm.runInNewContext(source, context)
  const request = context.module.exports
  const login = { url: '/login', headers: { isToken: false }, showError: false }

  reply = options => options.success({ statusCode: 200, data: { code: 500, msg: '验证码错误' } })
  await assert.rejects(request({ ...login }), error => error.message === '验证码错误' && error.code === 500)
  assert.equal(toasts.length, 0, '登录页应只显示一次错误')

  reply = options => options.fail({ errMsg: 'request:fail connect ECONNREFUSED' })
  await assert.rejects(request({ ...login }), /后端接口连接异常/)
  reply = options => options.fail({ errMsg: 'request:fail timeout' })
  await assert.rejects(request({ ...login }), /系统接口请求超时/)

  reply = options => options.success({ statusCode: 401, data: { code: 401, msg: '密码错误' } })
  await assert.rejects(request({ ...login }), /密码错误/)
  assert.equal(confirms, 0, '未登录请求不能弹登录过期对话框')

  reply = options => options.success({ statusCode: 200, data: { code: 200, token: 'test-token' } })
  assert.equal((await request({ ...login })).token, 'test-token')
  console.log(`${project}: 登录错误传递、网络错误、超时、401 和成功响应检查通过`)
}

Promise.all(['zhixue-student-ui', 'zhixue-teacher-ui'].map(checkClient)).catch(error => {
  console.error(error)
  process.exitCode = 1
})
