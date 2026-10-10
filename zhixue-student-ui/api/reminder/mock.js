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

export function mockGetReminderList() {
  console.log('Mock: 获取提醒列表 404')
  return mockError404()
}

export function mockAddReminder(data) {
  console.log('Mock: 添加提醒 404', data)
  return mockError404()
}