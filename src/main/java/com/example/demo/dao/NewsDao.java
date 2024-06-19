package com.example.demo.dao;
import java.util.List;

import com.example.demo.model.po.News;

public interface NewsDao {
    List<News> findAllNews(); // 多筆查詢
    News findNewsById(Integer newsId); //單筆查詢
    int createNews(News news);  // 新增
    int updateNews(Integer newsId, News news); // 修改
    int deleteNews(Integer newsId); // 刪除     
}
