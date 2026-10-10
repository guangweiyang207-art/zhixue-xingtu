package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.QuestionAnswer;
import java.util.List;

public interface IMXYQuestionAnswerService {

    /** 列表(支持 stuId/teacherId/status 过滤) */
    List<QuestionAnswer> selectQaList(QuestionAnswer qa);

    /** 详情 */
    QuestionAnswer selectQaById(Long id);

    /** 学生提交问题 */
    int insertQa(QuestionAnswer qa);

    /** 老师回复 */
    int answerQa(QuestionAnswer qa);

    /** 修改(状态等) */
    int updateQa(QuestionAnswer qa);

    /** 删除 */
    int deleteQaById(Long id);
}
