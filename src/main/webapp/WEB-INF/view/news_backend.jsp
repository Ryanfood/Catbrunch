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
    <link rel="stylesheet" href="/css/news_backend.css">
    <!-- animate.style -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- SimplePagination -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.min.js"></script>
    <!-- js -->
    <script src="/js/script.js"></script>
    <script src="/js/news_backend.js"></script>
    <!-- sweetalert2 -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.min.css" rel="stylesheet">
    <!-- 設定網頁 icon -->
    <link rel="icon" href="./img/Logo/Logo.png" type="image/">

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
                            <h1 class="m-0 ms-3" id="h1">貓貓後臺</h1>
                        </a>
                        
                        <p class="hello"></p>
                        

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarMenu" aria-controls="navbarMenu"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <nav class="collapse navbar-collapse" id="navbarMenu">

                            <ul class="navbar-nav ms-auto mb-2 mb-md-0 ps-2 ps-md-0">
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/menu_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">菜單</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-link"
                                        href="/news_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">活動</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/order_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">訂餐</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/member_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">會員</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link logout" id="nav-link" type="button">
                                    <img class="me-2" src="/img/paw-print.png" alt="">登出</a>
                                </li>
                            </ul>

                        </nav>

                    </div>
                </nav>

            </div>
        </div>
    </header>


    <!-- section1 區域 新增活動 -->
    <section id="sec1">
        <div class="container-ml my-3">
            <div class="col-12 col-md-6 mx-auto px-3">
                <form id="addNewsForm"
                    action="${ pageContext.request.contextPath }/news_backend/${ news.newsId }"
                    method="post" enctype="multipart/form-data">
                    <fieldset>
                        <h2 class="text-center mb-2">${ _method eq 'PUT' ? '修改活動' : '新增活動' }
                        </h2>
                        <!-- HttpMethod 隱藏欄位 -->
                        <input name="_method" type="hidden" value="${ _method }" />
                        <div class="form-group">
                            <label for="newsname">活動名稱：</label>
                            <input type="text" id="newsTitle" name="newsTitle" class="form-control" value="${ news.newsTitle }" required>
                        </div>
                        <div class="form-group">
                            <label for="description">活動介紹：</label>
                            <textarea id="conntent" name="content" rows="3" class="form-control" required>${ news.content }</textarea>
                        </div>
                        <div class="form-group">
                            <label for="start_date">活動開始日期：</label>
                            <input type="date"	id="start_date" name="startDate" class="form-control" value="<fmt:formatDate value="${ news.startDate }" pattern="yyyy-MM-dd" />" required>
                        </div>
                        <div class="form-group">
                            <label for="end_date">活動截止日期：</label>
                            <input type="date" id="end_date" name="endDate" class="form-control" value="<fmt:formatDate value="${ news.endDate }" pattern="yyyy-MM-dd" />" required>
                        </div>
                        <div class="form-group">
                            <label for="combo_name">套餐名稱：</label>
                            <input id="combo_name" name="comboName" class="form-control" value="${ news.comboName }" required>
                        </div>
                        <div class="form-group">
                            <label for="combo_price">套餐價格：</label>
                            <input type="number" id="combo_price" name="comboPrice" min="0" max="5000" step="1" class="form-control" value="${ news.comboPrice }" required>
                        </div>
                        <div class="form-group">
                            <div class="image-preview card-img-top img-fluid" id="imagePreview">
                                <label for="image">圖片上傳：</label>
                                <img id="previewImg" src="${ imgurl }/${ news.newsImage }" class="card-img-top img-fluid" alt="...">
                                <input type="file" id="newsimage" name="file" class="form-control-file" accept="image/*,.jpg,.jpeg,.png,.gif" value="${ news.newsImage }" required>
                            </div>
                        </div>
                        <button type="submit" class="btn mt-3" data-action="${ _method eq 'PUT' ? 'update' : 'create' }">
                        	${ _method eq 'PUT' ? '修改活動' : '新增活動' }
                        </button>
                    </fieldset>
                </form>
            </div>
        </div>
    </section>



    <!-- section3 區域 News活動 -->
    <section id="sec3">

        <div class="container-xl mb-5">
            <div class="mx-3 px-4 newsbg">
                <h2 class="newstitle text-center">最新活動 News</h2>
                <div class="news row" id="list-wrapper">

                    <c:forEach items="${ newsList }" var="news">

                        <div class="col-12 col-md-6 col-lg-4 my-3 list-item">
                            <div class="card p-3 text-center h-100">
                                <img src="/img/news/${ news.newsImage }" class="card-img-top">
                                <div class="card-body p-2">
                                    <h2 class="card-title">${ news.newsTitle }</h2>
                                    <p class="card-text">${ news.content }</p>
                                    <p class="card-text">
                                        <small class="text-muted">開始日期： <fmt:formatDate value="${ news.startDate }" pattern="yyyy-MM-dd" /> </small>
                                    </p>
                                    <p class="card-text">
                                        <small class="text-muted">結束日期： <fmt:formatDate value="${ news.endDate }" pattern="yyyy-MM-dd" /> </small>
                                    </p>
                                    <p class="card-text">
                                        <small class="text-muted">套餐名稱：${ news.comboName }</small>
                                    </p>
                                    <p class="card-text">
                                        <small class="text-muted">套餐價格：${ news.comboPrice }元</small>
                                    </p>
                                </div>
                                <div class="pb-3 d-flex mx-auto">
                                    <form action="${ pageContext.request.contextPath }/news_backend/${ news.newsId }" id="delete-form" method="POST">
                                        <a href="${ pageContext.request.contextPath }/news_backend/${ news.newsId }" class="btn btn-outline-success me-1">修改</a>
                                        <!-- HttpMethod 隱藏欄位 -->
                                        <input name="_method" type="hidden" value="delete" />
                                        <input type="hidden" name="newsId" value="${ news.newsId }" />
                                        <button type="button" class="btn btn-outline-danger deleteButton ms-1" id="deleteButton">刪除</button>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </c:forEach>

                </div>
            </div>
        </div>

    </section>


    <!-- 分頁 pagination-container -->
    <div class="container-xl pagination my-3">
        <div class="row">
            <div id="pagination-container"></div>
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

    <!-- bootstrap5 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- sweetalert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.all.min.js"></script>
</body>

</html>