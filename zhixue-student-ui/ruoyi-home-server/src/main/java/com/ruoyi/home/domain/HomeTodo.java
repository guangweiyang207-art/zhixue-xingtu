package com.ruoyi.home.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "home_todo")
public class HomeTodo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 120)
    private String title;

    @Column(length = 120)
    private String subtitle;

    @Column(nullable = false, length = 20)
    private String accentColor;

    @Column(nullable = false, length = 20)
    private String buttonText;

    @Column(nullable = false, length = 20)
    private String buttonColor;

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
    public String getSubtitle() { return subtitle; }
    public void setSubtitle(String subtitle) { this.subtitle = subtitle; }
    public String getAccentColor() { return accentColor; }
    public void setAccentColor(String accentColor) { this.accentColor = accentColor; }
    public String getButtonText() { return buttonText; }
    public void setButtonText(String buttonText) { this.buttonText = buttonText; }
    public String getButtonColor() { return buttonColor; }
    public void setButtonColor(String buttonColor) { this.buttonColor = buttonColor; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
