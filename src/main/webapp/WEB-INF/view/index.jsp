<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, minimum-scale=1.0, maximum-scale=3.0">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
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
                            data-bs-target="#navbarMenu" aria-controls="navbarMenu" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <nav class="collapse navbar-collapse" id="navbarMenu">

                            <ul class="navbar-nav ms-auto mb-2 mb-md-0 ps-2 ps-md-0">
                                <li class="nav-item ">
                                    <a class="nav-link" id="nav-link" href="/menu">
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

                <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true"  aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="/img/carousel/carousel1.jpg" class="d-block w-100" alt="">
                        </div>
                        <div class="carousel-item">
                            <img src="/img/carousel/carousel2.jpg" class="d-block w-100" alt="">
                        </div>
                        <div class="carousel-item">
                            <img src="/img/carousel/carousel3.jpg" class="d-block w-100" alt="">
                        </div>
                        <div class="carousel-item">
                            <img src="/img/carousel/carousel4.jpg" class="d-block w-100" alt="">
                        </div>
                        <div class="carousel-item">
                            <img src="/img/carousel/carousel5.jpg" class="d-block w-100" alt="">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button"
                        data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button"
                        data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>

            </div>
        </div>
    </section>

    <!-- section2 區域 About Me -->
    <section id="sec2">
        <div class="container-xl mt-5 mb-4">
            <div class="row">
                <div class="col-12 cardbox">
                    <div class="card bg-none mx-auto about aboutcard">
                        <img src="img/bg/bg2.png" class="card-img">
                        <div class="card-img-overlay">
                            <h2 class="card-title">About Me</h2>
                            <p class="card-text">摸我一下</p>
                        </div>
                    </div>
                    <div class="card bg-none mx-auto about aboutcard2">
                        <img src="img/bg/bg2.png" class="card-img">
                        <div class="card-img-overlay">
                            <h2 class="card-title">About Me</h2>
                            <p class="card-text">
                                因為喜歡貓貓也喜歡到處吃美食，所以把吃東西的興趣加上貓咪的元素來做成一個早午餐的網站，將來有朋友想要開咖啡廳或是早午餐店的話，就會有基本的概念及想法。
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- section3 區域 News活動 -->
    <section id="sec3">

        <div class="container-xl mb-5">
            <div class="row mx-4 newsbg">
                <h2 class="newstitle text-center">最新活動 News</h2>
                <c:forEach items="${newsList}" var="news">

                    <div class="col-12 col-md-6 col-lg-4 my-3">
                        <div class="card p-3 text-center h-100">
                            <img src="/img/news/${news.newsImage}" class="card-img-top">
                            <div class="card-body p-2">
                                <h2 class="card-title">${news.newsTitle}</h2>
                                <p class="card-text">${news.content}</p>
                            </div>
                            <div class="pb-3">
                                <a href="/news" class="btn btn-outline-primary">點我看更多</a>
                            </div>
                        </div>
                    </div>

                </c:forEach>

            </div>
        </div>

    </section>

    <!-- footer 區域 頁尾 -->
    <footer>

        <div class="container-xl text-center">
            <div class="row">

                <div class="col-6 col-md-2 pt-1 d-flex flex-column">
                    <h3 class="title" id="title">首頁</h3>
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