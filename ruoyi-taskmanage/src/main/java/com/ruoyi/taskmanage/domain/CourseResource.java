package com.ruoyi.taskmanage.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 课程资源对象 my_course_resource
 * 表实际列:re_id, c_id, resource_type, title, content, file_url, video_url, homework,
 * sort_order, create_time, tag
 *
 * @author 马孝银
 */
@Data
public class CourseResource implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 资源ID(re_id) */
    private Long resourceId;

    /** 课程ID(c_id) */
    private Long courseId;

    /** 资源类型(1-视频 2-图书 4-期刊 5-讲座) */
    private Integer resourceType;

    /** 资源标题(title) */
    private String resourceName;

    /** 资源内容/描述 */
    private String content;

    /** 文件链接(file_url) */
    private String resourceUrl;

    /** 视频链接(video_url) */
    private String videoUrl;

    /** 作业内容 */
    private String homework;

    /** 排序 */
    private Integer sortOrder;

    /** 标签 */
    private String tag;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
