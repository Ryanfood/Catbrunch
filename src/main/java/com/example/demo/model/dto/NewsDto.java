package com.example.demo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.example.demo.model.po.News;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NewsDto {
    private Integer newsId;
    private String newsTitle;
    private String content;
    private String newsImage;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
    private String comboName;
    private Integer comboPrice;
    
    private News news;
}
