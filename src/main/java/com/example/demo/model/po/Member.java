package com.example.demo.model.po;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
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

}
