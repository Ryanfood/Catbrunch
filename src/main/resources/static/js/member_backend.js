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
	

	// 預設遞增排序
    let isAscending = true; 

    // 圖片點擊排序事件
    $('th img').click(function () {
        const columnIndex = $(this).closest('th').index(); // 獲取點擊的圖片所在標題的列索引
        const rows = $('#memberTable tbody tr').get(); // 獲取所有行

        // 切換排序符號
        $('th').removeClass('sorted ascending descending');
        if (isAscending) {
            $(this).closest('th').addClass('sorted ascending');
        } else {
            $(this).closest('th').addClass('sorted descending');
        }

        // 圖片旋轉
        $(this).css({ transform: `rotate(${isAscending ? 180 : 0}deg)`, transition: 'transform 0.2s' });

        // 排序
        rows.sort((a, b) => {
            const aValue = $(a).find('td').eq(columnIndex).text().toLowerCase();
            const bValue = $(b).find('td').eq(columnIndex).text().toLowerCase();
            return (isAscending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue));
        });

        // 更新表格
        $.each(rows, function (index, row) {
            $('#memberTable tbody').append(row);
        });

        // 切換排序順序
        isAscending = !isAscending;
    });

    // 搜尋功能
    $('#searchInput').on('keyup', function () {
        const searchText = $(this).val().toLowerCase();
        $('#memberTable tbody tr').each(function () {
            let found = false;
            $(this).find('td').each(function () {
                const cellText = $(this).text().toLowerCase();
                if (cellText.includes(searchText)) {
                    found = true;
                    return false; // 找到匹配內容就跳出迴圈
                }
            });
            if (found) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
    
    
    
    // 按下修改按鈕將資料傳到表單
	$('#sec1 .btn-outline-success').click(function() {
	    // 獲取需要傳遞的資料
	    var memberId = $(this).closest('tr').find('td:first-child').text(); // 會員ID
	    var account = $(this).closest('tr').find('td:nth-child(2)').text(); // 帳號
	    var password = $(this).closest('tr').find('td:nth-child(3)').text(); // 密碼
	    var name = $(this).closest('tr').find('td:nth-child(4)').text(); // 姓名
	    var gender = $(this).closest('tr').find('td:nth-child(5)').text(); // 性別
	    var birthday = $(this).closest('tr').find('td:nth-child(6)').get(0).textContent.trim(); // 生日
	    var email = $(this).closest('tr').find('td:nth-child(7)').text(); // 電子郵件
	    var phone = $(this).closest('tr').find('td:nth-child(8)').text(); // 手機號碼
	    
		$('#updateMemberForm').attr("action", `/member_backend/${memberId}`);
	    // 將資料設置到 updateMemberForm 表單中的對應輸入字段
	    $('#updateMemberForm #memberId').val(memberId);
	    $('#updateMemberForm #updateAccount').val(account);
	    $('#updateMemberForm #updatePassword').val(password);
	    $('#updateMemberForm #updatePassword2').val(password);
	    $('#updateMemberForm #updateName').val(name);
	    $('#updateMemberForm input[name="gender"]').prop('checked', false); // 清除所有選中的性別選項
	    if (gender === '男生') {
	        $('#updateMemberForm #genderMale').prop('checked', true);
	    } else {
	        $('#updateMemberForm #genderFemale').prop('checked', true);
	    }
	    $('#updateMemberForm #updateBirthday').val(birthday);
	    $('#updateMemberForm #updateEmail').val(email);
	    $('#updateMemberForm #updatePhone').val(phone);
	    
	
	    // 手動提交表單或者顯示模態視窗供用戶進行修改確認
	    // $('#updateMemberForm').submit(); // 如果要自動提交表單
	    $('#updateForm').modal('show'); // 如果要顯示模態視窗
	});
	
	
	  // 以下是分頁	
	  
	  // 監聽視窗大小改變事件，並重新初始化分頁
	  $(window).resize(function () {
	    getPerPage();
	  });
	
	  // 根據視窗寬度設置每頁顯示的項目數量
	  function getPerPage() {
	    if (window.innerWidth < 767) {
	      return 6;
	    } else if (window.innerWidth < 992) {
	      return 8;
	    } else {
	      return 10;
	    }
	  }
	
	  // 每個頁面要顯示幾個項目
	  var perPage = getPerPage();
	  // 總共有多少個項目
	  var numItems = $(".list-item").length;
	
	  $(".list-item").slice(perPage).hide();
	
	  $('#pagination-container').pagination({
	
	    items: numItems,
	    itemsOnPage: perPage,
	    prevText: "&laquo",
	    nextText: "&raquo",
	    onPageClick: function (pageNumber) {
	      // 計算起始及結束
	      var from = perPage * (pageNumber - 1);
	      var to = from + perPage;
	      $(".list-item").hide().slice(from, to).show();
	    }
	  })
	  
	  
	  
	  
	// 密碼驗證規則
	function validatePattern(password) {
	    var pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/;
	    return pattern.test(password);
	}
	
	// 驗證表單密碼
	$('#updatePassword, #updatePassword2').on('input', function() {
	    var password1 = $('#updatePassword').val();
	    var password2 = $('#updatePassword2').val();
	
	    // 檢查第一個密碼是否符合 pattern
	    if (!validatePattern(password1)) {
	        $('#updatePassword')[0].setCustomValidity('密碼必須至少包含一個字母、一個數字，且至少6個字符');
	    } else {
	        $('#updatePassword')[0].setCustomValidity('');
	    }
	
	    // 檢查兩個密碼是否一致
	    if (password1 !== password2) {
	        $('#updatePassword2')[0].setCustomValidity('密碼不吻合');
	    } else {
	        $('#updatePassword2')[0].setCustomValidity('');
	    }
	});
	  
	  
	  
	  
	// 修改會員
    $('#updateButton').click(async function() {
	    // 檢查表單是否有效
	    if ($('#updateMemberForm')[0].checkValidity()) {
	        // 取得會員ID並呼叫updateMember函數
	        var memberId = $('#memberId').val(); // 會員ID
	        await updateMember(memberId);
	    } else {
	        // 如果表單無效，觸發預設的提示（例如 required 屬性的提示）
	        $('#updateMemberForm')[0].reportValidity();
	    }
	});


	  // 修改會員
	  $('#updateMemberForm').on('submit', function(event) {
	  	// 阻止表單的默認提交行為
	  	event.preventDefault(); 
	    
	    var form = $(this).closest('form'); // 獲取當前按鈕所在的表單
	    var memberId = form.find('input[name="memberId"]').val(); // 獲取memberId
	   
	    Swal.fire({
	        position: "center",
	        icon: "success",
	        iconColor: '#4CAF50',
	        title: `${memberId}號會員修改成功`,
	        showConfirmButton: false,
	        timer: 1300
	    });
	    
	     // 使用 fetch 提交表單
	     
	    fetch('http://localhost:8080/member_backend/' + memberId, {
	        method: 'PUT',
	        body: new FormData(form[0])
	    })
	    .then(response => {
	        if (response.ok) {
	            window.location.href = 'http://localhost:8080/member_backend';
	        } else {
	            return response.text().then(text => { throw new Error(text) });
	        }
	    })
	    .catch(error => {
	        console.error('發生錯誤', error);
	        Swal.fire({
	            icon: 'error',
	            title: '伺服器錯誤'
	        });
	    });
	    
	  });
	

	
	
	


	// 刪除會員
	$('.deleteButton').click(function(event) {
        event.preventDefault(); // 防止默認的表單提交行為

        var form = $(this).closest('form'); // 獲取當前按鈕所在的表單
    	var memberId = form.find('input[name="memberId"]').val(); // 獲取memberId

        // 顯示確認對話框
        Swal.fire({
            title: '確定要刪除嗎？',
            text: "此操作無法恢復！",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '確定',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
                // 確認刪除，提交表單
                Swal.fire({
			      title: `${memberId}號會員刪除成功!`,
			      icon: "success",
			      iconColor: '#4CAF50',
			      showConfirmButton: false
			    });
                form.submit();
            }
        });
    });

	
	// 設置每個 .ellipsis 元素的 title 屬性為其文本內容
    $('.ellipsis').each(function () {
        $(this).attr('title', $(this).text());
    });

    // 初始化所有帶有 data-bs-toggle="tooltip" 的元素
    $('[data-bs-toggle="tooltip"]').tooltip();

    
});

/*
	// ready 外面
	// 修改會員
  	var updateMember = async () => {
	    var memberId = $('#memberId').val(); // 會員ID

		 Swal.fire({
			  position: "center",
			  icon: "success",
			  title: `${memberId}號會員修改成功`,
			  showConfirmButton: false,
			  timer: 1300
		 });
		 
	    try {
	        var response = await fetch('http://localhost:8080/member_backend/' + memberId, {
	            method: "PUT",
	            body: new FormData($('#updateMemberForm')[0])
	        });
	        
	        const result = await response.text();

			// 跳轉到 http://localhost:8080/member_backend
	        if (result) {
	            window.location.href = 'http://localhost:8080/member_backend';
	        }
	        
	    } catch (error) {
	        console.error('發生錯誤', error);
	    }
	}

*/

