module.exports = {
  devServer: {
    proxy: {
      '/prod-api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        pathRewrite: {
          '^/prod-api': ''
        }
      }
    }
  }
}
