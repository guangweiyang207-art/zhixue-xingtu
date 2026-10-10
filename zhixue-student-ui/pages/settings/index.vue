<template>
  <view class="page">
    <view class="header">
      <view class="header-bg"></view>
      <view class="header-content">
        <view class="header-top">
          <text class="back-btn" @click="goBack">〈 返回</text>
        </view>
        <text class="header-title">个人设置</text>
        <text class="header-sub">修改个人信息与账号安全</text>
      </view>
    </view>

    <view class="body">
      <!-- 接口错误提示 -->
      <view class="error-bar" v-if="apiErrMsg">
        <text class="error-icon">⚠️</text>
        <text class="error-text">{{ apiErrMsg }}</text>
      </view>

      <!-- 头像区域 -->
      <view class="avatar-section">
        <view class="avatar-wrap">
          <text class="avatar-text">{{ userInfo.name.charAt(0) }}</text>
        </view>
        <text class="avatar-name">{{ userInfo.name }}</text>
        <text class="avatar-school">{{ userInfo.school }}</text>
      </view>

      <!-- 编辑表单 -->
      <view class="form-card">
        <view class="form-item" @click="editField('name')">
          <view class="form-left">
            <text class="form-icon">👤</text>
            <view class="form-info">
              <text class="form-label">姓名</text>
              <text class="form-value">{{ userInfo.name }}</text>
            </view>
          </view>
          <text class="form-arrow" v-if="editingField !== 'name'">〉</text>
          <view class="form-input-wrap" v-else>
            <input class="form-input" v-model="formData.name" @blur="saveField('name')" :focus="true" placeholder="请输入姓名" />
            <text class="form-done" @click.stop="saveField('name')">✓</text>
          </view>
        </view>

        <view class="form-divider"></view>

        <view class="form-item" @click="editField('phone')">
          <view class="form-left">
            <text class="form-icon">📱</text>
            <view class="form-info">
              <text class="form-label">手机号码</text>
              <text class="form-value" v-if="editingField !== 'phone'">{{ userInfo.phone }}</text>
            </view>
          </view>
          <text class="form-arrow" v-if="editingField !== 'phone'">〉</text>
          <view class="form-input-wrap" v-else>
            <input class="form-input" v-model="formData.phone" @blur="saveField('phone')" :focus="true" placeholder="请输入手机号" type="number" maxlength="11" />
            <text class="form-done" @click.stop="saveField('phone')">✓</text>
          </view>
        </view>

        <view class="form-divider"></view>

        <view class="form-item" @click="editField('email')">
          <view class="form-left">
            <text class="form-icon">✉️</text>
            <view class="form-info">
              <text class="form-label">邮箱</text>
              <text class="form-value" v-if="editingField !== 'email'">{{ userInfo.email }}</text>
            </view>
          </view>
          <text class="form-arrow" v-if="editingField !== 'email'">〉</text>
          <view class="form-input-wrap" v-else>
            <input class="form-input" v-model="formData.email" @blur="saveField('email')" :focus="true" placeholder="请输入邮箱地址" type="text" />
            <text class="form-done" @click.stop="saveField('email')">✓</text>
          </view>
        </view>

        <view class="form-divider"></view>

        <view class="form-item" @click="goChangePassword">
          <view class="form-left">
            <text class="form-icon">🔒</text>
            <view class="form-info">
              <text class="form-label">修改密码</text>
              <text class="form-value hint">建议定期更换密码</text>
            </view>
          </view>
          <text class="form-arrow">〉</text>
        </view>
      </view>

      <!-- 保存按钮 -->
      <button class="save-btn" @click="saveAll" v-if="hasChanges">
        <text>保存修改</text>
      </button>

      <!-- 退出登录 -->
      <button class="logout-btn" @click="logout">退出登录</button>
    </view>
  </view>
</template>

<script>
import { getSettingsApi, updateSettingsApi } from '@/api/settings/settings.js'
import { logout } from '@/api/login'

export default {
  data() {
    return {
      editingField: '',
      apiErrMsg: '',
      formData: {
        name: '',
        phone: '',
        email: ''
      },
      userInfo: {
        name: '',
        school: '',
        phone: '',
        email: ''
      },
      hasChanges: false
    }
  },
  onLoad() {
    const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
    getSettingsApi(stuId).then(res => {
      if (res.data) {
        this.userInfo = res.data
      }
    }).catch(err => {
      this.apiErrMsg = `接口 ${err.code || 404} 错误：${err.msg || '请求失败'}`
      console.error('获取设置信息失败：', err)
    })
  },
  methods: {
    editField(field) {
      this.formData[field] = this.userInfo[field]
      this.editingField = field
    },
    saveField(field) {
      const val = this.formData[field].trim()
      if (!val) {
        this.editingField = ''
        return
      }
      this.userInfo[field] = val
      this.editingField = ''
      this.hasChanges = true
    },
    saveAll() {
      const data = {
        name: this.userInfo.name,
        phone: this.userInfo.phone,
        email: this.userInfo.email
      }
      uni.showModal({
        title: '保存修改',
        content: '确定要保存以上修改吗？',
        success: (res) => {
          if (!res.confirm) return
          const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
          updateSettingsApi(stuId, data).then(res => {
            uni.setStorageSync('userInfo', this.userInfo)
            this.hasChanges = false
            uni.showToast({ title: '修改成功', icon: 'success' })
          }).catch(err => {
            const code = err.code || 404
            const msg = err.msg || '请求失败'
            uni.showToast({ title: `保存失败 (${code})：${msg}`, icon: 'none' })
            console.error('保存设置失败：', err)
          })
        }
      })
    },
    goChangePassword() {
      uni.navigateTo({ url: '/pages/mine/pwd/index' })
    },
    logout() {
      uni.showModal({
        title: '提示',
        content: '确定要退出登录吗？',
        success: (res) => {
          if (!res.confirm) return
          uni.showLoading({ title: '退出中...' })
          // 调用后端退出接口，清除 token
          logout().then(() => {
            uni.removeStorageSync('userInfo')
            uni.removeStorageSync('token')
            uni.hideLoading()
            uni.reLaunch({ url: '/pages/login' })
          }).catch(() => {
            // 即使接口失败，也清理本地并退出
            uni.removeStorageSync('userInfo')
            uni.removeStorageSync('token')
            uni.hideLoading()
            uni.reLaunch({ url: '/pages/login' })
          })
        }
      })
    },
    goBack() {
      uni.navigateBack()
    }
  }
}
</script>

