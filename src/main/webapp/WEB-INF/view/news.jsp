<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="/css/news.css">
    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- SimplePagination -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.min.js"></script>
    <!-- js -->
    <script src="/js/news.js"></script>
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
                                    <a class="nav-link" id="nav-link" href="/menu">
                                    <img class="me-2" src="/img/paw-print.png" alt="">菜單</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-link" href="/news">
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
        <div class="container-xl mb-5">
            <div class="row">
                <div class="col-12 text-center">
                    <div class="embed-responsive embed-responsive-16by9">
                        <video autoplay controls="false" height="500" class="embed-responsive-item">
                            <source src="/img/banner/banner-news.mp4" type="video/mp4">
                            您的瀏覽器不支援影片播放功能。
                        </video>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- section2 區域 最新活動 -->
    <section id="sec2">
        <div class="container-xl mb-4">

            <div class="row mx-3 px-4 newsbg" id="list-wrapper">
                <h2 class="newstitle text-center">最新活動 News</h2>

                <c:forEach items="${newsList}" var="news">
                    <div class="card my-4 list-item">
                        <div class="row item">
                            <div class="col-12 col-md-6 d-flex justify-content-center">
                                <img src="/img/news/${news.newsImage}" class="card-img-top img-fluid" alt="...">
                            </div>
                            <div class="col-12 col-md-6 align-content-center">
                                <div class="card-body text-center">
                                    <h2 class="card-title">${news.newsTitle}</h2>
                                    <p class="card-text">${news.content}</p>
                                    <p class="card-text"><small class="text-muted">開始日期： <fmt:formatDate value="${news.startDate}" pattern="yyyy-MM-dd" /> </small></p>
                                    <p class="card-text"><small class="text-muted">結束日期： <fmt:formatDate value="${news.endDate}" pattern="yyyy-MM-dd" /> </small></p>
                                    <p class="card-text"><small class="text-muted">套餐名稱：${news.comboName}</small></p>
                                    <p class="card-text"><small class="text-muted">套餐價格：${news.comboPrice}元</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>

        </div>
    </section>

    <!-- 分頁 pagination-container -->
    <div class="container-xl pagination my-3">
        <div class="row">
            <div id="pagination-container">
            </div>
        </div>
    </div>

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
                    <h3 class="title active">活動</h3>
                    <a href="/news" class="active">News</a>
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
                    <p class="mb-0">Copyright &copy; 2024. All rights reserved. Designed by Ryan</p>
                </div>
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>