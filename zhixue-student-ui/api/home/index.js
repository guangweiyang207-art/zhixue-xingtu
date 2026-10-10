import request from '@/utils/request'
import {
  mockGetHomeIndex,
  mockGetHomeBanners,
  mockGetHomeQuickLinks,
  mockGetHomeTodos,
  mockGetHomeCourses,
  mockGetHomeStats
} from './mock'

/**
 * 是否使用 Mock 数据
 * 后端接口就绪后改为 false，并确保 config.baseUrl 指向你的后端地址
 */
const USE_MOCK = true

/**
 * 获取主页聚合数据（推荐）
 * GET /edu/home/index
 */
export function getHomeIndex() {
  if (USE_MOCK) return mockGetHomeIndex()
  return request({
    url: '/edu/home/index',
    method: 'get'
  })
}

/**
 * 获取轮播图
 * GET /edu/home/banners
 */
export function getHomeBanners() {
  if (USE_MOCK) return mockGetHomeBanners()
  return request({
    url: '/edu/home/banners',
    method: 'get'
  })
}

/**
 * 获取快捷入口
 * GET /edu/home/quick-links
 */
export function getHomeQuickLinks() {
  if (USE_MOCK) return mockGetHomeQuickLinks()
  return request({
    url: '/edu/home/quick-links',
    method: 'get'
  })
}

/**
 * 获取今日待办
 * GET /edu/home/todos
 */
export function getHomeTodos() {
  if (USE_MOCK) return mockGetHomeTodos()
  return request({
    url: '/edu/home/todos',
    method: 'get'
  })
}

/**
 * 获取推荐课程
 * GET /edu/home/courses
 */
export function getHomeCourses() {
  if (USE_MOCK) return mockGetHomeCourses()
  return request({
    url: '/edu/home/courses',
    method: 'get'
  })
}

/**
 * 获取学情报表
 * GET /edu/home/stats
 */
export function getHomeStats() {
  if (USE_MOCK) return mockGetHomeStats()
  return request({
    url: '/edu/home/stats',
    method: 'get'
  })
}
