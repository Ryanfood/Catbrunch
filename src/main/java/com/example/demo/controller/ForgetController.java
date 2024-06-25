package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.po.Member;
import com.example.demo.service.ForgetService;

import lombok.Getter;
import lombok.Setter;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@RestController
public class ForgetController {

    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
	private MemberDao memberDao;

    // 假設有一個服務來處理驗證碼的保存和驗證
    @Autowired
    private ForgetService forgetService;

    // 傳送驗證碼
    @PostMapping("/forget")
    public String sendVerificationCode(@RequestBody EmailRequest emailRequest) {
        String email = emailRequest.getEmail();
        if (email == null || email.isEmpty()) {
            return "無效的電子郵件地址";
        }
        
        Member member = memberDao.findMemberByEmail(email);
        String name = member.getName();

        // 生成驗證碼
        String verificationCode = generateVerificationCode();
        
        // 保存驗證碼和電子郵件對應關係（例如，保存到數據庫）
        forgetService.saveVerificationCode(email, verificationCode);

        // 生成失效時間
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date expiryDate = new Date(System.currentTimeMillis() + 5 * 60 * 1000); // 5分鐘後
        String expiryDateStr = dateFormat.format(expiryDate);
        
        // 發送驗證碼郵件
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setFrom("Catbrunch");
        message.setSubject("Catbrunch 驗證碼");
        
        member.getName();
        
        String emailContent = "親愛的 " + name + "，\n\n" +
                "您的驗證碼是：【" + verificationCode + "】。\n" +
                "請注意，此驗證碼僅供一次性使用，請勿將驗證碼分享給他人。\n\n" +
                "驗證碼應於5分鐘內（" + expiryDateStr + "前）完成輸入，逾時請重新申請。\n\n" +
                "如非本人操作，請忽略此郵件。\n\n" +
                "祝您使用愉快！\n\n" +
                "Catbrunch 團隊，喵喵喵。\n\n";
        message.setText(emailContent); 
        mailSender.send(message);

        return "驗證碼已發送";
    }

    // 生成驗證碼
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }
    
    @PostMapping("/verify-code")
    //@ResponseBody
    public String verifyCode(@RequestBody VerificationRequest verificationRequest) {
        String email = verificationRequest.getEmail();
        String code = verificationRequest.getCode();
        
        boolean isValid = forgetService.validateVerificationCode(email, code);
        if (isValid) {
            return "驗證成功";
        } else {
            return "驗證碼無效或已過期";
        }
    }

    // 修改密碼
    @PutMapping("/reset-password")
    @ResponseBody
    public String resetPassword(@RequestBody ResetPasswordRequest resetPasswordRequest, Model model) {
        String email = resetPasswordRequest.getEmail();
        String newPassword = resetPasswordRequest.getNewPassword();

        boolean isReset = forgetService.resetPassword(email, newPassword);
        if (isReset) {

    		System.out.println("修改成功，email為：" + email);
            return "member";
        } else {
        	System.out.println("修改失敗，email為：" + email);
            return "member";
        }
    }
    
    
}
	
	@Getter
	@Setter
	class EmailRequest {
	    private String email;
	}
	
	@Getter
	@Setter
	class VerificationRequest {
	    private String email;
	    private String code;
	}
	
	@Getter
	@Setter
	class ResetPasswordRequest {
	    private String email;
	    private String newPassword;
	}
