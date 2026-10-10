// 应用全局配置
module.exports = {
  // RuoYi 后端默认 context-path: /,无需 /api 前缀
  // 注意：微信开发者工具内 localhost 指向工具自身环回，需改为 127.0.0.1
  // 如本机 IP 与微信工具不在同一机器，请改为本机内网 IP，例如 http://192.168.1.10:8081
  baseUrl: 'http://47.116.16.86:8081',
  // baseUrl: 'https://vue.ruoyi.vip/prod-api',
  // 应用信息
  appInfo: {
    // 应用名称
    name: "ruoyi-app",
    // 应用版本
    version: "1.2.0",
    // 应用logo
    logo: "/static/logo.png",
    // 官方网站
    site_url: "http://ruoyi.vip",
    // 政策协议
    agreements: [{
        title: "隐私政策",
        url: "https://ruoyi.vip/protocol.html"
      },
      {
        title: "用户服务协议",
        url: "https://ruoyi.vip/protocol.html"
      }
    ]
  }
}
