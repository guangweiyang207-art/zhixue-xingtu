<template>
  <view class="setting-page">
    <view class="page-header">
      <text class="page-title">账号设置</text>
    </view>

    <!-- 账号信息(my_sys_user) -->
    <view class="setting-group">
      <view class="group-title">账号信息</view>

      <view class="setting-item avatar-item" @click="changeAvatar">
        <view class="item-left"><text class="item-label">头像</text></view>
        <view class="item-right">
          <image class="avatar-img" :src="form.avatar || defaultAvatar" mode="aspectFill" />
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item">
        <view class="item-left"><text class="item-label">登录账号</text></view>
        <view class="item-right">
          <text class="item-value readonly">{{ form.username || '—' }}</text>
        </view>
      </view>

      <view class="setting-item" @click="editField('realName', '姓名')">
        <view class="item-left"><text class="item-label">姓名</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.realName || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item" @click="editField('phone', '手机号')">
        <view class="item-left"><text class="item-label">手机号</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.phone || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item" @click="editField('email', '邮箱')">
        <view class="item-left"><text class="item-label">邮箱</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.email || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item" @click="editField('age', '年龄')">
        <view class="item-left"><text class="item-label">年龄</text></view>
        <view class="item-right">
          <text class="item-value">{{ (form.age === null || form.age === undefined || form.age === '') ? '—' : form.age }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>
    </view>

    <!-- 教师档案(my_teacher) -->
    <view class="setting-group">
      <view class="group-title">教师档案</view>

      <view class="setting-item" @click="editField('teacherNo', '工号')">
        <view class="item-left"><text class="item-label">工号</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.teacherNo || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item" @click="editField('department', '院系')">
        <view class="item-left"><text class="item-label">院系</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.department || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item" @click="editField('title', '职称')">
        <view class="item-left"><text class="item-label">职称</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.title || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>

      <view class="setting-item" @click="editField('specialty', '专长')">
        <view class="item-left"><text class="item-label">专长</text></view>
        <view class="item-right">
          <text class="item-value">{{ form.specialty || '—' }}</text>
          <text class="iconfont icon-right"></text>
        </view>
      </view>
    </view>

    <!-- 安全 -->
    <view class="setting-group">
      <view class="group-title">安全</view>
      <view class="setting-item" @click="showPasswordModal = true">
        <view class="item-left"><text class="item-label">修改密码</text></view>
        <view class="item-right">
          <text class="iconfont icon-right"></text>
        </view>
      </view>
    </view>

    <!-- 编辑单字段弹窗 -->
    <view class="modal-mask" v-if="showEditModal" @click="showEditModal = false">
      <view class="modal-content" @click.stop>
        <view class="modal-header">
          <text class="modal-title">修改{{ editLabel }}</text>
          <text class="modal-close" @click="showEditModal = false">×</text>
        </view>
        <view class="modal-body">
          <input
            class="form-input"
            v-model="editValue"
            :type="editingField === 'age' ? 'number' : 'text'"
            :placeholder="'请输入' + editLabel"
          />
        </view>
        <view class="modal-footer">
          <view class="btn cancel" @click="showEditModal = false">取消</view>
          <view class="btn confirm" @click="confirmEdit">确定</view>
        </view>
      </view>
    </view>

    <!-- 修改密码弹窗 -->
    <view class="modal-mask" v-if="showPasswordModal" @click="showPasswordModal = false">
      <view class="modal-content" @click.stop>
        <view class="modal-header">
          <text class="modal-title">修改密码</text>
          <text class="modal-close" @click="showPasswordModal = false">×</text>
        </view>
        <view class="modal-body">
          <view class="form-item">
            <text class="form-label">原密码</text>
            <input class="form-input" v-model="passwordForm.oldPassword" type="password" placeholder="请输入原密码" />
          </view>
          <view class="form-item">
            <text class="form-label">新密码</text>
            <input class="form-input" v-model="passwordForm.newPassword" type="password" placeholder="至少 6 位" />
          </view>
          <view class="form-item">
            <text class="form-label">确认新密码</text>
            <input class="form-input" v-model="passwordForm.confirmPassword" type="password" placeholder="再次输入新密码" />
          </view>
        </view>
        <view class="modal-footer">
          <view class="btn cancel" @click="showPasswordModal = false">取消</view>
          <view class="btn confirm" @click="confirmPassword">确定</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { getTeacherAccount, updateTeacherAccount, uploadTeacherAvatar, updateTeacherPwd } from '@/api/mine/teacher'

export default {
  data() {
    return {
      defaultAvatar: '/static/images/teacher-avatar.svg',
      form: {
        teacherId: null,
        userId: null,
        username: '',
        realName: '',
        avatar: '',
        phone: '',
        email: '',
        age: null,
        teacherNo: '',
        department: '',
        title: '',
        specialty: ''
      },
      showEditModal: false,
      showPasswordModal: false,
      editingField: '',
      editLabel: '',
      editValue: '',
      passwordForm: {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      }
    }
  },
  onLoad() { this.loadAccount() },
  methods: {
    loadAccount() {
      getTeacherAccount().then(res => {
        this.form = Object.assign({ ...this.form }, res.data || {})
      }).catch(() => {
        uni.showToast({ title: '获取账号信息失败', icon: 'none' })
      })
    },
    changeAvatar() {
      uni.chooseImage({
        count: 1,
        sizeType: ['compressed'],
        sourceType: ['album', 'camera'],
        success: (chooseRes) => {
          const tempFilePath = chooseRes.tempFilePaths[0]
          uploadTeacherAvatar(tempFilePath).then(upRes => {
            const url = upRes.imgUrl || tempFilePath
            this.form.avatar = url
            uni.showToast({ title: '头像上传成功', icon: 'success' })
            // 同步写回数据库
            updateTeacherAccount({ ...this.form, avatar: url })
          }).catch(() => {
            uni.showToast({ title: '头像上传失败', icon: 'none' })
          })
        }
      })
    },
    editField(field, label) {
      this.editingField = field
      this.editLabel = label
      this.editValue = (this.form[field] === null || this.form[field] === undefined) ? '' : this.form[field]
      this.showEditModal = true
    },
    confirmEdit() {
      if (this.editValue === '' || this.editValue === null || this.editValue === undefined) {
        uni.showToast({ title: '请输入' + this.editLabel, icon: 'none' })
        return
      }
      // 年龄做范围校验
      if (this.editingField === 'age') {
        const n = Number(this.editValue)
        if (!Number.isInteger(n) || n < 0 || n > 150) {
          uni.showToast({ title: '年龄需为 0-150 之间的整数', icon: 'none' })
          return
        }
        this.editValue = n
      }
      // 手机号做简单格式校验
      if (this.editingField === 'phone' && this.editValue && !/^1[3-9]\d{9}$/.test(this.editValue)) {
        uni.showToast({ title: '请输入正确的手机号', icon: 'none' })
        return
      }
      // 邮箱做格式校验
      if (this.editingField === 'email' && this.editValue && !/^[\w.+-]+@[\w-]+\.[\w.-]+$/.test(this.editValue)) {
        uni.showToast({ title: '请输入正确的邮箱', icon: 'none' })
        return
      }
      const payload = { ...this.form, [this.editingField]: this.editValue }
      this.form[this.editingField] = this.editValue
      this.showEditModal = false
      updateTeacherAccount(payload).then(() => {
        uni.showToast({ title: '保存成功', icon: 'success' })
      }).catch(() => {
        uni.showToast({ title: '保存失败', icon: 'none' })
      })
    },
    confirmPassword() {
      const { oldPassword, newPassword, confirmPassword } = this.passwordForm
      if (!oldPassword) return uni.showToast({ title: '请输入原密码', icon: 'none' })
      if (!newPassword)  return uni.showToast({ title: '请输入新密码', icon: 'none' })
      if (newPassword !== confirmPassword) return uni.showToast({ title: '两次输入不一致', icon: 'none' })
      if (newPassword.length < 6) return uni.showToast({ title: '密码长度不能少于6位', icon: 'none' })

      updateTeacherPwd(oldPassword, newPassword).then(() => {
        uni.showToast({ title: '密码修改成功', icon: 'success' })
        this.showPasswordModal = false
        this.passwordForm = { oldPassword: '', newPassword: '', confirmPassword: '' }
      }).catch((err) => {
        const msg = (err && (err.msg || err.message)) || '密码修改失败'
        uni.showToast({ title: msg, icon: 'none' })
      })
    }
  }
}
</script>

<style lang="scss" scoped>
page { background-color: #f5f6fa; }
.setting-page { padding: 0 24rpx 48rpx; }

.page-header { padding-top: 40rpx; padding-bottom: 24rpx; }
.page-title { font-size: 44rpx; font-weight: bold; color: #1a1a1a; }

.setting-group {
  background-color: #fff;
  border-radius: 20rpx;
  margin-bottom: 20rpx;
  overflow: hidden;
}

.group-title {
  padding: 20rpx 24rpx 4rpx;
  font-size: 24rpx;
  color: #999;
}

.setting-item {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 28rpx 24rpx;
  border-bottom: 1rpx solid #f5f5f5;

  &:last-child { border-bottom: none; }
  &.avatar-item { padding: 28rpx 24rpx; }
}

.item-left { display: flex; flex-direction: row; align-items: center; }
.item-label { font-size: 30rpx; color: #333; }

.item-right {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 8rpx;
}

.item-value { font-size: 28rpx; color: #666; max-width: 360rpx; text-align: right; }
.item-value.readonly { color: #aaa; }

.avatar-img {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  margin-right: 8rpx;
  background: #f0f0f0;
}

.iconfont { font-size: 24rpx; color: #ccc; }

/* 弹窗 */
.modal-mask {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
}
.modal-content {
  width: 560rpx;
  background-color: #fff;
  border-radius: 24rpx;
  padding: 32rpx;
}
.modal-header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24rpx;
}
.modal-title { font-size: 34rpx; font-weight: bold; color: #1a1a1a; }
.modal-close  { font-size: 40rpx; color: #999; padding: 0 8rpx; }
.modal-body   { margin-bottom: 24rpx; }
.form-item { margin-bottom: 20rpx; &:last-child { margin-bottom: 0; } }
.form-label {
  display: block;
  font-size: 28rpx;
  color: #666;
  margin-bottom: 8rpx;
}
.form-input {
  width: 100%;
  height: 72rpx;
  border: 1rpx solid #e0e0e0;
  border-radius: 12rpx;
  padding: 0 20rpx;
  font-size: 28rpx;
  box-sizing: border-box;
}

.modal-footer { display: flex; flex-direction: row; gap: 20rpx; }
.btn {
  flex: 1;
  height: 80rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12rpx;
  font-size: 28rpx;

  &.cancel  { background-color: #f5f5f5; color: #666; }
  &.confirm { background-color: #5b5fc7; color: #fff; }
}
</style>
