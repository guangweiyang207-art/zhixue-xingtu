function mockError404() {
  return new Promise((_, reject) => {
    setTimeout(() => {
      reject({
        code: 404,
        msg: '请求的接口不存在，请先实现后端接口'
      })
    }, 300)
  })
}

export function mockUpdateProfile(data) {
  console.log('Mock: 更新个人设置 404', data)
  return mockError404()
}