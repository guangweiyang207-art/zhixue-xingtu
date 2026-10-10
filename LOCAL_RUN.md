# 学生端、教师端本地运行

两个独立的 uni-app 工程：

- 学生端：`zhixue-student-ui`
- 教师端：`zhixue-teacher-ui`

## 启动顺序

1. 启动本机 MySQL（3306，数据库 `ai_study_helper`）和 Redis（6379）。
2. 在 IDEA 运行 `ruoyi-admin` 中的 `RuoYiApplication`，后端端口是 **8081**。
   也可在项目根目录执行 `java -jar ruoyi-admin/target/ruoyi-admin.jar`。
   同一个端口只启动一份后端。
3. HBuilderX 分别打开上面的两个工程。
4. 选中对应工程，点击“运行 → 运行到小程序模拟器 → 微信开发者工具”。
5. 两端配置的接口地址都是 `http://localhost:8081`，适用于本机开发者工具。

`http://localhost:8081/captchaImage` 应返回 `code: 200`。
若提示连接失败，先检查后端和 Redis 是否运行。

## 本地演示账号

- 学生端：`student001` / `123456`
- 教师端：`teacher001` / `123456`

当前使用算术验证码，输入图片中算式的计算结果。点击图片可刷新；登录失败后验证码会自动刷新并清空输入。

原始种子数据中这两个账号的 BCrypt 值与 `123456` 不匹配，现已修正。
旧数据库可执行 `sql/fix_demo_login_passwords.sql`；脚本只替换这两个账号的原始错误值，不覆盖已经自行修改的密码。

## 本次验证

- 后端 Maven 打包成功。
- 两个账号通过真实验证码校验后均登录成功，返回 token 和对应学生/教师 ID。
- 缺失验证码、错误密码返回明确错误消息。
- `node scripts/check-mini-login.cjs` 检查两个前端的错误传递、超时、网络错误、401 及成功响应。
- 两端通过 HBuilderX 本地编译并在微信开发者工具打开，导出目录为各自的 `unpackage/dist/build/mp-weixin`。
- 两个模拟器均显示登录页并加载验证码，控制台未检出 error 日志；密码框使用小程序的 password 属性隐藏输入。

如使用 HBuilderX CLI 本地编译，必须显式传入 manifest 中的微信 AppID，并使用 `--upload false`。
未传 AppID 时 CLI 会生成 `touristappid`，可能导致开发者工具打开失败。
日常改代码调试建议用上述“运行”菜单生成 `unpackage/dist/dev/mp-weixin`。
