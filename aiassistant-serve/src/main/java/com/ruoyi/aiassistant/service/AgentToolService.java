package com.ruoyi.aiassistant.service;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

/**
 * Agent 业务工具集(Function Calling):LLM 自主决定调用,ReAct 循环中执行
 * 工具执行走业务库真实数据,结果拼成文本回填给 LLM 作为 tool 消息
 */
@Service
public class AgentToolService
{
    private static final Logger log = LoggerFactory.getLogger(AgentToolService.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /** 按 tool name 分发执行,返回给 LLM 的文本结果 */
    public String execute(String name, String argumentsJson, Long userId)
    {
        log.info("Agent工具调用: name={}, args={}, userId={}", name, argumentsJson, userId);
        switch (name == null ? "" : name)
        {
            case "query_error_book":
                return queryErrorBook(userId);
            case "query_homework":
                return queryHomework(userId);
            case "recommend_practice":
                return recommendPractice(userId);
            default:
                return "未知工具: " + name;
        }
    }

    /** 工具1:查错题本统计(薄弱知识点) */
    private String queryErrorBook(Long userId)
    {
        Long stuId = getStuId(userId);
        if (stuId == null)
        {
            return "该用户没有学生档案,无法查询错题本";
        }
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
            "SELECT IFNULL(tag,'未分类') AS tag, COUNT(*) AS cnt, IFNULL(SUM(error_count),0) AS errs "
                + "FROM my_error_book WHERE stu_id = ? AND IFNULL(is_mastered,0) = 0 "
                + "GROUP BY tag ORDER BY errs DESC LIMIT 8", stuId);
        if (rows.isEmpty())
        {
            return "错题本当前为空,学生已掌握全部错题";
        }
        int total = 0;
        StringBuilder sb = new StringBuilder("错题本统计(未掌握):");
        for (Map<String, Object> r : rows)
        {
            total += ((Number) r.get("cnt")).intValue();
            sb.append("\n- ").append(r.get("tag")).append(": ").append(r.get("cnt"))
                .append("题/累计错误").append(r.get("errs")).append("次");
        }
        sb.append("\n共").append(total).append("道错题,薄弱点按错误次数降序排列");
        return sb.toString();
    }

    /** 工具2:查最近作业完成情况与成绩 */
    private String queryHomework(Long userId)
    {
        Long stuId = getStuId(userId);
        if (stuId == null)
        {
            return "该用户没有学生档案,无法查询作业";
        }
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
            "SELECT hw.title, sh.status, sh.score, hw.deadline "
                + "FROM my_student_homework sh JOIN my_homework hw ON sh.hw_id = hw.hw_id "
                + "WHERE sh.stu_id = ? ORDER BY sh.create_time DESC LIMIT 5", stuId);
        if (rows.isEmpty())
        {
            return "该学生还没有作业记录";
        }
        StringBuilder sb = new StringBuilder("最近作业情况:");
        for (Map<String, Object> r : rows)
        {
            int st = r.get("status") == null ? 0 : ((Number) r.get("status")).intValue();
            String statusText = st >= 2 ? "已批改" : (st == 1 ? "已提交待批改" : "未完成");
            sb.append("\n- ").append(r.get("title")).append(": ").append(statusText);
            if (r.get("score") != null)
            {
                sb.append(",得分").append(r.get("score"));
            }
        }
        return sb.toString();
    }

    /** 工具3:根据薄弱点推荐练习(未完成作业 + 对应课程) */
    private String recommendPractice(Long userId)
    {
        Long stuId = getStuId(userId);
        if (stuId == null)
        {
            return "该用户没有学生档案,无法推荐练习";
        }
        StringBuilder sb = new StringBuilder();
        // 未完成/未批改的作业
        List<Map<String, Object>> undone = jdbcTemplate.queryForList(
            "SELECT hw.title, c.c_name, c.type FROM my_student_homework sh "
                + "JOIN my_homework hw ON sh.hw_id = hw.hw_id "
                + "LEFT JOIN my_course c ON hw.c_id = c.c_id "
                + "WHERE sh.stu_id = ? AND IFNULL(sh.status,0) < 2 "
                + "ORDER BY hw.deadline ASC LIMIT 3", stuId);
        if (!undone.isEmpty())
        {
            sb.append("待完成作业(建议优先):");
            for (Map<String, Object> r : undone)
            {
                sb.append("\n- ").append(r.get("title"))
                    .append("(课程:").append(r.get("c_name") == null ? "未知" : r.get("c_name"))
                    .append("/类型:").append(r.get("type") == null ? "未知" : r.get("type")).append(")");
            }
        }
        else
        {
            sb.append("当前没有待完成作业");
        }
        // 薄弱知识点对应的课程
        List<Map<String, Object>> weak = jdbcTemplate.queryForList(
            "SELECT IFNULL(tag,'未分类') AS tag FROM my_error_book "
                + "WHERE stu_id = ? AND IFNULL(is_mastered,0) = 0 "
                + "GROUP BY tag ORDER BY SUM(error_count) DESC LIMIT 3", stuId);
        if (!weak.isEmpty())
        {
            sb.append("\n\n结合错题薄弱点,建议针对性练习这些知识点:");
            for (Map<String, Object> r : weak)
            {
                sb.append("\n- ").append(r.get("tag"));
            }
        }
        return sb.toString();
    }

    /** userId -> stuId(学生档案) */
    private Long getStuId(Long userId)
    {
        if (userId == null)
        {
            return null;
        }
        List<Long> ids = jdbcTemplate.queryForList(
            "SELECT stu_id FROM my_student WHERE user_id = ?", Long.class, userId);
        return ids.isEmpty() ? null : ids.get(0);
    }
}
