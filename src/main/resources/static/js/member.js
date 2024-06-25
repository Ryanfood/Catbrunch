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
  
	// 頁面加載時，顯示登入表單（.login），隱藏註冊表單（.register）和忘記密碼表單（.forget）
    $('.login').removeClass('d-none');
    $('.register').addClass('d-none');
    $('.forget').addClass('d-none');

    // 切換到註冊表單
    $('#toRegister').on('click', function(e) {
        e.preventDefault();
        $('.login').addClass('d-none');
        $('.register').removeClass('d-none');
        $('.forget').addClass('d-none');
    });

    // 切換到登入表單
    $('#toLogin').on('click', function(e) {
        e.preventDefault();
        $('.register').addClass('d-none');
        $('.login').removeClass('d-none');
        $('.forget').addClass('d-none');
    });

    // 切換到忘記密碼表單
    $('#toForget').on('click', function(e) {
        e.preventDefault();
        $('.login').addClass('d-none');
        $('.register').addClass('d-none');
        $('.forget').removeClass('d-none');
    });

    // 從忘記密碼表單切換到登入表單
    $('#toLoginFromForget').on('click', function(e) {
        e.preventDefault();
        $('.forget').addClass('d-none');
        $('.login').removeClass('d-none');
        $('.register').addClass('d-none');
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
                                window.location.href = 'http://localhost:8080/menu_backend';
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
	
	
	
	// 初始倒數時間（秒）
    var countdown = 60;

    function startCountdown() {
        // 禁用按鈕
        $('#forgetButton').prop('disabled', true);

        // 更新按鈕文字顯示
        $('#forgetButton').text(countdown + ' 秒後傳送驗證碼');

        // 倒數計時器
        var timer = setInterval(function() {
            countdown--;
            $('#forgetButton').text(countdown + ' 秒後傳送驗證碼');
            if (countdown <= 0) {
                // 倒數計時結束，啟用按鈕並重置倒數時間
                clearInterval(timer);
                $('#forgetButton').prop('disabled', false);
                $('#forgetButton').text('傳送驗證碼');
                countdown = 60; // 重置倒數時間
            }
        }, 1000);
    }

	// Email 名稱只顯示前3內容，後面加 * 符號
	function maskEmail(email) {
	    let atIndex = email.indexOf('@');
	    let namePart = email.substring(0, atIndex);
	    let domainPart = email.substring(atIndex);
	    let maskedNamePart = namePart.substring(0, 3) + '*'.repeat(namePart.length - 3);
	    return maskedNamePart + domainPart;
	}
	    
    // 寄送 Email 驗證碼
	$('#forgetButton').on('click', function(e) {
	    e.preventDefault();
	    
	    if (email === '') {
	        // 使用 SweetAlert 彈出提示
	        Swal.fire({
	            icon: 'warning',
	            title: '請先輸入Email'
	        });
	        return; // 終止函數的執行
	    }
		    
	    
	    var email = $('#forgetEmail').val();
	    let maskedEmail = maskEmail(email);
	    if (email) {
	        $.ajax({
	            url: '/forget',
	            type: 'POST',
	            data: JSON.stringify({ email: email }),
	            contentType: 'application/json',
	            beforeSend: function() {
	                Swal.fire({
	                    title: '正在發送驗證碼...',
	                    allowOutsideClick: false,
	                    timer: 3000, // 設定發送驗證碼的超時時間，這裡設定為3秒
	                    timerProgressBar: true,
	                    didOpen: () => {
	                        Swal.showLoading();
	                        const timer = Swal.getPopup().querySelector('.swal2-timer-progress-bar');
	                        timerInterval = setInterval(() => {
	                            const remainingTime = Swal.getTimerLeft();
	                            const progressBarWidth = (remainingTime / 3000) * 100; // 3000 是設定的計時器時間
	                            timer.style.width = progressBarWidth + '%';
	                        }, 100);
	                    },
	                    willClose: () => {
	                        clearInterval(timerInterval);
	                    }
	                }).then((result) => {
	                    if (result.dismiss === Swal.DismissReason.timer) {
	                        console.log('I was closed by the timer');
	                    }
	                });
	            },
	            success: function(response) {
					// 倒數一分鐘後才可以再傳送驗證碼
					startCountdown();
	                Swal.fire({
	                    icon: 'success',
	                    iconColor: '#4CAF50',
	                    title: '驗證碼已發送到您的信箱 ' + maskedEmail

	                });
	            },
	            error: function(error) {
	                Swal.fire({
	                    icon: 'error',
	                    title: '傳送驗證碼失敗',
	                    timer: 3000,
	                    timerProgressBar: true
	                });
	            }
	        });
	    } else {
	        Swal.fire({
	            icon: 'error',
	            title: '請輸入有效的電子郵件地址',
	            timer: 3000,
	            timerProgressBar: true
	        });
	    }
	});

	// 變更密碼時驗證Email是否存在
	$('#forgetEmail').on('input', function() {
	    var email = $(this).val();

	    // 使用 AJAX 發送請求檢查 Email 是否存在
	    $.ajax({
	        type: 'GET',
	        url: 'http://localhost:8080/member_backend/checkEmail',
	        data: { email: email },
	        success: function(response) {
	            if (response.exists || email === '') {
	                $('#changeMailError').css('display', 'none');
	                // 讓傳送驗證碼按鈕可以按
	                $('#forgetButton').prop('disabled', false);
	                $('#changeButton').prop('disabled', false);
	            } else {
	                $('#changeMailError').css('display', 'block');
	                // 讓傳送驗證碼按鈕不能按
	                $('#forgetButton').prop('disabled', true);
	                $('#changeButton').prop('disabled', true);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	});


	// 當點擊驗證按鈕時
	$('#verifyCodeButton').click(function() {
	    var code = $('#verificationCode').val();
	    var email = $('#updateEmail').val(); // 從表單中獲取 Email
	
	    // 使用 AJAX 向後端驗證驗證碼是否正確
	    $.ajax({
	        type: 'POST',
	        url: '/verify-code', // 請根據你的後端端點來修改
	        data: JSON.stringify({ email: email, code: code }),
	        contentType: 'application/json',
	        success: function(response) {
	            if (response === '驗證成功') {
	                // 隱藏驗證相關的元素，顯示修改密碼相關的元素
	                $('#updateEmail').closest('.input-group').hide();
	                $('label[for="email"]').hide();
	                $('#verificationCode').closest('.input-group').hide();
	                $('label[for="verificationCode"]').hide();
	                $('#verifyCodeButton').hide();
	                $('#passwordFields').show();
	                $('#updateButton').show();
	                $('#codeError').hide();
	
	                // 彈出成功提示訊息
	                Swal.fire({
	                    icon: 'success',
	                    iconColor: '#4CAF50',
	                    title: '驗證碼輸入正確',
	                    showConfirmButton: false,
	                    timer: 1500
	                });
	            } else {
	                // 驗證碼錯誤，彈出 SweetAlert 提示訊息
	                Swal.fire({
	                    icon: 'error',
	                    title: '驗證碼錯誤，請確認。',
	                    timer: 3000,
	                    timerProgressBar: true
	                });
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	});
    
    
	// 當點擊變更密碼按鈕時
    $('#changeButton').click(function(event) {
        // 確保 Email 欄位非空
        var email = $('#forgetEmail').val();
        if (email.trim() !== '') {
            $('#updateEmail').val(email);

            // 重置表單欄位
            $('#updateMemberForm')[0].reset();

            // 重置元素的顯示狀態
            $('#updateEmail').closest('.input-group').show();
            $('label[for="email"]').show();
            $('#verificationCode').closest('.input-group').show();
            $('label[for="verificationCode"]').show();
            $('#verifyCodeButton').show();
            $('#passwordFields').hide();
            $('#updateButton').hide();
            $('#codeError').hide();

            // 顯示 Modal
            $('#changePassword').modal('show');
        } else {
            // 阻止默認行為（防止跳出 Modal）
            event.preventDefault();

            // 使用 SweetAlert 彈出提示
            Swal.fire({
                icon: 'warning',
                title: '請先輸入Email'
            });
        }
    });
    
    // 按下變更密碼按鈕後，把 Email 的值傳給 Modal
	$('#changeButton').click(function() {
        var email = $('#forgetEmail').val();
        $('#updateEmail').val(email);
    });
    
    
    // 當點擊驗證按鈕時
	$('#verifyCodeButton').click(function() {
	    var code = $('#verificationCode').val();
	    var email = $('#updateEmail').val(); // 從表單中獲取 Email
	
	    // 使用 AJAX 向後端驗證驗證碼是否正確
	    $.ajax({
	        type: 'POST',
	        url: '/verify-code', // 請根據你的後端端點來修改
	        data: JSON.stringify({ email: email, code: code }),
	        contentType: 'application/json',
	        success: function(response) {
	            if (response === '驗證成功') {
	                // 顯示修改密碼的表單
	                $('#passwordFields').show();
	                $('#updateButton').show();
	                $('#verifyCodeButton').hide();
	            } else {
	                // 驗證碼錯誤，彈出 SweetAlert 提示訊息
	                Swal.fire({
	                    icon: 'error',
	                    title: '驗證碼錯誤，請確認。',
	                    timer: 2000,
	                    timerProgressBar: true
	                });
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	});

	
	// 密碼驗證規則
	function validatePattern(password) {
	    var pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/;
	    return pattern.test(password);
	}

	
	// 在點擊修改密碼按鈕時進行新密碼格式驗證
	$('#updateButton').click(function() {
	    var newPassword = $('#newPassword').val();
	    var newPassword2 = $('#newPassword2').val();
	    var email = $('#updateEmail').val(); // 從表單中獲取 Email
	
	    // 檢查兩次輸入的新密碼是否一致
	    if (newPassword !== newPassword2) {
	        Swal.fire({
	            icon: 'error',
	            title: '新密碼與確認密碼不一致。',
	            showConfirmButton: false,
	            timer: 1500
	        });
	    } else if (!validatePattern(newPassword)) { // 新密碼格式驗證
	        Swal.fire({
	            icon: 'error',
	            title: '密碼必須至少包含一個字母、一個數字，且至少6個字符。'
	        });
	    } else {
	        // 使用 AJAX 向後端提交修改密碼的請求
	        $.ajax({
	            type: 'PUT',
	            url: '/reset-password',
	            data: JSON.stringify({ email: email, newPassword: newPassword }),
	            contentType: 'application/json',
	            success: function(response) {
	                Swal.fire({
	                    icon: 'success',
	                    iconColor: '#4CAF50',
	                    title: '密碼修改成功！', 
	                    showConfirmButton: false,
	                    timer: 1300
	                }).then(function() {
	                    // 跳轉到 member 頁面
	                    window.location.href = '/member'; 
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	            }
	        });
	    }
	});


});









