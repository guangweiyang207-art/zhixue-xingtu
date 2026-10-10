package com.ruoyi.homepage.service.impl;

import com.ruoyi.homepage.domain.SearchResult;
import com.ruoyi.homepage.mapper.MXYSearchMapper;
import com.ruoyi.homepage.service.IMXYSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MXYSearchServiceImpl implements IMXYSearchService {

    private static final int LIMIT = 10;

    @Autowired private MXYSearchMapper mapper;

    @Override
    public SearchResult search(String keyword) {
        if (keyword == null) keyword = "";
        SearchResult r = new SearchResult();
        r.setKeyword(keyword);
        r.setCourseList(mapper.searchCourse(keyword, LIMIT));
        r.setHomeworkList(mapper.searchHomework(keyword, LIMIT));
        r.setNoticeList(mapper.searchNotice(keyword, LIMIT));
        return r;
    }
}
