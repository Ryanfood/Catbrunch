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
    <link rel="stylesheet" href="/css/menu.css">
    <!-- animate.style -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- SimplePagination -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.min.js"></script>
    <!-- js -->
    <script src="/js/menu.js"></script>
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

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarMenu" aria-controls="navbarMenu"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <nav class="collapse navbar-collapse" id="navbarMenu">

                            <ul class="navbar-nav ms-auto mb-2 mb-md-0 ps-2 ps-md-0">
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-link" href="/menu">
                                    <img class="me-2" src="/img/paw-print.png" alt="">菜單</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/news">
                                    <img class="me-2" src="/img/paw-print.png" alt="">活動</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/order">
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
        <div class="container-xl">
            <div class="row">
                <div class="col-12 text-center">
                    <div class="embed-responsive embed-responsive-16by9">
                        <video autoplay controls="false" height="500"
                            class="embed-responsive-item">
                            <source src="/img/banner/banner-menu.mp4" type="video/mp4">
                            您的瀏覽器不支援影片播放功能。
                        </video>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- section2 區域 Menu -->
    <section id="sec2">
        <div class="container-xl my-3">
            <div class="row">
                <!-- 餐點總類 -->
                <div class="col-12 col-md-3">
                    <div class="card menu-card my-3">
                        <div class="card-body">
                            <h2 class="card-title text-center"><img src="/img/icons/meal.png" alt=""> 餐點種類</h2>
                            <div class="list-group">

                                <a id="appetizer" type="button" href="/menu/mealType/appetizer#sec2" 
                                    class="list-group-item list-group-item-warning ${ active eq 'appetizer' ? 'active' : '' }" data-category="appetizer">
                                    <img src="/img/icons/appetizer.png" alt=""> 前 菜
                                </a>
                                <a id="soup" type="button" href="/menu/mealType/soup#sec2" 
                                    class="list-group-item list-group-item-warning ${ active eq 'soup' ? 'active' : '' }" data-category="soup">
                                    <img src="/img/icons/soup.png" alt=""> 湯 品
                                </a>
                                <a id="mainCourse" type="button" href="/menu/mealType/mainCourse#sec2"
                                    class="list-group-item list-group-item-warning ${ active eq 'mainCourse' ? 'active' : '' }" data-category="mainCourse">
                                    <img src="/img/icons/mainCourse.png" alt=""> 主 餐
                                </a>
                                <a id="dessert" type="button" href="/menu/mealType/dessert#sec2"
                                    class="list-group-item list-group-item-warning ${ active eq 'dessert' ? 'active' : '' }" data-category="dessert">
                                    <img src="/img/icons/dessert.png" alt=""> 甜 點
                                </a>
                                <a id="drinks" type="button" href="/menu/mealType/drinks#sec2"
                                    class="list-group-item list-group-item-warning ${ active eq 'drinks' ? 'active' : '' }" data-category="drinks">
                                    <img src="/img/icons/drinks.png" alt=""> 飲 料
                                </a>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- 餐點內容 -->
                <div class="col-12 col-md-9">
                    <!-- 餐點內容顯示 -->
                    <div id="mealType" class="content">

                        <div id="list-wrapper">
                            <div class="appetizer row">
                                <!-- 回圈開始 -->
                                <c:forEach items="${ menuList }" var="menu">

                                    <div class="col-12 col-md-6 col-lg-4 list-item my-3 animate__animated animate__zoomIn">
                                        <div class="card meal-card p-2 text-center h-100 mx-sm-auto">
                                            <img src="/img/menu/${ menu.mealType }/${ menu.mealImage }" class="card-img-top img-fluid p-2 w-100 h-100" alt="${ menu.mealName }">
                                            <div class="card-body p-1 d-flex flex-column h-100">
                                                <h2 class="card-title">${ menu.mealName }</h2>
                                                <p class="card-text flex-grow-1">${
                                                    menu.description }</p>
                                            </div>
                                            <div class="p-2 d-flex justify-content-evenly">
                                                <p class="">原&#12288;價：NT$${ menu.mealPrice }元
                                                </p>
                                                <p class="">會員價：NT$${
                                                    Math.round(menu.mealPrice*0.9) }元</p>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>
                                <!-- 回圈結束 -->
                            </div>
                        </div>

                    </div>
                    <!-- 餐點內容顯示結束 -->

                    <!-- 分頁 pagination-container -->
                    <div class="container-xl pagination my-3">
                        <div class="row">
                            <div id="pagination-container"></div>
                        </div>
                    </div>
                    <!-- 分頁 pagination-container -->
                </div>

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
                    <h3 class="title active">菜單</h3>
                    <a href="/menu" class="active">Menu</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">活動</h3>
                    <a href="/news">News</a>
                </div>
                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title">訂餐</h3>
                    <a href="/order">Order</a>
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
                    <p class="mb-0">Copyright &copy; 2024. All rights reserved. Designed by Ryan
                    </p>
                </div>
            </div>
        </div>

    </footer>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>