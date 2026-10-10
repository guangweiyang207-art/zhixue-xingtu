package com.ruoyi.studentlist.mapper;

import com.ruoyi.studentlist.domain.Student;
import com.ruoyi.studentlist.domain.vo.StudentVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * 学生信息Mapper接口（纯 MyBatis）
 *
 * @author ruoyi
 */
@Mapper
public interface LQYStudentMapper
{

    /**
     * 多表联查学生列表（my_student, my_sys_user where 关联条件，显式 AS 驼峰）
     */
    @Select("<script>"
            + "SELECT "
            + "s.stu_id AS stuId, "
            + "s.user_id AS userId, "
            + "s.student_no AS studentNo, "
            + "s.major AS major, "
            + "s.grade AS grade, "
            + "s.class_name AS className, "
            + "s.birthday AS birthday, "
            + "s.teacher_id AS teacherId, "
            + "s.rank_level AS rankLevel, "
            + "s.rank_score AS rankScore, "
            + "s.total_questions AS totalQuestions, "
            + "s.correct_questions AS correctQuestions, "
            + "s.study_hours AS studyHours, "
            + "s.create_time AS createTime, "
            + "s.update_time AS updateTime, "
            + "u.real_name AS realName, "
            + "u.avatar AS avatar, "
            + "u.phone AS phone, "
            + "u.email AS email "
            + "FROM my_student s, my_sys_user u "
            + "<where> s.user_id = u.user_id "
            + "<if test='className != null and className != \"\"'> AND s.class_name = #{className}</if>"
            + "<if test='grade != null and grade != \"\"'> AND s.grade = #{grade}</if>"
            + "<if test='studentNo != null and studentNo != \"\"'> AND s.student_no LIKE CONCAT('%', #{studentNo}, '%')</if>"
            + "<if test='searchValue != null and searchValue != \"\"'> AND (s.student_no LIKE CONCAT('%', #{searchValue}, '%') OR s.class_name LIKE CONCAT('%', #{searchValue}, '%') OR u.real_name LIKE CONCAT('%', #{searchValue}, '%'))</if>"
            + "</where>"
            + " ORDER BY s.stu_id DESC"
            + "</script>")
    List<StudentVO> selectStudentVOList(Student student);

    /**
     * 查询所有不重复的班级列表（用于分类标签）
     */
    @Select("SELECT DISTINCT class_name AS className FROM my_student "
            + "WHERE class_name IS NOT NULL AND class_name != '' "
            + "ORDER BY class_name")
    List<Map<String, String>> selectDistinctClassList();

    /**
     * 统计学生作业数据：作业总数、已批改数、平均分（用于 StudentVO 统计字段）
     * 返回 [{stuId, totalCount, gradedCount, avgScore}]
     * status: 0-未提交 1-已提交 2-已批改
     * 注意：列别名带反引号防止 MyBatis 转驼峰失败，统一返回驼峰 key
     */
    @Select("SELECT sh.`stu_id` AS `stuId`, "
            + "COUNT(*) AS `totalCount`, "
            + "SUM(CASE WHEN sh.`status` = 2 THEN 1 ELSE 0 END) AS `gradedCount`, "
            + "AVG(sh.`score`) AS `avgScore` "
            + "FROM my_student_homework sh GROUP BY sh.`stu_id`")
    List<Map<String, Object>> selectStudentHomeworkStats();

    /**
     * 根据用户ID查询学生
     */
    @Select("SELECT * FROM my_student WHERE user_id = #{userId} LIMIT 1")
    Student selectStudentByUserId(@Param("userId") Long userId);

    /**
     * 两表联查：判断 my_student 是否已有关联 my_sys_user.real_name=姓名的学生（即小程序学生列表里是否已包含该姓名的学生）
     * 返回 {stuId, userId, studentNo, realName} 或 null
     */
    @Select("SELECT s.stu_id AS stuId, s.user_id AS userId, s.student_no AS studentNo, u.real_name AS realName "
            + "FROM my_student s, my_sys_user u "
            + "WHERE s.user_id = u.user_id "
            + "AND u.real_name = #{realName} "
            + "LIMIT 1")
    Map<String, Object> checkStudentExistsByJoin(@Param("realName") String realName);

    /**
     * 根据姓名在 my_sys_user 查 user_id（用于获取即将关联到 my_student 的用户）
     * 返回 {userId} 或 null
     */
    @Select("SELECT user_id AS userId FROM my_sys_user WHERE real_name = #{realName} LIMIT 1")
    Map<String, Object> findSysUserIdByRealName(@Param("realName") String realName);

    /**
     * 判断 my_student.student_no 字段是否已被其他学生占用
     * 返回 {stuId, userId, studentNo} 或 null
     */
    @Select("SELECT stu_id AS stuId, user_id AS userId, student_no AS studentNo "
            + "FROM my_student WHERE student_no = #{studentNo} LIMIT 1")
    Map<String, Object> checkStudentNoExists(@Param("studentNo") String studentNo);

    /**
     * 根据ID查询学生（带 JOIN，显式 AS 驼峰，返回带 realName/avatar/phone/email 的 StudentVO）
     */
    @Select("SELECT "
            + "s.stu_id AS stuId, "
            + "s.user_id AS userId, "
            + "s.student_no AS studentNo, "
            + "s.major AS major, "
            + "s.grade AS grade, "
            + "s.class_name AS className, "
            + "s.birthday AS birthday, "
            + "s.teacher_id AS teacherId, "
            + "s.rank_level AS rankLevel, "
            + "s.rank_score AS rankScore, "
            + "s.total_questions AS totalQuestions, "
            + "s.correct_questions AS correctQuestions, "
            + "s.study_hours AS studyHours, "
            + "s.create_time AS createTime, "
            + "s.update_time AS updateTime, "
            + "u.real_name AS realName, "
            + "u.avatar AS avatar, "
            + "u.phone AS phone, "
            + "u.email AS email "
            + "FROM my_student s, my_sys_user u "
            + "WHERE s.user_id = u.user_id AND s.stu_id = #{stuId}")
    StudentVO selectStudentVOById(@Param("stuId") Long stuId);

    /**
     * 新增学生
     */
    @Insert("INSERT INTO my_student(stu_id, user_id, student_no, major, grade, class_name, birthday, teacher_id, rank_level) "
            + "VALUES(#{stuId}, #{userId}, #{studentNo}, #{major}, #{grade}, #{className}, #{birthday}, #{teacherId}, #{rankLevel})")
    int insertStudent(Student student);

    /**
     * 修改学生
     */
    @Update("UPDATE my_student SET user_id=#{userId}, student_no=#{studentNo}, major=#{major}, grade=#{grade}, "
            + "class_name=#{className}, birthday=#{birthday}, teacher_id=#{teacherId}, rank_level=#{rankLevel} "
            + "WHERE stu_id=#{stuId}")
    int updateStudent(Student student);

    /**
     * 删除学生
     */
    @Delete("DELETE FROM my_student WHERE stu_id = #{stuId}")
    int deleteStudentById(@Param("stuId") Long stuId);
}
