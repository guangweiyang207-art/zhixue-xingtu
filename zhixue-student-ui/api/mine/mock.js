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

export function mockGetRankInfo() {
  console.log('Mock: 获取段位信息 404')
  return mockError404()
}

export function mockGetRecentRecords() {
  console.log('Mock: 获取最近做题记录 404')
  return mockError404()
}

export function mockGetUserProfile() {
  console.log('Mock: 获取用户个人信息 404')
  return mockError404()
}