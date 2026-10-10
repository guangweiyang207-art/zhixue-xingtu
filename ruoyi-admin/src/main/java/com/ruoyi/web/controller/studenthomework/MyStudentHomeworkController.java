package com.ruoyi.web.controller.studenthomework;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.myhomework.domain.MyHomework;
import com.ruoyi.myhomework.service.IExMyHomeworkService;
import com.ruoyi.mystudent.domain.MyStudent;
import com.ruoyi.mystudent.service.IExMyStudentService;
import com.ruoyi.mystudenthomework.domain.MyStudentHomework;
import com.ruoyi.mystudenthomework.service.IMyStudentHomeworkService;
import com.ruoyi.homework.service.IMyHomeworkService;
import com.ruoyi.homepage.domain.StudentHomeworkDetailVO.QuestionForGrade;
import com.ruoyi.homepage.mapper.MXYQuestionGradeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/studenthomework/homework")
public class MyStudentHomeworkController extends BaseController
{
    @Autowired
    private IMyStudentHomeworkService myStudentHomeworkService;

    @Autowired
    private IExMyStudentService exMyStudentService;

    @Autowired
    private IExMyHomeworkService exMyHomeworkService;

    @Autowired
    private IMyHomeworkService myHomeworkService;

    @Autowired
    private MXYQuestionGradeMapper questionGradeMapper;

    /**
     * 学生作答用题目列表(不含正确答案)
     */
    @GetMapping("/questions/{hwId}")
    public AjaxResult questions(@PathVariable("hwId") Long hwId)
    {
        List<QuestionForGrade> questions = questionGradeMapper.selectQuestionsForAnswer(hwId);
        return success(questions);
    }

    @GetMapping("/list")
    public TableDataInfo list(MyStudentHomework myStudentHomework)
    {
        startPage();
        List<MyStudentHomework> list = myStudentHomeworkService.selectMyStudentHomeworkList(myStudentHomework);
        return getDataTable(list);
    }

    /**
     * 学生端"我的作业"专用:返回当前登录学生所有作业(待完成/已提交/已批改)
     * 数据来源 my_homework LEFT JOIN my_student_homework,按当前 token 解析 student
     */
    @GetMapping("/myList")
    public AjaxResult myList()
    {
        Long userId = SecurityUtils.getUserId();
        if (userId == null) return error("未登录");
        List<MyHomework> list = exMyHomeworkService.selectMyHomeworkByUserId(userId);
        return success(list);
    }

    @GetMapping(value = "/{shId}")
    public AjaxResult getInfo(@PathVariable("shId") Long shId)
    {
        return success(myStudentHomeworkService.selectMyStudentHomeworkById(shId));
    }

