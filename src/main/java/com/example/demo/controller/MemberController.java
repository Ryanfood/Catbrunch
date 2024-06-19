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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.model.po.Member;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpSession;

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
	
	
	// 新增 member
    @PostMapping("/member_backend/")
    public String createMember(@ModelAttribute Member member, Model model) throws Exception {
        /*
    	// 1.設定一個密碼
    	String password = member.getPassword();
    	// 2.隨機生成一個鹽(Salt)
		byte[] salt = new byte[16];
		SecureRandom secureRandom = new SecureRandom();
		secureRandom.nextBytes(salt); // 填充隨機值
		System.out.printf("鹽: %s%n", Arrays.toString(salt));
		System.out.printf("鹽(Hex): %s%n", KeyUtil.bytesToHex(salt));
		
		
		// 3.獲取 SHA-256 消息摘要物件來幫助我們生成密碼的哈希
		MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
    	
		// 4.加鹽
		messageDigest.update(salt);
		
		// 5.將密碼轉換為 byte[] 然後生成哈希
		byte[] hashedBytes = messageDigest.digest(password.getBytes());
    	
		// 6.將 byte[] 轉 Hex
		String hashedHexString = KeyUtil.bytesToHex(hashedBytes);
		System.out.printf("原始密碼: %s%n", password);
		System.out.printf("加鹽後的哈希密碼: %s%n", hashedHexString);

		// 設定加密後的密碼及鹽巴
    	member.setPassword(hashedHexString);
    	member.setSalt(KeyUtil.bytesToHex(salt));
    	
    	*/
   
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
    
    // 登入原本的登入
    // @ResponseBody 和 @RequestBody 是用 Ajax 沒有刷新頁面時使用
    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<?> login(@RequestBody Map<String, String> map, HttpSession session) throws Exception {
    	Member member = new Member();
    	try {
    		member = memberService.login(map.get("account"), map.get("password"));
    		
    	} catch (Exception e) {
    		
    	}
    	
    	// member 是傳給前端的資料
    	Map<String, Object> result = new HashMap<>();
    	result.put("member", member);
    	
    	session.setAttribute("loginStatus", true);
    	
    	return ResponseEntity.ok(result);
    	
    	
    	
    	/*
    	System.out.println(member);
    	// 如果沒有註冊帳號則無法查到密碼及鹽(check == null)
    	if(member != null) {
    		String password = member.getPassword();
    		String hash = member.getPassword();
    		String salt = member.getSalt();
    		
    		System.out.println("password: " + password);
    		System.out.println("hash: " + hash);
    		System.out.println("salt: " + salt);

    		// 1.獲取 SHA-256 消息摘要物件來幫助我們生成密碼的哈希
    		MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
    		// 2.hash轉回陣列再加鹽
    		messageDigest.update(KeyUtil.hexStringToByteArray(salt)); 
    		byte[] frontHash = messageDigest.digest(password.getBytes());

    		String inputHashedHexString = KeyUtil.bytesToHex(frontHash);
    		System.out.println(inputHashedHexString.equals(hash));
    	} else {
    		System.out.println("帳號不存在");
    	}
    	
    	*/
    	
    	
		
	}
	    
	/*
	// 登入
    // @ResponseBody 和 @RequestBody 是用 Ajax 沒有刷新頁面時使用
    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<?> login(@RequestBody Map<String, String> map) throws Exception {
    	Member member = memberService.login(map.get("account"), map.get("password"));
    	
    	Member member2 = memberService.getSalt(map.get("account"));
        System.out.println(member2);
        
        // 前端取得的帳號密碼
        String frontAccount = map.get("account");
        String frontPassword = map.get("password");                
        
        // 3.獲取 SHA-256 消息摘要物件來幫助我們生成密碼的哈希
     	MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
     		
 		// 4.加鹽
 		messageDigest.update(KeyUtil.hexStringToByteArray(member.getSalt()));

		byte[] inputHashedBytes = messageDigest.digest(frontPassword.getBytes());
		String inputHashedHexString = KeyUtil.bytesToHex(inputHashedBytes);

        // 將兩個加密後的密碼進行比對，如果相同，則表示密碼正確
        if (inputHashedHexString.equals(member.getPassword())) {
            // 密碼正確，進行登入操作
        	// member 是傳給前端的資料
            Map<String, Object> result = new HashMap<>();
            //result.put("member", member);
            return ResponseEntity.ok(result);
        } else {
            // 密碼錯誤，返回錯誤訊息或處理方式
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("密碼錯誤");
        }
	}
	*/
    
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
