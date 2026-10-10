package com.ruoyi.studentlist.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.studentlist.domain.Student;
import com.ruoyi.studentlist.domain.vo.StudentVO;
import com.ruoyi.studentlist.service.LQYIStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 学生信息Controller（纯 MyBatis）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/students/student")
public class LQYStudentController extends BaseController
{
    @Autowired
    private LQYIStudentService lqyStudentService;

    /**
     * 查询学生列表（支持 className/grade/studentNo/searchValue 过滤）
     */
    @GetMapping("/list")
    public TableDataInfo list(Student student)
    {
        List<StudentVO> list = lqyStudentService.selectStudentList(student);
        return getDataTable(list);
    }

    /**
     * 查询所有不重复的班级列表（给前端分类标签用）
     */
    @GetMapping("/classes")
    public AjaxResult classes()
    {
        List<String> classes = lqyStudentService.selectDistinctClassList();
        return AjaxResult.success(classes);
    }

    /**
     * 获取学生详细信息
     */
    @GetMapping(value = "/{stuId}")
    public AjaxResult getInfo(@PathVariable Long stuId)
    {
        return AjaxResult.success(lqyStudentService.selectStudentById(stuId));
    }

    /**
     * 新增学生
     */
    @PostMapping
    public AjaxResult add(@RequestBody Student student)
    {
        return toAjax(lqyStudentService.insertStudent(student));
    }

    /**
     * 通过学号+姓名添加学生
     * POST /students/student/add-by-no-name
     * body: { "studentNo": "2024001", "realName": "陈小天" }
     */
    @PostMapping("/add-by-no-name")
    public AjaxResult addByNoName(@RequestBody Map<String, String> body)
    {
        String studentNo = body == null ? null : body.get("studentNo");
        String realName = body == null ? null : body.get("realName");
        if (StringUtils.isEmpty(studentNo) || StringUtils.isEmpty(realName))
        {
            return AjaxResult.error("学号和姓名不能为空");
        }
        try
        {
            Long stuId = lqyStudentService.addByStudentNoAndRealName(studentNo, realName);
            return AjaxResult.success("添加成功", stuId);
        }
        catch (Exception e)
        {
            // 业务异常：已添加/未找到用户 等
            String msg = e.getMessage() == null ? "添加失败" : e.getMessage();
            return AjaxResult.error(msg);
        }
    }

    /**
     * 修改学生
     */
    @PutMapping
    public AjaxResult edit(@RequestBody Student student)
    {
        return toAjax(lqyStudentService.updateStudent(student));
    }

    /**
     * 删除学生
     */
    @DeleteMapping("/{stuId}")
    public AjaxResult remove(@PathVariable Long stuId)
    {
        return toAjax(lqyStudentService.deleteStudentById(stuId));
    }
}
