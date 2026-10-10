/**
 * 主页 Mock 数据（仅用于 UI 预览）
 * 后端就绪后，在 api/home/index.js 将 USE_MOCK 改为 false 即可切换为真实接口
 */
export const mockHomeData = {
  banners: [
    {
      id: 1,
      title: '暑期AI编程特训营',
      subtitle: '限时5折优惠，名额有限',
      imageUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800&h=400&fit=crop',
      linkUrl: ''
    }
  ],
  quickLinks: [
    { id: 1, name: '教学资源', icon: 'images-filled', bgColor: '#EEF4FF', iconColor: '#3B82F6', path: '' },
    { id: 2, name: '作业测试', icon: 'compose', bgColor: '#F3F0FF', iconColor: '#6B5AED', path: '' },
    { id: 3, name: '错题本', icon: 'flag-filled', bgColor: '#FFF7ED', iconColor: '#F97316', path: '' },
    { id: 4, name: '学习报告', icon: 'bars', bgColor: '#F0FDF4', iconColor: '#22C55E', path: '' }
  ],
  todos: [
    {
      id: 1,
      title: '数学：导数应用习题集',
      subtitle: '截止日期：今天 18:00',
      accentColor: '#3B82F6',
      buttonText: '去完成',
      buttonColor: '#EEF4FF',
      path: ''
    },
    {
      id: 2,
      title: '英语：听力模拟测试 (Unit 4)',
      subtitle: '预计耗时：25分钟',
      accentColor: '#6B5AED',
      buttonText: '开始',
      buttonColor: '#F3F0FF',
      path: ''
    }
  ],
  courses: [
    {
      id: 1,
      title: 'Python 趣味编程进阶',
      instructor: '张建国',
      lessonCount: 12,
      progress: 65,
      coverUrl: 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=200&h=200&fit=crop',
      path: ''
    },
    {
      id: 2,
      title: '数学思维训练营',
      instructor: '李老师',
      lessonCount: 8,
      progress: 32,
      coverUrl: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=200&h=200&fit=crop',
      path: ''
    }
  ],
  stats: {
    todayStudyHours: 2.5,
    weeklyHomeworkCount: 8,
    accuracyRate: 87,
    totalQuestions: 356
  }
}

function mockResponse(data) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({ code: 200, msg: '操作成功', data })
    }, 300)
  })
}

export function mockGetHomeIndex() {
  return mockResponse(mockHomeData)
}

export function mockGetHomeBanners() {
  return mockResponse(mockHomeData.banners)
}

export function mockGetHomeQuickLinks() {
  return mockResponse(mockHomeData.quickLinks)
}

export function mockGetHomeTodos() {
  return mockResponse(mockHomeData.todos)
}

export function mockGetHomeCourses() {
  return mockResponse(mockHomeData.courses)
}

export function mockGetHomeStats() {
  return mockResponse(mockHomeData.stats)
}
