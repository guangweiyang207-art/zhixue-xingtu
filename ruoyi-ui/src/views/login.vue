<template>
  <div class="login">
    <!-- 背景图层 -->
    <div class="login-bg"></div>

    <!-- 右侧登录卡片 -->
    <div class="login-right">
      <div class="login-card">
        <div class="card-header">
          <h2 class="card-title">管理端登录</h2>
          <p class="card-subtitle">欢迎登录智学星途管理平台</p>
        </div>

        <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
          <el-form-item prop="username">
            <el-input
              v-model="loginForm.username"
              type="text"
              auto-complete="off"
              placeholder="请输入账号"
              class="login-input"
            >
              <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>

          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              auto-complete="off"
              placeholder="请输入密码"
              class="login-input"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>

          <el-form-item prop="code" v-if="captchaEnabled">
            <el-input
              v-model="loginForm.code"
              auto-complete="off"
              placeholder="请输入验证码"
              class="login-input code-input"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
            </el-input>
            <div class="login-code">
              <img :src="codeUrl" @click="getCode" class="login-code-img"/>
            </div>
          </el-form-item>

          <div class="form-options">
            <el-checkbox v-model="loginForm.rememberMe">记住账号</el-checkbox>
            <router-link v-if="register" class="link-type" :to="'/register'">忘记密码?</router-link>
          </div>

          <el-form-item>
            <el-button
              :loading="loading"
              size="medium"
              type="primary"
              class="login-btn"
              @click.native.prevent="handleLogin"
            >
              <span v-if="!loading">登 录</span>
              <span v-else>登 录 中...</span>
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from '@/utils/jsencrypt'
import defaultSettings from '@/settings'

export default {
  name: "Login",
  data() {
    return {
      title: process.env.VUE_APP_TITLE,
      footerContent: defaultSettings.footerContent,
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      captchaEnabled: true,
      register: false,
      redirect: undefined
    }
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true
    }
  },
  created() {
    this.getCode()
    this.getCookie()
  },
  methods: {
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img
          this.loginForm.uuid = res.uuid
        }
      })
    },
    getCookie() {
      const username = Cookies.get("username")
      const password = Cookies.get("password")
      const rememberMe = Cookies.get('rememberMe')
      // 仅当用户勾选过"记住账号"时才回填,首次登录必须手动输入
      this.loginForm = {
        username: username === undefined ? "" : username,
        password: password === undefined ? "" : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      }
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 })
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 })
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 })
          } else {
            Cookies.remove("username")
            Cookies.remove("password")
            Cookies.remove('rememberMe')
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(()=>{})
          }).catch(() => {
            this.loading = false
            if (this.captchaEnabled) {
              this.getCode()
            }
          })
        }
      })
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.login {
  display: flex;
  min-height: 100vh;
  position: relative;
  overflow: hidden;
}

// 背景图层
.login-bg {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: url('~@/assets/images/login-bg.jpg') no-repeat center center;
  background-size: cover;
  z-index: 0;
}

// 右侧区域
.login-right {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px;
    position: relative;
    z-index: 1;
  }

// 登录卡片
.login-card {
  width: 400px;
  padding: 48px 40px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
  backdrop-filter: blur(10px);
}

// 卡片头部
.card-header {
  text-align: center;
  margin-bottom: 40px;

  .card-title {
    font-size: 26px;
    font-weight: 600;
    color: #1a202c;
    margin: 0 0 10px 0;
  }

  .card-subtitle {
    font-size: 14px;
    color: #718096;
    margin: 0;
  }
}

// 登录表单
.login-form {
  width: 100%;

  .login-input {
    ::v-deep .el-input__inner {
      height: 48px;
      line-height: 48px;
      border-radius: 8px;
      border: 1px solid #e2e8f0;
      padding-left: 44px;
      transition: all 0.3s ease;
      background: #f7fafc;
      font-size: 14px;

      &:focus {
        border-color: #3182ce;
        background: #fff;
        box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.1);
      }

      &::placeholder {
        color: #a0aec0;
      }
    }

    ::v-deep .el-input__prefix {
      left: 14px;
      top: 50%;
      transform: translateY(-50%);

      .input-icon {
        width: 18px;
        height: 18px;
        color: #a0aec0;
        transition: color 0.3s ease;
      }
    }

    &:focus-within {
      ::v-deep .el-input__prefix .input-icon {
        color: #3182ce;
      }
    }
  }

  .code-input {
    width: calc(100% - 120px);
    display: inline-block;
  }

  .login-code {
    width: 110px;
    height: 48px;
    float: right;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);

    .login-code-img {
      width: 100%;
      height: 100%;
      cursor: pointer;
      transition: transform 0.3s ease;

      &:hover {
        transform: scale(1.03);
      }
    }
  }

  .form-options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 0 0 28px 0;

    ::v-deep .el-checkbox__label {
      font-size: 13px;
      color: #4a5568;
    }

    .link-type {
      font-size: 13px;
      color: #3182ce;
      text-decoration: none;
      transition: color 0.3s ease;

      &:hover {
        color: #2c5282;
        text-decoration: underline;
      }
    }
  }

  .login-btn {
    width: 100%;
    height: 48px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 500;
    letter-spacing: 4px;
    background: linear-gradient(135deg, #3182ce 0%, #2c5282 100%);
    border: none;
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(49, 130, 206, 0.4);

    &:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(49, 130, 206, 0.5);
    }

    &:active {
      transform: translateY(0);
    }

    &.is-loading {
      opacity: 0.8;
    }
  }
}

// 响应式适配
@media screen and (max-width: 768px) {
  .login-right {
    width: 100%;
    padding: 20px;
  }

  .login-card {
    width: 100%;
    max-width: 400px;
    padding: 32px 24px;
  }
}
</style>
