package com.example.demo.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.KeyUtil;
import com.example.demo.dao.MemberDao;
import com.example.demo.model.po.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	// 取得多筆 member
	public List<Member> getAllMember() {
		
		return memberDao.findAllMember();
	}

	// 取得單筆 member
	public Member getMemberById(Integer memberId) {
		
		return memberDao.findMemberById(memberId);
	}

	// 新增 member
	public int createMember(Member member) throws Exception {
		
		if(member != null) {
			// 1.將 password 利用 SHA-256 加密
			String password = member.getPassword();
			// 隨機生成一個鹽(Salt)
			byte[] salt = new byte[16];
			SecureRandom secureRandom = new SecureRandom();
			
			// 2. 填充隨機值，取得 鹽(Hex)
			secureRandom.nextBytes(salt);
			
			// 3.取得 加鹽後的哈希密碼
			KeyUtil.bytesToHex(salt);
			
			// 獲取 SHA-256 消息摘要物件來幫助我們生成密碼的哈希
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			// 加鹽
			messageDigest.update(salt);
			// 將密碼轉換為 byte[] 然後生成哈希
			byte[] hashedBytes = messageDigest.digest(password.getBytes());
			// 將 byte[] 轉 Hex
			String hashedHexString = KeyUtil.bytesToHex(hashedBytes);
			System.out.printf("原始密碼: %s%n", password);
			System.out.printf("加鹽後的哈希密碼: %s%n", hashedHexString);
			
			// 4.存入 DB
			// 設定加密後的密碼及鹽巴
			member.setPassword(hashedHexString);
			member.setSalt(KeyUtil.bytesToHex(salt));
		} else {
    		System.out.println("帳號不存在");
    	}
		
		return memberDao.createMember(member);
	}
	

	// 修改 member
	public int updateMember(Integer memberId, Member member) {
		
		return memberDao.updateMember(memberId, member);
	}

	// 刪除 member
	public int deleteMember(Integer memberId) {
		
		return memberDao.deleteMember(memberId);
	}
	
	public Member login(String account, String password) throws Exception {
	    // 從資料庫中根據帳號查詢相應的會員
	    Member member = memberDao.findMemberByAccount(account);

	    // 如果找不到會員
	    if (member == null) {
	        System.out.println("查無此帳號");
	        return null; // 返回 null 表示找不到帳號
	    }

	    // 如果找到了會員，檢查密碼是否正確
	    if (!isPasswordCorrect(member, password)) {
	        System.out.println("密碼錯誤");
	        return null; // 返回 null 表示密碼錯誤
	    }

	    // 密碼正確，返回會員資料
	    return member;
	}

	// 檢查密碼是否正確的方法
	private boolean isPasswordCorrect(Member member, String password) throws NoSuchAlgorithmException {
	    String hash = member.getPassword();
	    String salt = member.getSalt();
	    String inputHashedHexString = hashPassword(password, salt);
	    return inputHashedHexString.equals(hash);
	}

	// 生成密碼的雜湊值的方法
	private String hashPassword(String password, String salt) throws NoSuchAlgorithmException {
	    MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
	    messageDigest.update(KeyUtil.hexStringToByteArray(salt));
	    byte[] inputHashedBytes = messageDigest.digest(password.getBytes());
	    return KeyUtil.bytesToHex(inputHashedBytes);
	}
	
	
	/*
	// 原本的登入
	public Member login(String account, String password) throws Exception {
		// 從資料庫中根據帳號查詢相應的會員
		Member member = memberDao.findMemberByAccount(account);

		// 如果沒有找到會員，印出訊息並拋出例外
		if (member == null) {
		    System.out.println("查無此帳號");
		    //throw new Exception("Account not found");
		    return null;
		}

		// 從資料庫中獲取會員的密碼雜湊值和鹽值
		String hash = member.getPassword();
		String salt = member.getSalt();

		// 獲取前端輸入的密碼
		String frontPassword = password;

		// 印出資料庫中的密碼雜湊值、鹽值和前端輸入的密碼
		System.out.println("hash: " + hash);
		System.out.println("salt: " + salt);
		System.out.println("frontPassword: " + frontPassword);

		// 獲取 SHA-256 消息摘要物件來生成密碼的雜湊值
		MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");

		// 將鹽值從十六進位字串轉換為位元組陣列並添加到消息摘要中
		messageDigest.update(KeyUtil.hexStringToByteArray(salt));

		// 將前端輸入的密碼轉換為位元組陣列並進行雜湊計算，得到雜湊位元組陣列
		byte[] inputHashedBytes = messageDigest.digest(password.getBytes());
		
		// 將生成的雜湊位元組陣列轉換為十六進位字串
		String inputHashedHexString = KeyUtil.bytesToHex(inputHashedBytes);

		// 印出生成的雜湊十六進位字串和它是否與資料庫中的雜湊值相等
		System.out.println(inputHashedHexString);
		System.out.println(inputHashedHexString.equals(hash));

		// 調用 memberDao 的 login 方法，傳遞帳號和生成的雜湊十六進位字串，進行登入操作並返回結果
		return memberDao.login(account, inputHashedHexString);
	}
	*/

	// 驗證 Account 是否存在
	public boolean checkAccount(String account) {
		
        return memberDao.checkAccount(account);
    }

	// 驗證 Email 是否存在
	public boolean checkEmail(String email) {
		
        return memberDao.checkEmail(email);
    }
	
	// 驗證 Phone 是否存在
	public boolean checkPhone(String phone) {
		
        return memberDao.checkPhone(phone);
    }
}
