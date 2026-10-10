import request from '@/utils/request'

// 查询轮播图列表
export function listBanner(query) {
  return request({
    url: '/system/banner/list',
    method: 'get',
    params: query
  })
}

// 查询轮播图详细
export function getBanner(bannerId) {
  return request({
    url: '/system/banner/' + bannerId,
    method: 'get'
  })
}

// 新增轮播图
export function addBanner(data) {
  return request({
    url: '/system/banner',
    method: 'post',
    data: data
  })
}

// 修改轮播图
export function updateBanner(data) {
  return request({
    url: '/system/banner',
    method: 'put',
    data: data
  })
}

// 删除轮播图
export function delBanner(bannerId) {
  return request({
    url: '/system/banner/' + bannerId,
    method: 'delete'
  })
}

// 查询启用的轮播图
export function listEnableBanner() {
  return request({
    url: '/system/banner/enable',
    method: 'get'
  })
}
