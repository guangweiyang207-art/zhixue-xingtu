/**
 * 错题本 mock 已废弃，改为真实API调用
 */
export function mockGetErrorList(params) {
  console.warn('Mock is deprecated, using real API', params)
  return Promise.reject({ code: 404, msg: '请使用真实API' })
}