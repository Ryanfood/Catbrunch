package com.example.demo.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.example.demo.model.po.News;

// NewsDao 的實現類，使用 JDBC 來執行資料庫操作
@Repository
public class NewsDaoImpl implements NewsDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 查詢所有
    @Override
    public List<News> findAllNews() {
        String sql = "SELECT news_id, news_title, content, news_image, start_date, end_date, combo_name, combo_price FROM news";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(News.class));
    }

    // 根據 ID 單筆查詢，查不到會有 DataAccess 例外
    @Override
    public News findNewsById(Integer newsId) {
        String sql = "SELECT news_id, news_title, content, news_image, start_date, end_date, combo_name, combo_price FROM news WHERE news_id = ?";
        
        try {
        	return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(News.class), newsId);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;
		}
        
    }
    
    // 新增
 	@Override
 	public int createNews(News news) {
 		String sql = "INSERT INTO news (news_title, content, news_image, start_date, end_date, combo_name, combo_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
 		return jdbcTemplate.update(sql, news.getNewsTitle(), news.getContent(), news.getNewsImage(), news.getStartDate(), news.getEndDate(), news.getComboName(), news.getComboPrice());
 	}
    

    // 修改
    @Override
    public int updateNews(Integer newsId, News news) {
        String sql = "UPDATE news SET news_title = ?, content = ?, news_image = ?, start_date = ?, end_date = ?, combo_name = ?, combo_price = ? WHERE news_id = ?";
        return jdbcTemplate.update(sql, news.getNewsTitle(), news.getContent(), news.getNewsImage(), news.getStartDate(), news.getEndDate(), news.getComboName(), news.getComboPrice(), newsId);
    }

    // 刪除
    @Override
    public int deleteNews(Integer newsId) {
        String sql = "DELETE FROM news WHERE news_id = ?";
        return jdbcTemplate.update(sql, newsId);
    }


}
