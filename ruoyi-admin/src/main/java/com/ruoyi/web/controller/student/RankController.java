package com.ruoyi.web.controller.student;

import com.ruoyi.common.R;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.student.mapper.RankMapper;
import com.ruoyi.student.pojo.RankConfig;
import com.ruoyi.student.pojo.RankInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@Anonymous
@RestController
@RequestMapping("/mine/rank")
public class RankController {

    @Autowired
    private RankMapper rankMapper;

    @GetMapping("/info")
    public R getRankInfo(@RequestParam("stu_id") Long stuId) {
        Map<String, Object> scoreData = rankMapper.getStudentScore(stuId);
        if (scoreData == null || scoreData.isEmpty()) {
            return R.error("无此学生信息");
        }

        Integer rankScore = ((Number) scoreData.get("rank_score")).intValue();
        String rankLevel = (String) scoreData.get("rank_level");
        Integer totalQuestions = scoreData.get("total_questions") != null
                ? ((Number) scoreData.get("total_questions")).intValue() : 0;
        Integer correctQuestions = scoreData.get("correct_questions") != null
                ? ((Number) scoreData.get("correct_questions")).intValue() : 0;

        RankConfig currentRank = rankMapper.getRankByScore(rankScore);
        RankConfig nextRank = rankMapper.getNextRank(rankScore);

        RankInfo info = new RankInfo();
        info.setRankLevel(rankLevel);
        info.setRankScore(rankScore);
        info.setTotalQuestions(totalQuestions);
        info.setCorrectQuestions(correctQuestions);

        if (currentRank != null) {
            info.setCurrentRankName(currentRank.getRankName());
            info.setCurrentRankIcon(currentRank.getRankIcon());
            info.setCurrentRankColor(currentRank.getColor());
            info.setCurrentRankDesc(currentRank.getDescription());
            info.setCurrentMinScore(currentRank.getMinScore());
            info.setCurrentMaxScore(currentRank.getMaxScore());
        }

        if (nextRank != null) {
            info.setNextRankName(nextRank.getRankName());
            info.setNextMinScore(nextRank.getMinScore());
        }

        if (currentRank != null && nextRank != null) {
            int range = nextRank.getMinScore() - currentRank.getMinScore();
            int progress = rankScore - currentRank.getMinScore();
            info.setProgress(range > 0 ? (progress * 100 / range) : 0);
        } else {
            info.setProgress(100);
        }

        return R.success(info);
    }
}