package com.example.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.example.demo.model.po.News;
import com.example.demo.service.NewsService;

import org.springframework.web.multipart.MultipartFile;


@Controller
public class NewsController {

    @Autowired
    private NewsService newsService;

    // 將資料傳到 news
    @GetMapping("/news")
    public String getAllNews(Model model) {
        List<News> newsList = newsService.getAllNews();
        model.addAttribute("newsList", newsList);
        return "news";
    }
    
    // 將資料傳到 news_backend
    @GetMapping("/news_backend")
	public String news_backendPage(Model model) {
		List<News> newsList = newsService.getAllNews();
        model.addAttribute("newsList", newsList);
		return "news_backend";
	}

    // 按下修改按鈕，根據 newsId 將資料傳到修改表單
    @GetMapping("/news_backend/{newsId}")
    public String getNews(@PathVariable("newsId") Integer newsId, Model model) {
    	// 顯示所有 news
    	List<News> newsList = newsService.getAllNews();
    	model.addAttribute("newsList", newsList);
    	
    	// 根據 newsId 將資料傳到修改表單
        News news = newsService.getNewsById(newsId);
        model.addAttribute("news", news);
        
        // 表單 submit 時可以被處理為 PUT 請求
        model.addAttribute("_method", "PUT");
        return "news_backend";
    }
      
    // 新增 news
    @PostMapping("/news_backend/")
    public String createNews(@RequestParam("file") MultipartFile newsImage,
    						 @Validated News news, 
    						 Model model) {
        
        if (!newsImage.isEmpty()) {
            // 將圖片存到對應路徑
            File file = new File("src/main/resources/static/img/news", newsImage.getOriginalFilename());
            try (FileOutputStream out = new FileOutputStream(file)){
                out.write(newsImage.getBytes());
                Thread.sleep(1000); 
            } catch (Exception e) {
                e.printStackTrace();
            }
            news.setNewsImage(newsImage.getOriginalFilename());
        }


        
        // 調用服務方法新增 News
        newsService.createNews(news);
        List<News> newsList = newsService.getAllNews();
        model.addAttribute("news", null);
        model.addAttribute("newsList", newsList);
        model.addAttribute("imgurl", "img/news");
        
        System.out.println("新增成功，ID為：" + news.getNewsId());
        model.addAttribute("_method", "PUT");
        return "news_backend";
    }
       

    // 修改 news
    @PutMapping("/news_backend/{newsId}")
    public String updateNews(@PathVariable("newsId") Integer newsId, 
    						 @RequestParam("file") MultipartFile newsImage, 
    						 @Validated News news, 
    						 Model model) {
    	
    	// 將圖片存到對應路徑
    	File file = new File("src/main/resources/static/img/news", newsImage.getOriginalFilename());
    	try (FileOutputStream out = new FileOutputStream(file)){
			out.write(newsImage.getBytes());
			Thread.sleep(1000);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	news.setNewsImage(newsImage.getOriginalFilename());
    	

        
        // 調用服務方法更新 News
        newsService.updateNews(newsId, news);
        List<News> newsList = newsService.getAllNews();
        model.addAttribute("news", null);
        model.addAttribute("newsList", newsList);
        
        System.out.println("修改成功，ID為：" + newsId);
        model.addAttribute("_method", "PUT");
        return "news_backend";
    }    
    
    // 刪除 news
    @DeleteMapping("/news_backend/{newsId}")
	public String deleteNews(@PathVariable("newsId") Integer newsId, Model model) throws InterruptedException {
		System.out.println("刪除成功，ID為：" + newsId);
		newsService.deleteNews(newsId);
		List<News> newsList = newsService.getAllNews();
		model.addAttribute("newsList", newsList);
		Thread.sleep(1300);
		return "news_backend";
	}
	

}
