package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.po.Member;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	
    // 登入
    // @ResponseBody 和 @RequestBody 是用 Ajax 沒有刷新頁面時使用
    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<?> login(@RequestBody Map<String, String> map, HttpSession session) throws Exception {
    	Member member = new Member();
    	try {
    		member = memberService.login(map.get("account"), map.get("password"));
    		
    	} catch (Exception e) {
    		
    	}
    	
    	if (member != null) {
			// member 是傳給前端的資料
			Map<String, Object> result = new HashMap<>();
			result.put("member", member);
			result.put("isMember", member.getIsMember());
			System.out.println("登入權限為：" + member.getIsMember());
			
			System.out.println("登入成功");
			session.setAttribute("loginStatus", true);
			return ResponseEntity.ok(result);
    	}
    	return null;
	}
	
    
    // 登出
    @GetMapping("/logout")
    private String logout(HttpSession session) {
		System.out.println("登出成功");
    	session.invalidate();
    	return "redirect:/index";
    }
    
    

}
