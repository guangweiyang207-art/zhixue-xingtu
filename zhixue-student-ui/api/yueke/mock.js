export const mockCourseList = [
  {
    c_id: 1,
    name: '初中物理：力学基础突破',
    teacher: '张明老师',
    time: '周六 14:00 - 15:30',
    duration: '1.5小时',
    count: '24/30人',
    enrolled: 24,
    total: 30,
    type: 'physics',
    icon: '⚛',
    rating: 4.9,
    lessons: 12
  },
  {
    c_id: 2,
    name: '英语口语：模拟面试实战',
    teacher: '王蕾老师',
    time: '周日 10:00 - 11:30',
    duration: '1.5小时',
    count: '12/20人',
    enrolled: 12,
    total: 20,
    type: 'english',
    icon: '文A',
    rating: 4.7,
    lessons: 8
  },
  {
    c_id: 3,
    name: '高中数学：函数专题精讲',
    teacher: '陈伟老师',
    time: '周五 19:00 - 20:30',
    duration: '1.5小时',
    count: '18/25人',
    enrolled: 18,
    total: 25,
    type: 'math',
    icon: '📐',
    rating: 4.8,
    lessons: 15
  },
  {
    c_id: 4,
    name: '语文阅读：古诗词鉴赏',
    teacher: '刘芳老师',
    time: '周三 16:00 - 17:30',
    duration: '1.5小时',
    count: '8/20人',
    enrolled: 8,
    total: 20,
    type: 'chinese',
    icon: '📖',
    rating: 4.6,
    lessons: 10
  }
]

function mockSuccess(data) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({ code: 200, msg: '操作成功', data })
    }, 300)
  })
}

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

export function mockReserveCourse(data) {
  console.log('Mock: 课程预约请求 404', data)
  return mockError404()
}

export function mockGetMyReserve(stuId) {
  console.log('Mock: 获取我的预约列表 404', stuId)
  return mockError404()
}

export function mockCancelReserve(caId) {
  console.log('Mock: 取消预约 404', caId)
  return mockError404()
}

export function mockGetCourseList(type) {
  console.log('Mock: 获取课程列表 404, type:', type)
  return mockError404()
}

export function mockGetHotCourse() {
  console.log('Mock: 获取热门课程 404')
  return mockError404()
}

export function mockGetCourseDetail(cId) {
  console.log('Mock: 获取课程详情 404, cId:', cId)
  return mockError404()
}

export function mockGetCourseTypes() {
  console.log('Mock: 获取课程分类 404')
  return mockError404()
}