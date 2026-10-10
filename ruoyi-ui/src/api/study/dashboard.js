import request from '@/utils/request'

// 平台数据总览
export function getPlatformOverview() {
  return request({
    url: '/study/dashboard/overview',
    method: 'get'
  })
}

// AI错题分析分布
export function getErrorHeatmap(date) {
  return request({
    url: '/study/dashboard/errorHeatmap',
    method: 'get',
    params: { date: date }
  })
}

// AI智能答疑对话轮播
export function getRecentChats() {
  return request({
    url: '/study/dashboard/recentChats',
    method: 'get'
  })
}

// 学生/教师活跃度环形图
export function getActivityRing(period) {
  return request({
    url: '/study/dashboard/activityRing',
    method: 'get',
    params: { period }
  })
}

// 班级学情对比雷达图
export function getClassRadar() {
  return request({
    url: '/study/dashboard/classRadar',
    method: 'get'
  })
}

// 课程热度排行
export function getCourseRanking() {
  return request({
    url: '/study/dashboard/courseRanking',
    method: 'get'
  })
}