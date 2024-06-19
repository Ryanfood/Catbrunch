package com.example.demo.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.model.po.News;
import com.example.demo.service.NewsService;

@Controller
public class PathController {
	
	@Autowired
    private NewsService newsService;

	@GetMapping("/index")
	public String indexPage(Model model) {
		List<News> newsList = newsService.getAllNews();
        newsList = newsList.stream().limit(3).collect(Collectors.toList());
        model.addAttribute("newsList", newsList);
		return "index";
	}
	
	@GetMapping("/")
	public String index(Model model) {
		List<News> newsList = newsService.getAllNews();
        newsList = newsList.stream().limit(6).collect(Collectors.toList());
        model.addAttribute("newsList", newsList);
		return "index";
	}
	
	
	@GetMapping("/location")
	public String locationPage() {
		
		return "location";
	}
		
	
	@GetMapping("/member")
	public String memberPage() {
		
		return "member";
	}
	
	
}
