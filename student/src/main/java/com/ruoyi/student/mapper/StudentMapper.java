package com.ruoyi.student.mapper;

import com.ruoyi.student.pojo.StudentInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.Map;
@Mapper
public interface StudentMapper {
    StudentInfo getStudentProfile(@Param("stuId") Long stuId);

    Map<String, Object> selectStudentByNo(@Param("studentNo") String studentNo);

    Long selectStuIdByUserId(@Param("userId") Long userId);

    Map<String, Object> getSettings(@Param("stuId") Long stuId);

    int updateSettings(@Param("stuId") Long stuId,
                       @Param("name") String name,
                       @Param("phone") String phone,
                       @Param("email") String email);

    String getPassword(@Param("stuId") Long stuId);

    int updatePassword(@Param("stuId") Long stuId,
                       @Param("newPassword") String newPassword);
}