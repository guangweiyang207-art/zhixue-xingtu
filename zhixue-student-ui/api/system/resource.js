import request from '@/utils/request'

export function getResourceListApi(params) {
  return request({
    url: '/resource/resource/list',
    method: 'GET',
    params
  })
}

export function getResourceDetailApi(reId) {
  return request({
    url: '/resource/resource/' + reId,
    method: 'GET'
  })
}
