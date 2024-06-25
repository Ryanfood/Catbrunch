<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!-- Tomcat 10.x JSTL -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!-- Spring Form 表單標籤 -->
<%@ taglib prefix="sp" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, minimum-scale=1.0, maximum-scale=3.0">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/order.css">
    <!-- animate.style -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- SimplePagination -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.min.js"></script>
    <!-- js -->
    <script src="/js/order.js"></script>
    <!-- sweetalert2 -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.min.css" rel="stylesheet">

    <!-- 設定網頁 icon -->
    <link rel="icon" href="/img/Logo/Logo.png" type="image/">

    <title>貓貓早午餐Cat Brunch</title>
</head>

<body>
    <!-- header 區域 頁首-->
    <header>
        <div class="container-xl">
            <div class="row">

                <nav class="navbar navbar-expand-md navbar-light fixed-top">
                    <div class="container-xxl p-0">

                        <a class="navbar-brand d-flex align-items-center" href="./index">
                            <img src="/img/Logo/Logo.gif" class="Logo" height="90" alt="">
                            <h1 class="m-0 ms-3" id="h1">貓貓早午餐</h1>
                        </a>
                        
                        <p class="hello"></p>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarMenu" aria-controls="navbarMenu" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <nav class="collapse navbar-collapse" id="navbarMenu">

                            <ul class="navbar-nav ms-auto mb-2 mb-md-0 ps-2 ps-md-0">
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/menu">
                                    <img class="me-2" src="/img/paw-print.png" alt="">菜單</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/news">
                                    <img class="me-2" src="/img/paw-print.png" alt="">活動</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-link" href="/order">
                                    <img class="me-2" src="/img/paw-print.png" alt="">訂餐</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/location">
                                    <img class="me-2" src="/img/paw-print.png" alt="">地點</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/member">
                                    <img class="me-2" src="/img/paw-print.png" alt="">會員</a>
                                </li>
                            </ul>

                        </nav>

                    </div>
                </nav>

            </div>
        </div>
    </header>

    <!-- section1 區域 大圖片輪播 -->
    <section id="sec1">
        <div class="container-xl mb-3">
            <div class="row">
                <div class="col-12 text-center">
                    <div class="embed-responsive embed-responsive-16by9">
                        <video autoplay controls="false" height="500" class="embed-responsive-item">
                            <source src="/img/banner/banner-order.mp4" type="video/mp4">
                            您的瀏覽器不支援影片播放功能。
                        </video>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- section2 區域 菜單及購物車 -->
    <section id="sec2">
        <div class="container-xl mb-4">
            <div class="row">
                <h1 class="mb-4">餐點訂購</h1>
                <div class="meal-type d-flex justify-content-between mb-3">
                
                    <a id="appetizer" type="button" href="/order/mealType/appetizer#sec2" data-offset="120" 
                    class="list-group-item list-group-item-warning ${ active eq 'appetizer' ? 'active' : '' }" data-category="appetizer">
                        <img src="/img/icons/appetizer.png" alt=""> 前 菜
                    </a>
                    <a id="soup" type="button" href="/order/mealType/soup#sec2" 
                    class="list-group-item list-group-item-warning ${ active eq 'soup' ? 'active' : '' }" data-category="soup">
                        <img src="/img/icons/soup.png" alt=""> 湯 品
                    </a>
                    <a id="mainCourse" type="button" href="/order/mealType/mainCourse#sec2" 
                    class="list-group-item list-group-item-warning ${ active eq 'mainCourse' ? 'active' : '' }" data-category="mainCourse">
                        <img src="/img/icons/mainCourse.png" alt=""> 主 餐
                    </a>
                    <a id="dessert" type="button" href="/order/mealType/dessert#sec2" 
                    class="list-group-item list-group-item-warning ${ active eq 'dessert' ? 'active' : '' }" data-category="dessert">
                        <img src="/img/icons/dessert.png" alt=""> 甜 點
                    </a>
                    <a id="drinks" type="button" href="/order/mealType/drinks#sec2" 
                    class="list-group-item list-group-item-warning ${ active eq 'drinks' ? 'active' : '' }" data-category="drinks">
                        <img src="/img/icons/drinks.png" alt=""> 飲 料
                    </a>

                </div>
                <div id="meal-container" class="meal-container">
                    <!-- 餐點內容顯示 -->
                    <div id="list-wrapper" class="row mx-2">
                        <!-- 這裡寫迴圈 -->
                        <c:forEach items="${ menuList }" var="menu">
                            
                            <div class="col-12 col-md-6 col-lg-4 list-item my-3 animate__animated animate__zoomIn">
                                <div class="card meal-card p-2 text-center h-100 mx-sm-auto">
                                    <img src="/img/menu/${ menu.mealType }/${ menu.mealImage }" class="card-img-top img-fluid p-2 w-100 h-100" alt="${ menu.mealName }">
                                    <div class="card-body p-1 d-flex flex-column h-100">
                                        <h2 class="card-title">${ menu.mealName }</h2>
                                        <p class="card-text flex-grow-1">${ menu.description }</p>
                                    </div>
                                    <div class="p-2 d-flex justify-content-evenly">
                                        <button class="btn btn-outline-primary add-to-cart" data-name="${ menu.mealName }" data-price="${ menu.mealPrice }">加入購物車(NT$${ menu.mealPrice }元)</button>										
                                    </div>
                                </div>
                            </div>
                        
                        </c:forEach>
                        <!-- 這裡寫迴圈 -->
                        
                        <!-- 分頁 pagination-container -->
                        <div class="container-xl pagination mt-3">
                            <div class="row">
                                <div id="pagination-container"></div>
                            </div>
                        </div>
                    
                    </div>
                    <!-- 餐點內容顯示 -->
                    <div id="meal-type" class="content">

                    </div>
                </div>

                <select class="form-select w-25 me-auto" required>
					<option selected disabled>請選擇桌號</option>
					<option value="1">1號桌</option>
					<option value="2">2號桌</option>
					<option value="3">3號桌</option>
					<option value="4">4號桌</option>
					<option value="5">5號桌</option>
					<option value="6">6號桌</option>
					<option value="7">7號桌</option>
					<option value="8">8號桌</option>
					<option value="9">9號桌</option>
					<option value="10">10號桌</option>
				</select>
                <form id="createOrder" action="${ pageContext.request.contextPath }/order_backend/" method="post" enctype="multipart/form-data">
					<fieldset>
						<!-- HttpMethod 隱藏欄位 -->
						<input name="_method" type="hidden" value="${ _method }" />
		                <table class="table w-100 cart-table">
		                    <thead>
		                        <tr>
		                            <th class="text-center">餐點名稱</th>
		                            <th class="text-center">單價</th>
		                            <th class="text-center">數量</th>
		                            <th class="text-center">金額</th>
		                            <th class="text-center">操作</th>
		                        </tr>
		                    </thead>
		                    <tbody id="cart-items" class="">
		                        <!-- 購物車項目將顯示在這裡 -->
		                        <!-- 購物車項目將顯示在這裡 -->
		                    </tbody>
		                </table>
		                <h2 id="total-amount">總金額：$0</h2>
		                <div class="submitButton">
		                	<button type="button" class="btn btn-outline-success" id="submit-order">送 出 訂 單</button>
		                </div>
	                </fieldset>
                </form>
            </div>
        </div>
    </section>

    <!-- footer 區域 頁尾 -->
    <footer>
        <div class="container-xl text-center">
            <div class="row">
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">首頁</h3>
                    <a href="/index">Home</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">菜單</h3>
                    <a href="/menu">Menu</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">活動</h3>
                    <a href="/news">News</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title active">訂餐</h3>
                    <a href="/order" class="active">Order</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">地點</h3>
                    <a href="/location">Location</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">會員</h3>
                    <a href="/member">Member</a>
                </div>
                <div class="col-12 d-flex align-items-center">
                    <img src="/img/Logo/Logo.gif" class="img-fluid me-3" alt="...">
                    <p class="mb-0">Copyright &copy; 2024. All rights reserved. Designed by Ryan</p>
                </div>
            </div>
        </div>
    </footer>

	<!-- bootstrap5 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- sweetalert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.all.min.js"></script>
</body>

</html>