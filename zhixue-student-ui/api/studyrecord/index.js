import config from '@/config'

const BASE = config.baseUrl + '/mine/study'

/** 获取学生基本信息 */
export function getProfile(stuId) {
  return new Promise((resolve, reject) => {
    uni.request({
      url: BASE + '/profile',
      data: { stu_id: stuId },
      success: (res) => resolve(res.data),
      fail: reject
    })
  })
}

/** 获取学习记录列表 */
export function getRecords(stuId) {
  return new Promise((resolve, reject) => {
    uni.request({
      url: BASE + '/records',
      data: { stu_id: stuId },
      success: (res) => resolve(res.data),
      fail: reject
    })
  })
}

/** 获取课程进度 */
export function getProgress(stuId) {
  return new Promise((resolve, reject) => {
    uni.request({
      url: BASE + '/progress',
      data: { stu_id: stuId },
      success: (res) => resolve(res.data),
      fail: reject
    })
  })
}

/** 获取学情报告（含最新报告 + 段位配置） */
export function getReports(stuId) {
  return new Promise((resolve, reject) => {
    uni.request({
      url: BASE + '/reports',
      data: { stu_id: stuId },
      success: (res) => resolve(res.data),
      fail: reject
    })
  })
}

// ==================== 工具函数 ====================

/** 正确率 → 样式类名 */
export function rateClass(p) {
  if (p >= 90) return 'rate-excellent'
  if (p >= 70) return 'rate-good'
  if (p >= 50) return 'rate-medium'
  return 'rate-low'
}

/** 课程状态 → 样式类名 */
export function statusClass(s) {
  if (s === 2) return 'status-done'
  if (s === 0) return 'status-quit'
  return 'status-ongoing'
}

/** 课程状态 → 中文文本 */
export function statusText(s) {
  if (s === 2) return '已完成'
  if (s === 0) return '已退课'
  return '进行中'
}

/** 报告类型 → 中文文本 */
export function typeText(t) {
  if (t === 1) return '日报'
  if (t === 2) return '周报'
  if (t === 3) return '月报'
  return '其他'
}

/** 解析JSON字符串字段（如 weak_points、strengths） */
export function tryParseJSON(obj, field) {
  if (!obj || !obj[field]) return
  if (typeof obj[field] === 'string') {
    try { obj[field] = JSON.parse(obj[field]) } catch (e) { /* keep as string */ }
  }
}