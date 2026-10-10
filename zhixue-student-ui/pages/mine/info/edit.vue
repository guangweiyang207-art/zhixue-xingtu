<template>
  <view class="container">
    <view class="example">
      <uni-forms ref="form" :model="user" labelWidth="80px">
        <uni-forms-item label="姓名" name="name" required>
          <uni-easyinput v-model="user.name" placeholder="请输入姓名" />
        </uni-forms-item>
        <uni-forms-item label="手机号码" name="phone" required>
          <uni-easyinput v-model="user.phone" placeholder="请输入手机号码" />
        </uni-forms-item>
        <uni-forms-item label="邮箱" name="email" required>
          <uni-easyinput v-model="user.email" placeholder="请输入邮箱" />
        </uni-forms-item>
        <uni-forms-item label="学校班级" name="school">
          <uni-easyinput v-model="user.school" disabled placeholder="学校班级由学校统一分配" />
        </uni-forms-item>
      </uni-forms>
      <button type="primary" @click="submit">提交</button>
    </view>
  </view>
</template>

<script>
  import { getSettingsApi, updateSettingsApi } from "@/api/mine/mine"

  export default {
    data() {
      return {
        user: {
          name: "",
          phone: "",
          email: "",
          school: ""
        },
        rules: {
          name: {
            rules: [{
              required: true,
              errorMessage: '姓名不能为空'
            }]
          },
          phone: {
            rules: [{
              required: true,
              errorMessage: '手机号码不能为空'
            }, {
              pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
              errorMessage: '请输入正确的手机号码'
            }]
          },
          email: {
            rules: [{
              required: true,
              errorMessage: '邮箱地址不能为空'
            }, {
              format: 'email',
              errorMessage: '请输入正确的邮箱地址'
            }]
          }
        }
      }
    },
    onLoad() {
      this.getUser()
    },
    onReady() {
      this.$refs.form.setRules(this.rules)
    },
    methods: {
      getUser() {
        const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
        getSettingsApi(stuId).then(res => {
          if (res.data) {
            this.user = res.data
          }
        })
      },
      submit() {
        this.$refs.form.validate().then(res => {
          const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
          updateSettingsApi(stuId, {
            name: this.user.name,
            phone: this.user.phone,
            email: this.user.email
          }).then(response => {
            this.$modal.msgSuccess("修改成功")
          })
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  page {
    background-color: #ffffff;
  }

  .example {
    padding: 15px;
    background-color: #fff;
  }

  .segmented-control {
    margin-bottom: 15px;
  }

  .button-group {
    margin-top: 15px;
    display: flex;
    justify-content: space-around;
  }

  .form-item {
    display: flex;
    align-items: center;
    flex: 1;
  }

  .button {
    display: flex;
    align-items: center;
    height: 35px;
    line-height: 35px;
    margin-left: 10px;
  }
</style>
