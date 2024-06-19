package com.example.demo.model.po;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class News {
  private Integer newsId;
  private String newsTitle;
  private String content;  
  
  private String newsImage;
  @DateTimeFormat(pattern = "yyyy-MM-dd") // 日期格式
  private Date startDate;
  @DateTimeFormat(pattern = "yyyy-MM-dd") // 日期格式
  private Date endDate;
  private String comboName;
  private Integer comboPrice;
  
}
