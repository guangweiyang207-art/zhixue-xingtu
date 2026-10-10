package com.ruoyi.home.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "home_course")
public class HomeCourse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 120)
    private String title;

    @Column(nullable = false, length = 60)
    private String instructor;

    @Column(nullable = false)
    private Integer lessonCount;

    @Column(nullable = false)
    private Integer progress;

    @Column(nullable = false, length = 500)
    private String coverUrl;

    @Column(length = 200)
    private String path;

    @Column(nullable = false)
    private Integer sortOrder = 0;

    @Column(nullable = false, length = 1)
    private String status = "0";

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }
    public Integer getLessonCount() { return lessonCount; }
    public void setLessonCount(Integer lessonCount) { this.lessonCount = lessonCount; }
    public Integer getProgress() { return progress; }
    public void setProgress(Integer progress) { this.progress = progress; }
    public String getCoverUrl() { return coverUrl; }
    public void setCoverUrl(String coverUrl) { this.coverUrl = coverUrl; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
