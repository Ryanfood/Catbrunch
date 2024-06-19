package com.example.demo.dao;

import java.util.List;

import com.example.demo.model.po.Member;

public interface MemberDao {	
	List<Member> findAllMember(); // 多筆查詢
	Member findMemberById(Integer memberId); // Id單筆查詢
	Member findMemberByAccount(String account); // Account單筆查詢
	int createMember(Member member); // 新增
	int updateMember(Integer memberId, Member member); // 修改
	int deleteMember(Integer memberId); // 刪除
	Member login(String account, String password); // 登入
	
	boolean checkAccount(String account); // 驗證Account
	boolean checkEmail(String email); // 驗證Email
	boolean checkPhone(String phone); // 驗證Phone
}
