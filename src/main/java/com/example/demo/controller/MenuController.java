package com.example.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.po.Menu;
import com.example.demo.service.MenuService;

@Controller
public class MenuController {

	@Autowired
	private MenuService menuService;

	// 將資料傳到 menu
	@GetMapping("/menu")
	public String getAllMenu(Model model) {
		// List<Menu> menuList = menuService.getAllMenu();
		List<Menu> menuList = menuService.getAllMenu().stream()
				.filter(menu -> menu.getMealType().equals("appetizer"))
				.toList();
		
		model.addAttribute("menuList", menuList);
		return "menu";
	}

	// 將資料傳到 order
	@GetMapping("/order")
	public String getAllOrder(Model model) {
		// List<Menu> menuList = menuService.getAllMenu();
		List<Menu> menuList = menuService.getAllMenu().stream()
				.filter(menu -> menu.getMealType().equals("appetizer"))
				.toList();
		
		model.addAttribute("menuList", menuList);
		return "order";
	}

	// 將資料傳到 menu_backend
	@GetMapping("/menu_backend")
	public String menu_backendPage(Model model) {
		// List<Menu> menuList = menuService.getAllMenu();
		List<Menu> menuList = menuService.getAllMenu().stream()
				.filter(menu -> menu.getMealType().equals("appetizer"))
				.toList();
		
		model.addAttribute("menuList", menuList);
		return "menu_backend";
	}

	// 依照不同 mealType 將資料傳到 menu
	@GetMapping("/menu/mealType/{mealType}")
	public String menuType(Model model, @PathVariable("mealType") String mealType) {
		List<Menu> menuList = menuService.getAllMenu().stream()
				.filter(menu -> menu.getMealType().equals(mealType))
				.toList();
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("active", mealType);
		return "menu";
	}

	// 依照不同 mealType 將資料傳到 order
	@GetMapping("/order/mealType/{mealType}")
	public String orderType(Model model, @PathVariable("mealType") String mealType) {
		List<Menu> menuList = menuService.getAllMenu().stream()
				.filter(menu -> menu.getMealType().equals(mealType))
				.toList();
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("active", mealType);
		return "order";
	}

	// 依照不同 mealType 將資料傳到 menu_backend
	@GetMapping("/menu_backend/mealType/{mealType}")
	public String menu_backendType(Model model, @PathVariable("mealType") String mealType) {
		List<Menu> menuList = menuService.getAllMenu().stream()
				.filter(menu -> menu.getMealType().equals(mealType))
				.toList();
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("active", mealType);
		return "menu_backend";
	}

	// 按下修改按鈕，根據 mealId 將資料傳到修改表單
	@GetMapping("/menu_backend/{menuId}")
	public String getMenu(@PathVariable("menuId") Integer menuId, Model model) {
		// 顯示所有 menu
		List<Menu> menuList = menuService.getAllMenu();
		model.addAttribute("menuList", menuList);

		// 根據 menuId 將資料傳到修改表單
		Menu menu = menuService.getMenuById(menuId);
		model.addAttribute("menu", menu);

		// 表單 submit 時可以被處理為 PUT 請求
		model.addAttribute("_method", "PUT");
		return "menu_backend";
	}

	// 新增 menu
	@PostMapping("/menu_backend/")
	public String createMenu(@RequestParam("file") MultipartFile mealImage,
							 @Validated Menu menu,
							 Model model) {
		
		//menu.setMealImage(mealImage.getOriginalFilename());

		if (!mealImage.isEmpty()) {
			// 將圖片存到對應路徑
			File file = new File("src/main/resources/static/img/menu/" + menu.getMealType(),
					mealImage.getOriginalFilename());
			try (FileOutputStream out = new FileOutputStream(file)) {
				out.write(mealImage.getBytes());
				Thread.sleep(1000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			menu.setMealImage(mealImage.getOriginalFilename());
		}

		// 調用服務方法新增 menu
		menuService.createMenu(menu);
		List<Menu> menuList = menuService.getAllMenu();
		model.addAttribute("menu", null);
		model.addAttribute("menuList", menuList);
		model.addAttribute("mealType", menu.getMealType());

		System.out.println("新增成功，ID為：" + menu.getMenuId());
		model.addAttribute("_method", "PUT");
		return "menu_backend";
	}

	// 修改 menu
	@PutMapping("/menu_backend/{menuId}")
	public String upddateMenu(@PathVariable("menuId") Integer menuId,
							  @RequestParam("file") MultipartFile mealImage, 
							  @ModelAttribute Menu menu, 
							  Model model) {



		// 將圖片存到對應路徑
		File file = new File("src/main/resources/static/img/menu/" + menu.getMealType(),
				mealImage.getOriginalFilename());
		try (FileOutputStream out = new FileOutputStream(file)) {
			out.write(mealImage.getBytes());
			Thread.sleep(1000);
		} catch (Exception e) {
			e.printStackTrace();
		}
		menu.setMealImage(mealImage.getOriginalFilename());

		// 調用服務方法更新 Menu
		menuService.updateMenu(menuId, menu);
		List<Menu> menuList = menuService.getAllMenu();
		model.addAttribute("menu", menu);
		model.addAttribute("menuList", menuList);
		model.addAttribute("mealType", menu.getMealType());

		System.out.println("修改成功，ID為：" + menuId);
		model.addAttribute("_method", "PUT");
		return "menu_backend";
	}

	// 刪除 menu
	@DeleteMapping("/menu_backend/{menuId}")
	public String deleteMenu(@PathVariable("menuId") Integer menuId, Model model) throws InterruptedException {
		System.out.println("刪除成功，ID為：" + menuId);
		// menuService.deleteMenu(menuId);
		List<Menu> menuList = menuService.getAllMenu();
		model.addAttribute("menuList", menuList);
		Thread.sleep(1300);
		return "menu_backend";
	}

}
