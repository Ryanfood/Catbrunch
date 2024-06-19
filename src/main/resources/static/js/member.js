$(document).ready(function () {
  // 通用切換顯示/隱藏密碼功能
  $('.passwordToggle').on('click', function() {
    // 獲取當前點擊的密碼輸入框和圖標
    let passwordField = $(this).closest('.password-eye').find('input');
    let iconEye = $(this).find('.fa-eye');
    let iconEyeSlash = $(this).find('.fa-eye-slash');

    // 切換密碼輸入框類型
    if (passwordField.attr('type') === 'password') {
      passwordField.attr('type', 'text');
    } else {
      passwordField.attr('type', 'password');
    }

    // 切換圖標
    iconEye.toggleClass('d-none');
    iconEyeSlash.toggleClass('d-none');
  });

  // login 和 register 對調
  $('#register').on('click', function(e) {
    e.preventDefault();
    $('.login').addClass('d-none');
    $('.register').removeClass('d-none');
  });

  $('#login').on('click', function(e) {
    e.preventDefault();
    $('.register').addClass('d-none');
    $('.login').removeClass('d-none');
  });

  
    // 傳送帳號及密碼
    // 獲取 canvas 元素並設置渲染環境
    var mycanvas = $('#mycanvas')[0];
    var cxt = mycanvas.getContext('2d');

    var sColor = ["#B22222", "#F9F900", "#82D900", "#FFAF60"]; // 干擾點顏色
    var fColor = ["#000079", "#006030", "#820041", "#4B0091"]; // 文字顏色
    var validate = ""; // 驗證碼
    var img = new Image();
    img.src = "https://i.imgur.com/ssTQW1o.jpg";

    // 生成隨機顏色組合序號
    function randColor() {
        return Math.floor(Math.random() * sColor.length);
    }

    // 生成6位隨機數
    function rand() {
        validate = "";
        var str = "123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ123456789";
        var arr = str.split("");
        for (var i = 0; i < 6; i++) {
            validate += arr[Math.floor(Math.random() * 66)];
        }
        return validate;
    }

    // 干擾線的隨機 x 座標值
    function lineX() {
        return Math.floor(Math.random() * 200);
    }

    // 干擾線的隨機 y 座標值
    function lineY() {
        return Math.floor(Math.random() * 60);
    }

    // 更換驗證碼內容
    function clickChange() {
        // 重設 canvas 內容
        mycanvas.width = mycanvas.width;
        mycanvas.height = mycanvas.height;

        // 畫圖
        cxt.drawImage(img, lineX(), lineY(), 200, 60, 0, 0, 200, 60);

        // 生成2條干擾線
        for (var j = 0; j < 2; j++) {
            cxt.beginPath();
            cxt.strokeStyle = sColor[randColor()];
            cxt.moveTo(0, lineY());
            cxt.lineTo(150, lineY());
            cxt.lineWidth = (Math.floor(Math.random() * (20 - 10 + 1)) + 10) / 10;
            cxt.stroke();
            cxt.closePath();
        }

        // 生成並顯示驗證碼文字
        cxt.fillStyle = fColor[randColor()];
        cxt.font = 'bold 25px Verdana';
        cxt.fillText(rand(), 10, 30);
    }

    // 點擊驗證碼圖片更換
    $('#mycanvas').on('click', function(e) {
        e.preventDefault();
        clickChange();
    });
    
    // 點擊文字圖片更換
    $('#linkbt').on('click', function(e) {
        e.preventDefault();
        clickChange();
    });
    

    // 頁面加載完成後初始化驗證碼
    img.onload = function() {
        clickChange();
    };

    // 登入會員按鈕
    $('#loginButton').click(function() {
        // 獲取帳號、密碼和驗證碼
        var account = $('#loginAccount').val();
        var password = $('#loginPassword').val();
        var vad = $('#myvad').val();

        // 構建請求數據
        var requestData = {
            account: account,
            password: password
        };

        // 發送 AJAX 請求
        $.ajax({
            url: 'http://localhost:8080/login',  // 更換為您的後端 API 地址
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function(response) {
                console.log(response);
                if (response.member) {
                    // 帳號密碼驗證成功，再進行驗證碼驗證
                   	/* 如果忽略大小寫
                    if (vad.toUpperCase() === validate.toUpperCase()) {
					*/ 	
					if (vad === validate) {	
                        // 登錄成功處理邏輯
                        Swal.fire({
                            position: "center",
                            icon: "success",
                            iconColor: '#4CAF50',
                            title: "登入成功",
                            showConfirmButton: false,
                            timer: 1000
                        });

                        // 將數據保存到 localStorage
                        localStorage.setItem('memberName', response.member.name);
                        localStorage.setItem('isMember', response.member.isMember);

                        // 判斷是否為管理者 (isMember == 1)
                        if (response.member.isMember == 1) {
                            // 重導到後台 member_backend 頁面
                            setTimeout(function() {
                                window.location.href = 'http://localhost:8080/member_backend';
                            }, 1000); // 1000 毫秒 = 1 秒
                        } else {
                            // 非管理者重導到前端頁面
                            setTimeout(function() {
                                window.location.href = 'http://localhost:8080/index';
                            }, 1000); // 1000 毫秒 = 1 秒
                        }
                    } else {
                        // 驗證碼錯誤
                        Swal.fire({
                            icon: "error",
                            title: "驗證碼錯誤"
                        });
                    }
                } else {
                    // 帳號或密碼錯誤
                    Swal.fire({
                        icon: "error",
                        title: "帳號或密碼錯誤"
                    });
                }
            },
            error: function(xhr, status, error) {
                // 登錄失敗處理邏輯
                console.error('登入失敗:', error);
                Swal.fire({
                    icon: "error",
                    title: "伺服器錯誤"
                });
            }
        });
    });
    
    
    
    // 密碼驗證規則
	function validatePattern(password) {
	    var pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/;
	    return pattern.test(password);
	}
	
	// 驗證表單密碼
	$('#password, #password2').on('input', function() {
	    var password1 = $('#password').val();
	    var password2 = $('#password2').val();
	
	    // 檢查第一個密碼是否符合 pattern
	    if (!validatePattern(password1)) {
	        $('#password')[0].setCustomValidity('密碼必須至少包含一個字母、一個數字，且至少6個字符');
	    } else {
	        $('#password')[0].setCustomValidity('');
	    }
	
	    // 檢查兩個密碼是否一致
	    if (password1 !== password2) {
	        $('#password2')[0].setCustomValidity('密碼不吻合');
	    } else {
	        $('#password2')[0].setCustomValidity('');
	    }
	});
    
    
    // 新增會員按鈕
    $('#registerButton').click(function() {
        // 檢查表單是否有效
        if ($('#createMember')[0].checkValidity()) {
            // 如果表單有效，顯示完成的 alert
            Swal.fire({
                position: "center",
                icon: "success",
                iconColor: '#4CAF50',
                title: "會員加入成功",
                showConfirmButton: false,
                timer: 1000
            });
            // 重導到後台 member 頁面
            window.location.href = 'http://localhost:8080/member';
        } else {
            // 如果表單無效，觸發預設的提示（例如 required 屬性的提示）
            $('#createMember')[0].reportValidity();
        }
    });
    

      // 新增會員時驗證帳號是否存在
	  $('#account').on('input', function(event) {
	    var account = $(this).val();
	    // 使用 AJAX 發送請求檢查帳號是否存在
	    $.ajax({
	        type: 'GET',
	        url: 'http://localhost:8080/member_backend/checkAccount',
	        data: { account: account },
	        success: function(response) {
	            if (response.exists) {
	                $('#accountError').css('display', 'block');
					// 讓加入會員按鈕不能按
	                $('#registerButton').prop('disabled', true);
	            } else {
	                $('#accountError').css('display', 'none');
	                // 讓加入會員按鈕可以按
	                $('#registerButton').prop('disabled', false);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	  });
    
	// 新增會員時驗證Email是否存在
	$('#email').on('input', function(event) {
	    var email = $(this).val();
	    
	    // 使用 AJAX 發送請求檢查 Email 是否存在
	    $.ajax({
	        type: 'GET',
	        url: 'http://localhost:8080/member_backend/checkEmail',
	        data: { email: email },
	        success: function(response) {
	            if (response.exists) {
	                $('#emailError').css('display', 'block');
	                // 讓加入會員按鈕不能按
	                $('#registerButton').prop('disabled', true);
	            } else {
	                $('#emailError').css('display', 'none');
	                // 讓加入會員按鈕可以按
	                $('#registerButton').prop('disabled', false);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	});
	
	
	// 新增會員時驗證手機是否存在
	$('#phone').on('input', function(event) {
	    var phone = $(this).val();
	    
	    // 使用 AJAX 發送請求檢查手機號碼是否存在
	    $.ajax({
	        type: 'GET',
	        url: 'http://localhost:8080/member_backend/checkPhone',
	        data: { phone: phone },
	        success: function(response) {
	            if (response.exists) {
	                $('#phoneError').css('display', 'block');
	                // 讓加入會員按鈕不能按
	                $('#registerButton').prop('disabled', true);
	            } else {
	                $('#phoneError').css('display', 'none');
	                // 讓加入會員按鈕可以按
	                $('#registerButton').prop('disabled', false);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	});
	    
    

    
    
});








