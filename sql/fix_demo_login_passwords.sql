-- 本地演示账号密码修复：student001 / teacher001 的密码为 123456。
-- 仅替换原始种子数据中的错误 BCrypt 值，不覆盖已自行修改的密码。
USE ai_study_helper;

UPDATE my_sys_user
SET password = '$2a$10$OFbJGvdxJId4mvvJecvSuuqRDnnQFdTpSCR9vkOXFzm9Hxnb3lBxC'
WHERE ((user_id = 1 AND username = 'student001' AND user_type = 1)
    OR (user_id = 3 AND username = 'teacher001' AND user_type = 2))
  AND password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EO';

SELECT ROW_COUNT() AS repaired_demo_accounts;
