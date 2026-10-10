package com.ruoyi.homepage.domain;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 全局搜索结果(主页)
 *
 * @author 马孝银
 */
@Data
public class SearchResult implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 关键词 */
    private String keyword;

    /** 命中课程 */
    private List<?> courseList;

    /** 命中作业 */
    private List<?> homeworkList;

    /** 命中通知 */
    private List<?> noticeList;
}
