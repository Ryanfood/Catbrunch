<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, minimum-scale=1.0, maximum-scale=3.0">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/member.css">
    <!-- Font Awesome 的 JS 文件 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
    <!-- animate.style -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
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
                                    <a class="nav-link" id="nav-link" href="/order">
                                    <img class="me-2" src="/img/paw-print.png" alt="">訂餐</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-link" href="/location">
                                    <img class="me-2" src="/img/paw-print.png" alt="">地點</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-link" href="/member">
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
                            <source src="/img/banner/banner-member.mp4" type="video/mp4">
                            您的瀏覽器不支援影片播放功能。
                        </video>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- section2 區域 會員 -->
    <section id="sec2">
        <div class="container-xl">
            <div class="row">
                <div class="col-12 member mb-5">
                   <!-- login -->
					<div class="login mx-auto animate__animated animate__zoomIn">
					    <form id="loginForm">
					        <fieldset>
					            <h2><i class="fa fa-paw"></i> 登 入</h2>
					            <p>還不是會員嗎？<a href="#" id="toRegister">點我加入</a></p>
					            <label for="account">帳 號</label>
					            <div class="input-group mb-3">
					                <div class="input-group-text icon"><i class="fa fa-user"></i></div>
					                <input type="text" class="form-control account" id="loginAccount" name="loginAccount" placeholder="account">
					            </div>
					            <label for="password">密 碼</label>
					            <div class="input-group mb-3">
					                <div class="input-group-text icon"><i class="fa fa-lock"></i></div>
					                <div class="password-eye">
					                    <input type="password" class="form-control password login-password" id="loginPassword" name="loginPassword" placeholder="password">
					                    <div class="password-eye-append">
					                        <span class="passwordToggle" id="passwordToggle">
					                            <i class="fa fa-eye d-none"></i>
					                            <i class="fa fa-eye-slash"></i>
					                        </span>
					                    </div>
					                </div>
					            </div>
					            <!-- 圖片驗證 -->
					            <div class="form-group">
					                <div class="mb-2">
					                    <canvas id="mycanvas" width='150' height='40'></canvas>
					                    <a id="linkbt" class="">看不清換一張</a>
					                </div>
					                <div>
					                    <input id="myvad" class="form-control mb-3" type="text" name="vad" placeholder="請輸入驗證碼">
					                </div>
					            </div>
					            <!-- 圖片驗證 -->
					            <p><a href="#" id="toForget">忘記密碼</a></p>
					            <button type="button" id="loginButton" class="btn btn-primary d-flex mx-auto">會員登入</button>
					        </fieldset>
					    </form>
					</div>
					<!-- login -->
					
					<!-- register -->
					<div class="register mx-auto my-5 d-none animate__animated animate__zoomIn">
					    <form id="createMember" action="${ pageContext.request.contextPath }/member_backend/" method="post" enctype="multipart/form-data">
					        <fieldset>
					            <!-- HttpMethod 隱藏欄位 -->
					            <input name="_method" type="hidden" value="${ _method }" />
					            <h2><i class="fa fa-paw"></i> 加入會員</h2>
					            <p>已經是會員了嗎？<a href="#" id="toLogin">點我登入</a></p>
					            <!-- 帳號 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="account">帳號</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group">
					                        <div class="input-group-text icon"><i class="fa fa-user"></i></div>
					                        <input type="text" class="form-control account" id="account" name="account" placeholder="account" required>
					                    </div>
					                    <div id="accountError" class="invalid-feedback" style="display: none;">此帳號已被註冊。</div>
					                </div>
					            </div>
					            <!-- 密碼 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="password">密碼</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group mb-3">
					                        <div class="input-group-text icon"><i class="fa fa-lock"></i></div>
					                        <div class="password-eye">
					                            <input type="password" class="form-control password registerPassword" id="password" name="password" placeholder="password" pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$" required />
					                            <div class="password-eye-append">
					                                <span class="passwordToggle" id="passwordToggle1">
					                                    <i class="fa fa-eye d-none"></i>
					                                    <i class="fa fa-eye-slash"></i>
					                                </span>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <!-- 密碼確認 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="passwordConfirm">密碼確認</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group mb-3">
					                        <div class="input-group-text icon"><i class="fa fa-lock"></i></div>
					                        <div class="password-eye">
					                            <input type="password" class="form-control password registerPassword2" id="password2" name="password2" placeholder="password" pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$" required />
					                            <div class="password-eye-append">
					                                <span class="passwordToggle" id="passwordToggle2">
					                                    <i class="fa fa-eye d-none"></i>
					                                    <i class="fa fa-eye-slash"></i>
					                                </span>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <!-- 姓名 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="name">姓名</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group mb-3">
					                        <div class="input-group-text icon"><i class="fa fa-user-plus"></i></div>
					                        <input type="text" class="form-control name" id="name" name="name" placeholder="name" required>
					                    </div>
					                </div>
					            </div>
					            <!-- 性別 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="gender">性別</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="mb-3">
					                        <input class="form-check-input" type="radio" name="gender" id="genderMale" value="男生" checked>
					                        <label class="form-check-label" for="genderMale"><i class="fa fa-mars"></i>男生</label>
					                        <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="女生">
					                        <label class="form-check-label" for="genderFemale"><i class="fa fa-venus"></i>女生</label>
					                    </div>
					                </div>
					            </div>
					            <!-- 生日 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="birthday">生日</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group mb-3">
					                        <div class="input-group-text icon"><i class="fa fa-calendar"></i></div>
					                        <input type="date" class="form-control" id="birthday" name="birthday" required>
					                    </div>
					                </div>
					            </div>
					            <!-- 電子郵件 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="email">電子郵件</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group">
					                        <div class="input-group-text icon"><i class="fa fa-envelope"></i></div>
					                        <input type="email" class="form-control" id="email" name="email" placeholder="email@example.com" required pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"/>
					                    </div>
					                    <div id="emailError" class="invalid-feedback" style="display: none;">此Email已被使用。</div>
					                </div>
					            </div>
					            <!-- 手機號碼 -->
					            <div class="row">
					                <div class="col-12 col-sm-4">
					                    <label for="phone">手機號碼</label>
					                </div>
					                <div class="col-12 col-sm-8">
					                    <div class="input-group">
					                        <div class="input-group-text icon"><i class="fa fa-phone"></i></div>
					                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="phone number" required maxlength="10" pattern="09\d{2}\d{6}" oninput="setCustomValidity('');" oninvalid="setCustomValidity('請輸入正確的手機號碼格式:09xxxxxxxx');"/>
					                    </div>
					                    <div id="phoneError" class="invalid-feedback" style="display: none;">此手機號碼已被使用。</div>
					                </div>
					            </div>
					            <button type="submit" id="registerButton" class="btn btn-primary d-flex mx-auto">加入會員</button>
					        </fieldset>
					    </form>
					</div>
					<!-- register -->
					
					<!-- forget -->
					<div class="forget mx-auto d-none animate__animated animate__zoomIn">
					    <form id="forgetForm">
						    <fieldset>
						        <h2><i class="fa fa-paw"></i> 忘記密碼</h2>
						        <p>想到密碼了？<a href="#" id="toLoginFromForget">回登入頁面</a></p>
						        <label for="account">請輸入Email</label>
						        <div class="input-group mb-3">
						            <div class="input-group-text icon"><i class="fa fa-envelope"></i></div>
						            <input type="email" class="form-control" id="forgetEmail" name="forgetEmail" placeholder="email@example.com" required pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"/>
						        </div>
						        <div id="changeMailError" class="invalid-feedback" style="display: none;">沒有此Email。</div>
						        <button type="button" id="forgetButton" class="btn btn-primary d-flex mx-auto mb-3">傳送驗證碼</button>
						        <button type="button" id="changeButton" class="btn btn-primary d-flex mx-auto" data-bs-toggle="modal" data-bs-target="#changePasswordModal">變更密碼</button>
		            
						    </fieldset>
						</form>
					</div>
					<!-- forget -->
					
					<!-- Modal -->
					<div class="modal fade" id="changePassword" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h3 class="modal-title" id="staticBackdropLabel"><i class="fa fa-paw"></i> 變更密碼</h3>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body">
					                <form id="updateMemberForm" method="PUT" enctype="multipart/form-data">
    <!-- HttpMethod 隱藏欄位 -->
    <input type="hidden" class="form-control" id="memberId" name="memberId">
    <input name="_method" type="hidden" value="PUT" />
    <fieldset>
        <!-- 電子郵件 -->
        <label for="email" class="form-label">電子郵件</label>
        <div class="input-group mb-3">
            <div class="input-group-text icon"><i class="fa fa-envelope"></i></div>
            <input type="email" class="form-control" id="updateEmail" name="updateEmail" required pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" readonly />
        </div>
        <div id="emailError" class="invalid-feedback" style="display: none;">此Email已被使用。</div>

        <!-- 驗證碼 -->
        <label for="verificationCode" class="form-label">輸入驗證碼</label>
        <div class="input-group mb-2">
            <div class="input-group-text icon"><i class="fa fa-key"></i></div>
            <input type="text" class="form-control" id="verificationCode" name="verificationCode" placeholder="Verification Code" maxlength="6" required oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 6);" />
        </div>

        <!-- 新密碼 -->
        <div id="passwordFields" style="display: none;">
            <label for="updatePassword">輸入新密碼</label>
            <div class="input-group mb-3">
                <div class="input-group-text icon"><i class="fa fa-lock"></i></div>
                <div class="password-eye">
                    <input type="password" class="form-control newPassword" id="newPassword" name="newPassword" placeholder="New Password" pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$" required>
                    <div class="password-eye-append">
                        <span class="passwordToggle" id="passwordToggle">
                            <i class="fa fa-eye d-none"></i>
                            <i class="fa fa-eye-slash"></i>
                        </span>
                    </div>
                </div>
            </div>

            <!-- 確認新密碼 -->
            <label for="password2">確認新密碼</label>
            <div class="input-group mb-3">
                <div class="input-group-text icon"><i class="fa fa-lock"></i></div>
                <div class="password-eye">
                    <input type="password" class="form-control newPassword2" id="newPassword2" name="newPassword2" placeholder="Confirm New Password" pattern="^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$" required>
                    <div class="password-eye-append">
                        <span class="passwordToggle" id="passwordToggle2">
                            <i class="fa fa-eye d-none"></i>
                            <i class="fa fa-eye-slash"></i>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-button my-3 text-center">
            <button type="button" class="btn btn-outline-secondary me-3" data-bs-dismiss="modal">取消</button>
            <button type="button" class="btn btn-outline-primary me-3" id="verifyCodeButton">驗證</button>
            <button type="button" id="updateButton" class="btn btn-outline-primary ms-3" style="display: none;">修改密碼</button>
        </div>
    </fieldset>
</form>
					            </div>
					        </div>
					    </div>
					</div>
					<!-- Modal -->

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
                    <h3 class="title active">會員</h3>
                    <a href="/member" class="active">Member</a>
                </div>

                <div class="col-12 d-flex align-items-center">
                    <img src="/img/Logo/Logo.gif" class="img-fluid me-3" alt="...">
                    <p class="mb-0">Copyright &copy; 2024. All rights reserved. Designed by Ryan</p>
                </div>
            </div>
        </div>

    </footer>
    
    
    

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- js -->
    <script src="/js/member.js"></script>
    <!-- bootstrap5 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- sweetalert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.all.min.js"></script>
</body>

</html>