    @GetMapping("/detail/{hwId}")
    public AjaxResult detail(@PathVariable("hwId") Long hwId)
    {
        Long userId = SecurityUtils.getUserId();
        MyStudent query = new MyStudent();
        query.setUserId(userId);
        List<MyStudent> students = exMyStudentService.selectMyStudentList(query);
        if (students == null || students.isEmpty())
        {
            return error("未找到学生信息");
        }
        Long stuId = students.get(0).getStuId();

        MyHomework homework = exMyHomeworkService.selectMyHomeworkById(hwId);
        if (homework == null)
        {
            return error("作业不存在");
        }

        MyStudentHomework querySh = new MyStudentHomework();
        querySh.setStuId(stuId);
        querySh.setHwId(hwId);
        List<MyStudentHomework> list = myStudentHomeworkService.selectMyStudentHomeworkList(querySh);
        MyStudentHomework studentHomework = (list != null && !list.isEmpty()) ? list.get(0) : null;

        Integer status = 0;
        String answers = "";
        if (studentHomework != null)
        {
            answers = studentHomework.getAnswers();
            if (answers == null || answers.trim().isEmpty())
            {
                status = 0;
            }
            else
            {
                status = studentHomework.getStatus();
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("hwId", homework.getHwId());
        result.put("title", homework.getTitle());
        result.put("content", homework.getContent());
        result.put("deadline", homework.getDeadline());
        result.put("totalScore", homework.getTotalScore());
        result.put("status", status);
        result.put("answers", answers);
        result.put("score", studentHomework != null ? studentHomework.getScore() : null);
        result.put("teacherComment", studentHomework != null ? studentHomework.getTeacherComment() : null);
        result.put("submitTime", studentHomework != null ? studentHomework.getSubmitTime() : null);

        return success(result);
    }

    @PostMapping("/submit")
    public AjaxResult submit(@RequestBody MyStudentHomework param)
    {
        Long userId = SecurityUtils.getUserId();
        MyStudent query = new MyStudent();
        query.setUserId(userId);
        List<MyStudent> students = exMyStudentService.selectMyStudentList(query);
        if (students == null || students.isEmpty())
        {
            return error("未找到学生信息");
        }
        Long stuId = students.get(0).getStuId();
        Long hwId = param.getHwId();

        // 0-未提交,1-已提交,2-已批改。如果已批改则禁止再提交
        MyStudentHomework querySh = new MyStudentHomework();
        querySh.setStuId(stuId);
        querySh.setHwId(hwId);
        List<MyStudentHomework> exists = myStudentHomeworkService.selectMyStudentHomeworkList(querySh);
        if (exists != null && !exists.isEmpty())
        {
            MyStudentHomework exist = exists.get(0);
            if (Integer.valueOf(2).equals(exist.getStatus()))
            {
                return error("作业已批改，无法再次提交");
            }
        }

        Date now = new Date();
        // 统一参数:my_student_homework.status = 1
        param.setStuId(stuId);
        param.setStatus(1);
        param.setSubmitTime(now);
        param.setUpdateTime(now);
        if (param.getCreateTime() == null) {
            param.setCreateTime(now);
        }

        // 1) 先尝试按 (stu_id, hw_id) UPDATE 已存在的 my_student_homework 记录
        int affected = myStudentHomeworkService.submitMyStudentHomework(param);

        // 2) 如果没有匹配记录(0 行受影响),回退为 INSERT
        if (affected == 0) {
            myStudentHomeworkService.insertMyStudentHomework(param);
        }

        // 3) ★ 同步更新 my_homework.status = 1
        //    主路径:按 hw_id 更新(把"做的是哪个作业"的那条记录 status 改 1)
        //    兜底路径:按 (hw_id, std_id) 精确更新(避免误改其他学生)
        com.ruoyi.homework.domain.MyHomework hwByHwId = new com.ruoyi.homework.domain.MyHomework();
        hwByHwId.setHwId(hwId);
        hwByHwId.setStatus(1L);
        int hwAffected = myHomeworkService.updateMyHomeworkStatusByStu(hwByHwId);
        System.out.println("[submit] my_homework 按 hw_id 同步 status=1, hwId=" + hwId + ", affected=" + hwAffected);

        if (hwAffected == 0) {
            com.ruoyi.homework.domain.MyHomework hwExact = new com.ruoyi.homework.domain.MyHomework();
            hwExact.setHwId(hwId);
            hwExact.setStdId(stuId);
            hwExact.setStatus(1L);
            int hwExactAffected = myHomeworkService.updateMyHomeworkStatusByHwIdAndStuId(hwExact);
            System.out.println("[submit] my_homework 兜底 (hw_id, std_id) 更新, hwId=" + hwId + ", stuId=" + stuId + ", affected=" + hwExactAffected);
        }

        return success();
    }

    /**
     * 老师批改作业(状态 1 -> 2,双表同步)
     */
    @PostMapping("/grade")
    public AjaxResult grade(@RequestBody MyStudentHomework param)
    {
        if (param.getShId() == null) {
            return error("缺少提交记录ID");
        }
        MyStudentHomework exist = myStudentHomeworkService.selectMyStudentHomeworkById(param.getShId());
        if (exist == null) {
            return error("提交记录不存在");
        }
        if (Integer.valueOf(1).equals(exist.getStatus()) == false
                && Integer.valueOf(0).equals(exist.getStatus()) == false) {
            return error("当前状态不允许批改");
        }

        // 1) 更新 my_student_homework
        Date now = new Date();
        exist.setScore(param.getScore());
        exist.setTeacherComment(param.getTeacherComment());
        exist.setStatus(2);
        exist.setCorrectTime(now);
        exist.setUpdateTime(now);
        myStudentHomeworkService.updateMyStudentHomework(exist);

        // 2) 同步更新 my_homework.status = 2
        //    主路径按 (hw_id, std_id) 精确更新,影响 0 行时按 hw_id 兜底
        try {
            com.ruoyi.homework.domain.MyHomework hwStatus = new com.ruoyi.homework.domain.MyHomework();
            hwStatus.setHwId(exist.getHwId());
            hwStatus.setStdId(exist.getStuId());
            hwStatus.setStatus(2L);
            int hwAffected = myHomeworkService.updateMyHomeworkStatusByStu(hwStatus);
            System.out.println("[grade] my_homework 同步 status=2 主路径, hwId=" + exist.getHwId() + ", stdId=" + exist.getStuId() + ", affected=" + hwAffected);
            if (hwAffected == 0) {
                com.ruoyi.homework.domain.MyHomework hwByHwId = new com.ruoyi.homework.domain.MyHomework();
                hwByHwId.setHwId(exist.getHwId());
                hwByHwId.setStatus(2L);
                int hwFallback = myHomeworkService.updateMyHomeworkStatusByStu(hwByHwId);
                System.out.println("[grade] my_homework 同步 status=2 兜底, hwId=" + exist.getHwId() + ", affected=" + hwFallback);
            }
        } catch (Exception e) {
            System.err.println("[grade] 同步 my_homework.status 失败: " + e.getMessage());
        }
        return success();
    }
}
