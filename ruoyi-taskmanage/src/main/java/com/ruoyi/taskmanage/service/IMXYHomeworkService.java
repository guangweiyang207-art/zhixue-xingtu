package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.Homework;
import com.ruoyi.taskmanage.domain.HomeworkPublishRequest;
import java.util.List;

/**
 * 作业 Service 接口
 *
 * @author 马孝银
 */
public interface IMXYHomeworkService {

    List<Homework> selectHomeworkList(Homework homework);

    Homework selectHomeworkById(Long homeworkId);

    List<Homework> selectHomeworkByTeacherId(Long teacherId);

    long countPendingByTeacherId(Long teacherId);

    int insertHomework(Homework homework);

    int updateHomework(Homework homework);

    int deleteHomeworkById(Long homeworkId);

    /**
     * 教师发布作业(注入 teacher_id + 自动派发到班级学生)
     * @return 新建作业的 hw_id
     */
    Long publish(HomeworkPublishRequest req);
}
