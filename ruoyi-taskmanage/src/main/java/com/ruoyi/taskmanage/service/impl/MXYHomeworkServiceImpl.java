package com.ruoyi.taskmanage.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.taskmanage.domain.Homework;
import com.ruoyi.taskmanage.domain.HomeworkPublishRequest;
import com.ruoyi.taskmanage.mapper.MXYHomeworkMapper;
import com.ruoyi.taskmanage.mapper.MXYStudentMapper;
import com.ruoyi.taskmanage.service.IMXYHomeworkService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class MXYHomeworkServiceImpl implements IMXYHomeworkService {

    private static final Logger log = LoggerFactory.getLogger(MXYHomeworkServiceImpl.class);

    @Autowired private MXYHomeworkMapper homeworkMapper;
    @Autowired private MXYStudentMapper studentMapper;

    @Override public List<Homework> selectHomeworkList(Homework homework) { return homeworkMapper.selectHomeworkList(homework); }
    @Override public Homework selectHomeworkById(Long homeworkId) { return homeworkMapper.selectHomeworkById(homeworkId); }
    @Override public List<Homework> selectHomeworkByTeacherId(Long teacherId) { return homeworkMapper.selectHomeworkByTeacherId(teacherId); }
    @Override public long countPendingByTeacherId(Long teacherId) { return homeworkMapper.countPendingByTeacherId(teacherId); }
    @Override public int insertHomework(Homework homework) { return homeworkMapper.insertHomework(homework); }
    @Override public int updateHomework(Homework homework) { return homeworkMapper.updateHomework(homework); }
    @Override public int deleteHomeworkById(Long homeworkId) { return homeworkMapper.deleteHomeworkById(homeworkId); }

    /**
     * 教师发布作业
     * 业务规则:
     *   1. 必填:title / content / courseId / className / type / deadline
     *   2. 自动从 token 取 teacher_id
     *   3. status 默认 0(未提交);total_score 默认 100
     *      状态语义:0-未提交  1-已提交  2-已批改
     *   4. 按 class_name 查 my_student 拿到所有 stu_id,
     *      每位学生各写一条 my_homework(std_id=stu_id),
     *      N 个学生 → N 条记录
     */
    @Override
    public Long publish(HomeworkPublishRequest req) {
        if (req == null) {
            throw new ServiceException("请求不能为空");
        }
        if (isBlank(req.getTitle()))     throw new ServiceException("作业标题不能为空");
        if (isBlank(req.getContent()))   throw new ServiceException("作业内容不能为空");
        if (req.getCourseId() == null)   throw new ServiceException("请选择所属课程");
        if (isBlank(req.getClassName())) throw new ServiceException("请选择班级");
        if (req.getType() == null
                || req.getType() < 1 || req.getType() > 3) {
            throw new ServiceException("作业类型必须是 1-客观题 / 2-主观题 / 3-混合");
        }
        if (req.getDeadline() == null)   throw new ServiceException("截止时间不能为空");
        if (req.getTotalScore() == null) req.setTotalScore(100);

        Long teacherId = SecurityUtils.getTeacherId();
        if (teacherId == null) {
            throw new ServiceException("无法获取当前教师信息,请重新登录");
        }

        // 1) 查班级下所有学生 stu_id
        List<Long> stuIds = studentMapper.selectStuIdsByClassName(req.getClassName().trim());
        if (stuIds == null || stuIds.isEmpty()) {
            throw new ServiceException("班级 [" + req.getClassName() + "] 下未找到任何学生");
        }

        // 2) 拼 N 条 Homework 记录,每条只换 std_id
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime deadline = LocalDateTime.of(req.getDeadline(), now.toLocalTime().withNano(0));
        // 教师发布时 status=0(未提交)。0-未提交 1-已提交 2-已批改
        Integer status = 0;
        String title = req.getTitle().trim();
        String content = req.getContent().trim();
        Integer totalScore = req.getTotalScore();

        List<Homework> rows = new ArrayList<>(stuIds.size());
        for (Long stuId : stuIds) {
            Homework h = new Homework();
            h.setStdId(stuId);
            h.setCourseId(req.getCourseId());
            h.setTeacherId(teacherId);
            h.setHomeworkName(title);
            h.setContent(content);
            h.setType(req.getType());
            h.setTotalScore(totalScore);
            h.setDeadline(deadline);
            h.setStatus(status);
            h.setCreateTime(now);
            h.setUpdateTime(now);
            rows.add(h);
        }

        // 3) 批量插入 my_homework
        int n = homeworkMapper.insertBatch(rows);
        if (n <= 0) {
            throw new ServiceException("作业保存失败");
        }
        log.info("publish homework: title='{}' className={} 共 {} 人, 写入 {} 条 my_homework",
                title, req.getClassName(), stuIds.size(), n);
        // 返回第一条的 hwId,前端可凭此跳转作业详情
        return rows.get(0).getHomeworkId();
    }

    private static boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
}
