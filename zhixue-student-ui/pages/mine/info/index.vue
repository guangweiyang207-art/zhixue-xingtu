<template>
  <view class="container">
    <uni-list>
      <uni-list-item showExtraIcon="true" :extraIcon="{type: 'person-filled'}" title="姓名" :rightText="user.name" />
      <uni-list-item showExtraIcon="true" :extraIcon="{type: 'phone-filled'}" title="手机号码" :rightText="user.phone" />
      <uni-list-item showExtraIcon="true" :extraIcon="{type: 'email-filled'}" title="邮箱" :rightText="user.email" />
      <uni-list-item showExtraIcon="true" :extraIcon="{type: 'compose-filled'}" title="专业" :rightText="user.major" />
      <uni-list-item showExtraIcon="true" :extraIcon="{type: 'calendar-filled'}" title="年级" :rightText="user.grade" />
      <uni-list-item showExtraIcon="true" :extraIcon="{type: 'staff-filled'}" title="班级" :rightText="user.className" />
    </uni-list>
  </view>
</template>

<script>
  import { getSettingsApi } from "@/api/mine/mine"

  export default {
    data() {
      return {
        user: {}
      }
    },
    onLoad() {
      this.getUser()
    },
    methods: {
      getUser() {
        const stuId = uni.getStorageSync('userInfo')?.stu_id || 1
        getSettingsApi(stuId).then(res => {
          if (res.data) {
            this.user = res.data
          }
        })
      }
    }
  }
</script>

<style lang="scss">
  page {
    background-color: #ffffff;
  }
</style>
