<template>
  <view class="login-page">
    <!-- 顶部背景装饰 -->
    <view class="bg-decoration"></view>

    <!-- 内容区域 -->
    <view class="login-content">
      <!-- Logo和标题 -->
      <view class="logo-area">
        <view class="logo-circle">
          <text class="logo-text">AI</text>
        </view>
        <text class="app-title">智学星途教师端</text>
        <text class="app-subtitle">智慧教学，因材施教</text>
      </view>

      <!-- 登录卡片 -->
      <view class="login-card">
        <text class="card-title">账号登录</text>

        <view class="input-wrap">
          <view class="input-item">
            <uni-icons type="person" size="20" color="#9CA3AF" />
            <input
              v-model="loginForm.username"
              class="input"
              type="text"
              placeholder="请输入账号"
              maxlength="30"
            />
          </view>

          <view class="input-item">
            <uni-icons type="locked" size="20" color="#9CA3AF" />
            <input
              v-model="loginForm.password"
              class="input"
              type="text"
              :password="true"
              placeholder="请输入密码"
              maxlength="20"
            />
          </view>

          <view v-if="captchaEnabled" class="input-item code-item">
            <uni-icons type="compose" size="20" color="#9CA3AF" />
            <input
              v-model="loginForm.code"
              class="input"
              type="text"
              placeholder="请输入验证码"
              maxlength="4"
            />
            <image :src="codeUrl" class="code-img" @click="getCode" />
          </view>
        </view>

        <view class="remember-wrap" @click="rememberMe = !rememberMe">
          <view class="checkbox" :class="{ active: rememberMe }">
            <uni-icons v-if="rememberMe" type="checkmarkempty" size="14" color="#fff" />
          </view>
          <text class="remember-text">记住密码，下次免密登录</text>
        </view>

        <button class="login-btn" :loading="loggingIn" :disabled="loggingIn || captchaLoading" @click="handleLogin">{{ loggingIn ? '登录中...' : '登录' }}</button>

        <view class="tips">
          <text class="tip-text">登录即代表同意</text>
          <text class="tip-link" @click="handleUserAgrement">《用户协议》</text>
          <text class="tip-text">和</text>
          <text class="tip-link" @click="handlePrivacy">《隐私协议》</text>
        </view>
        <view class="tips">
          <text class="tip-text">首次登录需手动输入账号密码，勾选"记住密码"后下次自动登录</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
  import { getCodeImg, teacherLogin, teacherAutoLogin } from '@/api/login'
  import { getToken, setToken, setTeacherId, setRealName, getRememberToken, setRememberToken, removeRememberToken } from '@/utils/auth'

  export default {
    data() {
      return {
        globalConfig: getApp().globalData.config,
        codeUrl: '',
        captchaEnabled: true,
        captchaLoading: false,
        loggingIn: false,
        autoLoggingIn: false,
        rememberMe: false,
        lastRememberToken: '',
        // 首次登录必须手动输入账号密码,不做任何预填(避免上线后暴露演示账号)
        loginForm: {
          username: '',
          password: '',
          code: '',
          uuid: ''
        }
      }
    },
    onLoad() {
      this.getCode()
      this.tryAutoLogin()
      //#ifdef H5
      if (getToken()) {
        this.$tab.reLaunch('/pages/index')
      }
      //#endif
    },
    methods: {
      // 已登录过(Redis 记住凭据有效)时,本设备免密自动登录
      async tryAutoLogin() {
        const rememberToken = getRememberToken()
        if (!rememberToken || this.autoLoggingIn) return
        this.autoLoggingIn = true
        this.$modal.loading('自动登录中...')
        try {
          const res = await teacherAutoLogin(rememberToken)
          this.$modal.closeLoading()
          if (res.code === 200 && res.token && res.teacherId) {
            setToken(res.token)
            setTeacherId(res.teacherId)
            setRealName(res.realName || res.username)
            uni.showToast({ title: '登录成功' })
            this.$tab.reLaunch('/pages/index')
          } else {
            // 凭据失效(过期/账号被禁用等),清除后回到手动登录
            removeRememberToken()
          }
        } catch (e) {
          this.$modal.closeLoading()
          removeRememberToken()
        } finally {
          this.autoLoggingIn = false
        }
      },
      handleUserAgrement() {
        let site = this.globalConfig.appInfo.agreements[1]
        this.$tab.navigateTo(`/pages/common/webview/index?title=${site.title}&url=${site.url}`)
      },
      handlePrivacy() {
        let site = this.globalConfig.appInfo.agreements[0]
        this.$tab.navigateTo(`/pages/common/webview/index?title=${site.title}&url=${site.url}`)
      },
      async getCode() {
        if (this.captchaLoading) return
        this.captchaLoading = true
        this.loginForm.code = ''
        this.loginForm.uuid = ''
        this.codeUrl = ''
        try {
          const res = await getCodeImg()
          this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled
          if (this.captchaEnabled) {
            this.codeUrl = 'data:image/gif;base64,' + res.img
            this.loginForm.uuid = res.uuid
          }
        } catch (e) {
          // 请求层已提示网络错误；保留验证码校验，等待重新获取。
          this.captchaEnabled = true
        } finally {
          this.captchaLoading = false
        }
      },
      setRemember() {
        // 仅当用户勾选"记住密码"时才保存记住凭据(30天免密),否则清除
        if (this.rememberMe && this.lastRememberToken) {
          setRememberToken(this.lastRememberToken)
        }
        if (!this.rememberMe) {
          removeRememberToken()
        }
        this.lastRememberToken = ''
      },
      async handleLogin() {
        if (this.loggingIn || this.captchaLoading) return
        this.loginForm.username = this.loginForm.username.trim()
        this.loginForm.code = this.loginForm.code.trim()
        if (this.loginForm.username === '') {
          this.$modal.msgError('请输入账号')
          return
        }
        if (this.loginForm.password === '') {
          this.$modal.msgError('请输入密码')
          return
        }
        if (this.captchaEnabled && !this.loginForm.uuid) {
          this.getCode()
          this.$modal.msgError('请获取验证码后重试')
          return
        }
        if (this.captchaEnabled && this.loginForm.code === '') {
          this.$modal.msgError('请输入验证码')
          return
        }
        this.loggingIn = true
        this.$modal.loading('登录中，请耐心等待...')
        await this.pwdLogin()
      },
      // 密码登录(教师专用 /teacher/login)
      async pwdLogin() {
        try {
          const res = await teacherLogin(this.loginForm.username, this.loginForm.password, this.loginForm.code, this.loginForm.uuid)
          if (!res.token || !res.teacherId) throw new Error('登录信息不完整，请联系管理员')
          this.$modal.closeLoading()
          if (res.code === 200) {
            setToken(res.token)
            setTeacherId(res.teacherId)
            setRealName(res.realName || res.username)
            // 保存后端 Redis 记住凭据,下次打开免密自动登录
            this.lastRememberToken = res.rememberToken || ''
            this.setRemember()
            uni.showToast({ title: '登录成功' })
            this.$tab.reLaunch('/pages/index')
          } else {
            this.$modal.msgError(res.msg || '登录失败')
            if (this.captchaEnabled) this.getCode()
          }
        } catch (e) {
          this.$modal.closeLoading()
          // 显示后端返回的具体错误（如 "验证码错误"、"账号不存在" 等），
          // 避免笼统的"登录异常"误导排查
          const msg = (e && e.message) || '登录失败，请稍后重试'
          this.$modal.msgError(msg)
          if (this.captchaEnabled) this.getCode()
        } finally {
          this.loggingIn = false
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  .login-page {
    min-height: 100vh;
    background: $uni-color-primary;
    position: relative;
    overflow: hidden;
  }

  .bg-decoration {
    position: absolute;
    top: -120rpx;
    right: -120rpx;
    width: 420rpx;
    height: 420rpx;
    background: rgba(255, 255, 255, 0.04);
    border-radius: 50%;
  }
  .bg-decoration::after {
    content: '';
    position: absolute;
    bottom: -480rpx;
    left: -180rpx;
    width: 600rpx;
    height: 600rpx;
    background: rgba(164, 113, 72, 0.08);
    border-radius: 50%;
  }

  .login-content {
    position: relative;
    z-index: 1;
    padding: 0 56rpx;
    padding-top: calc(var(--status-bar-height) + 80rpx);
  }

  .logo-area {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 56rpx;

    .logo-circle {
      width: 120rpx;
      height: 120rpx;
      background: $uni-color-accent;
      border-radius: 28rpx;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 28rpx;
      box-shadow: $uni-shadow-md;

      .logo-text {
        font-size: 44rpx;
        font-weight: $uni-font-weight-bold;
        color: $uni-text-color-inverse;
        letter-spacing: 1rpx;
      }
    }

    .app-title {
      font-size: 40rpx;
      font-weight: $uni-font-weight-semibold;
      color: $uni-text-color-inverse;
      margin-bottom: 10rpx;
      letter-spacing: 1rpx;
    }

    .app-subtitle {
      font-size: 24rpx;
      color: rgba(255, 255, 255, 0.55);
      letter-spacing: 1rpx;
    }
  }

  .login-card {
    background: $uni-bg-color;
    border-radius: $uni-radius-xl;
    padding: 48rpx 40rpx;
    box-shadow: $uni-shadow-lg;

    .card-title {
      display: block;
      font-size: 34rpx;
      font-weight: $uni-font-weight-semibold;
      color: $uni-text-color;
      margin-bottom: 36rpx;
      text-align: center;
      letter-spacing: 0.5rpx;
    }

    .input-wrap {
      margin-bottom: 16rpx;

      .input-item {
        display: flex;
        align-items: center;
        background: $uni-bg-color-page;
        height: 96rpx;
        border-radius: $uni-radius-md;
        padding: 0 32rpx;
        margin-bottom: 20rpx;
        border: 1rpx solid transparent;
        transition: border-color $uni-duration-fast $uni-ease;

        &:focus-within {
          border-color: $uni-color-primary;
          background: $uni-bg-color;
        }

        .input {
          flex: 1;
          margin-left: 20rpx;
          font-size: 28rpx;
          color: $uni-text-color;
        }
      }

      .code-item {
        padding-right: 12rpx;

        .code-img {
          width: 168rpx;
          height: 64rpx;
          border-radius: $uni-radius-sm;
          margin-left: 16rpx;
          background: $uni-bg-color;
        }
      }
    }

    .remember-wrap {
      display: flex;
      align-items: center;
      margin: 8rpx 0 32rpx;
      padding-left: 4rpx;

      .checkbox {
        width: 30rpx;
        height: 30rpx;
        border-radius: $uni-radius-xs;
        border: 2rpx solid $uni-border-color-strong;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 12rpx;
        transition: all $uni-duration-fast $uni-ease;

        &.active {
          background: $uni-color-primary;
          border-color: $uni-color-primary;
        }
      }

      .remember-text {
        font-size: 24rpx;
        color: $uni-text-color-secondary;
      }
    }

    .login-btn {
      width: 100%;
      height: 92rpx;
      line-height: 92rpx;
      background: $uni-color-primary;
      color: $uni-text-color-inverse;
      font-size: 30rpx;
      font-weight: $uni-font-weight-medium;
      border-radius: $uni-radius-md;
      border: none;
      box-shadow: $uni-shadow-md;
      letter-spacing: 2rpx;
    }

    .login-btn::after {
      border: none;
    }

    .login-btn:active { background: $uni-color-primary-press; }

    .tips {
      margin-top: 28rpx;
      text-align: center;

      .tip-text {
        font-size: 24rpx;
        color: $uni-text-color-tertiary;
      }

      .tip-link {
        font-size: 24rpx;
        color: $uni-color-primary;
      }
    }
  }
</style>
