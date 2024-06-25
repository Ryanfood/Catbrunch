package com.example.demo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.demo.model.po.Member;

//MemberDao 的實現類，使用 JDBC 來執行資料庫操作
@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	// 查詢所有
	@Override
	public List<Member> findAllMember() {
		String sql = "SELECT member_id, account, password, name, gender, birthday, email, phone, is_member FROM member";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Member.class));
	}

	// 根據 ID 單筆查詢，查不到會有 DataAccess 例外
	@Override
	public Member findMemberById(Integer memberId) {
	String sql = "SELECT member_id, account, password, name, gender, birthday, email, phone, is_member FROM member WHERE member_id = ?";
		
		try {
			return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Member.class), memberId);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	// 根據 Account 單筆查詢，查不到會有 DataAccess 例外
	@Override
	public Member findMemberByAccount(String account) {
		String sql = "SELECT member_id, account, password, salt, name, gender, birthday, email, phone, is_member FROM member WHERE account = ?";
		
		try {
			return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Member.class), account);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	
	// 新增
	@Override
	public int createMember(Member member) {
		String sql = "INSERT INTO member (account, password, salt, name, gender, birthday, email, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, member.getAccount(), member.getPassword(), member.getSalt(), member.getName(), member.getGender(), member.getBirthday(), member.getEmail(), member.getPhone());
	}
	

	// 修改
	@Override
	public int updateMember(Integer memberId, Member member) {
		String sql = "UPDATE member SET password = ?, name = ?, gender = ?, birthday = ?, email = ?, phone = ? WHERE member_id = ? and account = ?";
		return jdbcTemplate.update(sql, member.getPassword(), member.getName(), member.getGender(), member.getBirthday(), member.getEmail(), member.getPhone(), memberId, member.getAccount());
	}

	// 刪除
	@Override
	public int deleteMember(Integer memberId) {
		String sql = "DELETE FROM member WHERE member_id = ?";
		return jdbcTemplate.update(sql, memberId);
	}

	// 登入查詢是否有帳號密碼
	@Override
	public Member login(String account, String password) {
        String sql = "SELECT account, password, salt, name, is_member FROM member WHERE account = ? AND password = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Member.class), account, password);
        } catch (EmptyResultDataAccessException e) {
            return null; // 當沒有找到匹配的記錄時返回 null
        }
    }
	

	// 驗證 Account
	@Override
    public boolean checkAccount(String account) {
        String sql = "SELECT COUNT(*) FROM member WHERE account = ?";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, Integer.class, account);
            return count != null && count > 0;
        } catch (EmptyResultDataAccessException e) {
            // 查詢結果為空
            return false;
        } catch (DataAccessException e) {
            // 其他數據訪問異常
            e.printStackTrace();
            return false;
        }
    }

	// 驗證 Email
	@Override
	public boolean checkEmail(String email) {
		String sql = "SELECT COUNT(*) FROM member WHERE email = ?";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, Integer.class, email);
            return count != null && count > 0;
        } catch (EmptyResultDataAccessException e) {
            // 查詢結果為空
            return false;
        } catch (DataAccessException e) {
            // 其他數據訪問異常
            e.printStackTrace();
            return false;
        }
	}

	// 驗證 Phone
	@Override
	public boolean checkPhone(String phone) {
		String sql = "SELECT COUNT(*) FROM member WHERE phone = ?";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, Integer.class, phone);
            return count != null && count > 0;
        } catch (EmptyResultDataAccessException e) {
            // 查詢結果為空
            return false;
        } catch (DataAccessException e) {
            // 其他數據訪問異常
            e.printStackTrace();
            return false;
        }
	}

	@Override
	public Member findMemberByEmail(String email) {
	    String sql = "SELECT member_id, account, password, salt, name, gender, birthday, email, phone, is_member FROM member WHERE email = ?";
	    try {
	        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Member.class), email);
	    } catch (DataAccessException e) {
	        e.printStackTrace();
	        return null;
	    }
	}

	// 修改密碼及鹽值
	@Override
	public void update(Member member) {
	    String sql = "UPDATE member SET password = ?, salt = ? WHERE email = ?";
	    jdbcTemplate.update(sql, member.getPassword(), member.getSalt(), member.getEmail());
	}

	


}
