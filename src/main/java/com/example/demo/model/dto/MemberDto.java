package com.example.demo.model.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.example.demo.model.po.Member;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
	private Integer memberId;
	private String account;
	private String password;
	private String salt;
	private String name;
	private String gender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	private String email;
	private String phone;
	private Integer isMember;
	
	private Member member;
}
