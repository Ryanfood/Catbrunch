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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/member_backend.css">
    <!-- animate.style -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- SimplePagination -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.min.js"></script>
    <!-- js -->
    <script src="/js/script.js"></script>
    <script src="/js/member_backend.js"></script>
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
                                    <a class="nav-link" id="nav-link" href="/news_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">活動</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/order_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">訂餐</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-link" href="/member_backend">
                                    <img class="me-2" src="/img/paw-print.png" alt="">會員</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link logout" href="javascript:void(0);" id="nav-link" type="button">
                                    <img class="me-2" src="/img/paw-print.png" alt="">登出</a>
                                </li>
                            </ul>

                        </nav>

                    </div>
                </nav>

            </div>
        </div>
    </header>

    <!-- section1 區域 會員資料 -->
    <section id="sec1">
        <div class="container-xl">

            <div class="row">
                <h2 class="mb-4">會員內容</h2>
                <div class="form-group me-auto mb-3">
                    <input type="text" id="searchInput" class="form-control" placeholder="搜尋...">
                </div>
                <div id="list-wrapper" class="table-responsive">
                    <table id="memberTable" class="table table-striped table-hover table-bordered text-center">
                        <thead>
                            <tr class="member-row">
                                <th>編號 <img src="/img/icons/down.svg" alt=""></th>
                                <th>帳號 <img src="/img/icons/down.svg" alt=""></th>
                                <th class="d-none">密碼 <img src="/img/icons/down.svg" alt=""></th>
                                <th class="name-cell">姓名 <img src="/img/icons/down.svg" alt=""></th>
                                <th>性別 <img src="/img/icons/down.svg" alt=""></th>
                                <th>生日 <img src="/img/icons/down.svg" alt=""></th>
                                <th class="email-cell">信箱 <img src="/img/icons/down.svg" alt=""></th>
                                <th class="phone-cell">手機號碼 <img src="/img/icons/down.svg" alt=""></th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 迴圈開始 -->
                            <c:forEach items="${ memberList }" var="member">
                                <tr class="list-item">
                                    <td>${ member.memberId }</td>
                                    <td>${ member.account }</td>
                                    <td class="ellipsis d-none" data-bs-toggle="tooltip" data-bs-placement="top" title="example_password">${ member.password }</td>
                                    <td>${ member.name }</td>
                                    <td>${ member.gender }</td>
                                    <td>
                                        <fmt:formatDate value="${ member.birthday }" pattern="yyyy-MM-dd" />
									</td>
                                    <td>${ member.email }</td>
                                    <td>${ member.phone }</td>
                                    <td>
                                        <form action="${ pageContext.request.contextPath }/member_backend/${ member.memberId }" id="delete-form" method="POST">
                                            <a href="${ pageContext.request.contextPath }/member_backend/${ member.memberId }" class="btn btn-outline-success"
                                                data-bs-toggle="modal" data-bs-target="#updateForm" data-bs-whatever="@mdo">修改</a>
                                            <!-- HttpMethod 隱藏欄位 -->
                                            <input name="_method" type="hidden" value="delete" />
                                            <input type="hidden" name="memberId" value="${ member.memberId }" />
                                            <button type="button" class="btn btn-outline-danger deleteButton" id="deleteButton">刪除</button>
										</form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!-- 迴圈結束 -->
                        </tbody>
                    </table>
                    
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


	<!-- 圖表區 -->
	<section id="sec2">
        <div class="container-xl">
            <div class="row">
				<%@ include file="member_charts.jspf" %>
            </div>
        </div>
    </section>
	

    <!-- 修改表單 -->
    <div class="modal fade" id="updateForm" tabindex="-1" data-bs-backdrop="static" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="exampleModalLabel"><i class="fa fa-paw"></i> 修改會員資料</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="updateMemberForm" method="POST" enctype="multipart/form-data">
                        <!-- HttpMethod 隱藏欄位 -->
                        <input type="hidden" class="form-control" id="memberId" name="memberId">
                        <input name="_method" type="hidden" value="PUT" />
                        <fieldset>
                            <!-- 帳號 -->
                            <div class="form-group mb-2">
                                <label for="updateAccount" class="col-form-label"><i class="fa fa-user"></i> 帳&#12288;&#12288;號：</label>
                                <input type="text" class="form-control" id="updateAccount" name="account" readonly>
                            </div>
							<!-- 密碼 -->
							<div class="form-group mb-2">
							    <label for="updatePassword" class="col-form-label"><i class="fa fa-lock"></i> 密&#12288;&#12288;碼：</label>
							    <div class="password-eye">
							        <input type="password" class="form-control" id="updatePassword" name="password"
							        pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$" required />
							        <div class="password-eye-append">
							            <span class="passwordToggle" id="passwordToggle1">
							                <i class="fa fa-eye d-none"></i>
							                <i class="fa fa-eye-slash"></i>
							            </span>
							        </div>
							    </div>
							</div>
							<!-- 密碼確認 -->
							<div class="form-group mb-2">
							    <label for="updatePassword2" class="col-form-label"><i class="fa fa-lock"></i> 密碼確認：</label>
							    <div class="password-eye">
							        <input type="password" class="form-control" id="updatePassword2" name="password2"
							        pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$" required />
							        <div class="password-eye-append">
							            <span class="passwordToggle" id="passwordToggle2">
							                <i class="fa fa-eye d-none"></i>
							                <i class="fa fa-eye-slash"></i>
							            </span>
							        </div>
							    </div>
							</div>
                            <!-- 姓名 -->
                            <div class="form-group mb-2">
                                <label for="updateName" class="col-form-label"><i class="fa fa-user-plus"></i> 姓&#12288;&nbsp; 名：</label>
                                <input type="text" class="form-control" id="updateName" name="name" required>
                            </div>
                            <!-- 性別 -->
                            <div class="mb-0">
                                <label for="updateGender" class="col-form-label"><i class="fa fa-venus-mars"></i> 性&#12288;&nbsp; 別：</label>
                                <input class="form-check-input mt-3" type="radio" id="genderMale" name="gender" value="男生" checked>
                                <label class="form-check-label" for="genderMale"><i class="fa fa-mars"></i>男生</label>
                                <input class="form-check-input mt-3" type="radio" id="genderFemale" name="gender" value="女生">
                                <label class="form-check-label" for="genderFemale"><i class="fa fa-venus"></i>女生</label>
                            </div>
                            <!-- 生日 -->
                            <div class="form-group mb-2">
                                <label for="updateBrithday" class="col-form-label"><i class="fa fa-calendar"></i> 生&#12288;&#12288;日：</label>
                                <input type="date" class="form-control" id="updateBirthday" name="birthday" required>
                            </div>
                            <!-- 電子郵件 -->
                            <div class="form-group mb-2">
                                <label for="updateEmail" class="col-form-label"><i class="fa fa-envelope"></i> 電子郵件：</label>
                                <input type="email" class="form-control" id="updateEmail" name="email" required pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"/>
                            </div>
                            <!-- 手機號碼 -->
                            <div class="form-group mb-3">
                                <label for="updatePhone" class="col-form-label"><i class="fa fa-phone"></i> 手機號碼：</label>
                                <input type="tel" class="form-control" id="updatePhone" name="phone" required maxlength="10" pattern="09\d{2}\d{6}" oninput="setCustomValidity('');" oninvalid="setCustomValidity('請輸入正確的手機號瑪格式:09xxxxxxxx');"/>
                            </div>

                            <div class="modal-button my-3 text-center">
                                <button type="button" class="btn btn-outline-secondary me-3" data-bs-dismiss="modal">取消</button>
                                <button type="submit" id="updateButton" class="btn btn-outline-primary ms-3" onclick="updateMember(this)">確認</button>
                            </div>
                        </fieldset>
                    </form>
                </div>
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