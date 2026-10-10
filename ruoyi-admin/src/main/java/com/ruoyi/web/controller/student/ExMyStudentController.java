package com.ruoyi.web.controller.student;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.mystudent.domain.MyStudent;
import com.ruoyi.mystudent.service.IExMyStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/student/student")
public class ExMyStudentController extends BaseController
{
    @Autowired
    private IExMyStudentService exMyStudentService;

    @GetMapping("/list")
    public TableDataInfo list(MyStudent myStudent)
    {
        startPage();
        List<MyStudent> list = exMyStudentService.selectMyStudentList(myStudent);
        return getDataTable(list);
    }

    @GetMapping(value = "/{stuId}")
    public AjaxResult getInfo(@PathVariable("stuId") Long stuId)
    {
        return success(exMyStudentService.selectMyStudentById(stuId));
    }

    @GetMapping("/stats")
    public AjaxResult stats()
    {
        MyStudent param = new MyStudent();
        List<MyStudent> list = exMyStudentService.selectMyStudentList(param);
        MyStudent student = list.isEmpty() ? new MyStudent() : list.get(0);
        AjaxResult result = AjaxResult.success();
        result.put("studyHours", student.getStudyHours());
        result.put("totalQuestions", student.getTotalQuestions());
        result.put("correctQuestions", student.getCorrectQuestions());
        result.put("correctRate", student.getTotalQuestions() != null && student.getTotalQuestions() > 0
            ? Math.round(student.getCorrectQuestions() * 100.0 / student.getTotalQuestions()) : 0);
        return result;
    }
}