<style scoped>
page { background: #f5f6fa; }
.page { min-height: 100vh; background: #f5f6fa; }

.header {
  position: relative;
  padding: 80rpx 32rpx 48rpx;
  overflow: hidden;
}
.header-bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(135deg, #6b5aed 0%, #a855f7 50%, #ec4899 100%);
  border-radius: 0 0 48rpx 48rpx;
}
.header-content { position: relative; z-index: 1; }
.header-top { margin-bottom: 20rpx; }
.back-btn { font-size: 26rpx; color: rgba(255,255,255,0.9); padding: 8rpx 0; }
.header-title { display: block; font-size: 48rpx; font-weight: 700; color: #fff; margin-bottom: 8rpx; }
.header-sub { font-size: 26rpx; color: rgba(255,255,255,0.85); }

.body { padding: 24rpx; }

.error-bar {
  display: flex; align-items: center; gap: 12rpx;
  background: #fef2f2; border: 1rpx solid #fecaca; border-radius: 12rpx;
  padding: 18rpx 20rpx; margin-bottom: 20rpx;
}
.error-icon { font-size: 28rpx; }
.error-text { font-size: 24rpx; color: #dc2626; }

.avatar-section {
  display: flex; flex-direction: column; align-items: center;
  padding: 40rpx 0 32rpx;
}
.avatar-wrap {
  width: 140rpx; height: 140rpx; border-radius: 50%;
  background: linear-gradient(135deg, #6b5aed, #a855f7);
  display: flex; align-items: center; justify-content: center;
  margin-bottom: 16rpx;
  box-shadow: 0 8rpx 32rpx rgba(107,90,237,0.3);
}
.avatar-text { font-size: 56rpx; color: #fff; font-weight: 700; }
.avatar-name { font-size: 34rpx; font-weight: 700; color: #111827; margin-bottom: 6rpx; }
.avatar-school { font-size: 26rpx; color: #9ca3af; }

.form-card {
  background: #fff; border-radius: 24rpx; overflow: hidden;
  box-shadow: 0 4rpx 20rpx rgba(15,23,42,0.06);
  margin-bottom: 28rpx;
}
.form-item {
  display: flex; align-items: center; justify-content: space-between;
  padding: 32rpx 28rpx; min-height: 96rpx;
}
.form-left { display: flex; align-items: center; flex: 1; min-width: 0; }
.form-icon { font-size: 36rpx; margin-right: 20rpx; }
.form-info { flex: 1; min-width: 0; }
.form-label { display: block; font-size: 30rpx; font-weight: 600; color: #111827; margin-bottom: 4rpx; }
.form-value { display: block; font-size: 26rpx; color: #6b7280; }
.form-value.hint { color: #9ca3af; font-size: 24rpx; }
.form-arrow { font-size: 36rpx; color: #d1d5db; flex-shrink: 0; }
.form-input-wrap {
  display: flex; align-items: center; flex: 1; margin-left: 16rpx;
  background: #f3f4f6; border-radius: 12rpx; padding: 0 16rpx;
}
.form-input {
  flex: 1; height: 68rpx; font-size: 28rpx; color: #111827;
  background: transparent; border: none;
}
.form-done {
  font-size: 36rpx; color: #6b5aed; font-weight: 700;
  padding: 8rpx 8rpx 8rpx 16rpx;
}
.form-divider { height: 1rpx; background: #f3f4f6; margin: 0 28rpx; }

.save-btn {
  width: 100%; padding: 28rpx;
  background: linear-gradient(135deg, #6b5aed, #a855f7);
  color: #fff; border: none; border-radius: 16rpx;
  font-size: 30rpx; font-weight: 600;
  margin-bottom: 24rpx;
  box-shadow: 0 8rpx 24rpx rgba(107,90,237,0.3);
}

.logout-btn {
  width: 100%; padding: 28rpx;
  background: #fff; color: #dc2626; border: 2rpx solid #fecaca;
  border-radius: 16rpx; font-size: 30rpx; font-weight: 600;
  margin-bottom: 48rpx;
}
</style>