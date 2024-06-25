package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.po.Member;
import com.example.demo.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	
	// 將資料傳到 member_backend
	@GetMapping("/member_backend")
	public String getAllMember(Model model) {
		List<Member> memberList = memberService.getAllMember();
		model.addAttribute("memberList", memberList);
		return "member_backend";
	}
	/*
	@GetMapping("/member_backend")
	public String getAllMember(Model model) {
	    List<Member> memberList = memberService.getAllMember();

	    // 處理每個會員的姓名、電子郵件和手機號碼
	    for (Member member : memberList) {
	        // 處理姓名
	        String name = member.getName();
	        if (name.length() > 2) {
	            String middlePart = "<i class=\"fa fa-paw\"></i>".repeat(name.length() - 2);
	            String maskedName = name.charAt(0) + middlePart + name.charAt(name.length() - 1);
	            member.setName(maskedName);
	        }

	        // 處理電子郵件
	        String email = member.getEmail();
	        int atIndex = email.indexOf('@');
	        String maskedEmail = email.substring(0, 3) + "*".repeat(atIndex - 3) + email.substring(atIndex);
	        member.setEmail(maskedEmail);

	        // 處理手機號碼
	        String phone = member.getPhone();
	        String maskedPhone = phone.substring(0, 3) + "*".repeat(phone.length() - 6) + phone.substring(phone.length() - 3);
	        member.setPhone(maskedPhone);
	    }

	    model.addAttribute("memberList", memberList);
	    return "member_backend";
	}
	*/
	
	// 新增 member
    @PostMapping("/member_backend/")
    public String createMember(@ModelAttribute Member member, Model model) throws Exception {
   
        // 新增會員
        memberService.createMember(member);

        List<Member> memberList = memberService.getAllMember();
        model.addAttribute("member", member);
        
        model.addAttribute("memberList", memberList);
        model.addAttribute("_method", "PUT");
        // 1秒後再跳轉
        Thread.sleep(1000);
        return "redirect:/member";
    }
	
    // 修改 member
    @PutMapping("/member_backend/{memberId}")
    @ResponseBody
    public String upddateMember(@ModelAttribute Member member,
    						    @PathVariable("memberId") Integer memberId, 
							    Model model) throws InterruptedException {	
		// 修改會員資料
		memberService.updateMember(memberId, member);
		
		// 調用服務方法更新 Member
		List<Member> memberList = memberService.getAllMember();
		model.addAttribute("member", member);
		model.addAttribute("memberList", memberList);

		System.out.println("修改成功，ID為：" + memberId);
		model.addAttribute("_method", "PUT");
		// 1.3秒後再跳轉
        Thread.sleep(1300);
		return "member_backend";
    }
    
    // 刪除 member
    @DeleteMapping("/member_backend/{memberId}")
	public String deleteMember(@PathVariable("memberId") Integer memberId, Model model) throws Exception {
		System.out.println("刪除成功，ID為：" + memberId);
		//memberService.deleteMember(memberId);
		List<Member> memberList = memberService.getAllMember();
		model.addAttribute("memberList", memberList);
		// 1.3秒後再跳轉
        Thread.sleep(1300);
		return "member_backend";
	}
    

	// 檢查 Account 帳號是否存在
	@GetMapping("/member_backend/checkAccount")
	@ResponseBody
	public ResponseEntity<Map<String, Boolean>> checkAccount(@RequestParam String account) {
		boolean exists = memberService.checkAccount(account);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return ResponseEntity.ok(response);
	}
    
	// 檢查 Email 是否存在
	@GetMapping("/member_backend/checkEmail")
	@ResponseBody
	public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestParam String email) {
		boolean exists = memberService.checkEmail(email);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return ResponseEntity.ok(response);
	}
    
	// 檢查 Phone 是否存在
	@GetMapping("/member_backend/checkPhone")
	@ResponseBody
	public ResponseEntity<Map<String, Boolean>> checkPhone(@RequestParam String phone) {
		boolean exists = memberService.checkPhone(phone);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return ResponseEntity.ok(response);
	}
}
