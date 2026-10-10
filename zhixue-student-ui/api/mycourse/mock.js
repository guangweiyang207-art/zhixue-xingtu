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

export function mockGetMyCourseList() {
  console.log('Mock: 获取已选课程列表 404')
  return mockError404()
}