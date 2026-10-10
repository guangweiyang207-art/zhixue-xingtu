package com.ruoyi.home.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "home_quick_link")
public class HomeQuickLink {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false, length = 50)
    private String icon;

    @Column(nullable = false, length = 20)
    private String bgColor;

    @Column(nullable = false, length = 20)
    private String iconColor;

    @Column(length = 200)
    private String path;

    @Column(nullable = false)
    private Integer sortOrder = 0;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public String getBgColor() { return bgColor; }
    public void setBgColor(String bgColor) { this.bgColor = bgColor; }
    public String getIconColor() { return iconColor; }
    public void setIconColor(String iconColor) { this.iconColor = iconColor; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
}
