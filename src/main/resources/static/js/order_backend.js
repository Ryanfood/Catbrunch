$(document).ready(function() {
    let isAscending = true; // 預設遞增排序
/*
    // 刪除按鈕事件
    $('#orderTable').on('click', '.delete-btn', function() {
        $(this).closest('tr').remove();
    });
*/

    // 圖片點擊排序事件
    $('th img').click(function() {
        const columnIndex = $(this).closest('th').index(); // 獲取點擊的圖片所在標題的列索引
        const rows = $('#orderTable tbody tr').get(); // 獲取所有行

        // 切換排序符號
        $('th').removeClass('sorted ascending descending');
        if (isAscending) {
            $(this).closest('th').addClass('sorted ascending');
        } else {
            $(this).closest('th').addClass('sorted descending');
        }

        // 圖片旋轉
        $(this).css({ transform: `rotate(${isAscending ? 180 : 0}deg)`, transition: 'transform 0.2s' });
        
        // 恢復其他三個th的圖片狀態
        $(this).closest('tr').siblings().find('img').css({ transform: 'rotate(0deg)' });

        // 排序
        rows.sort((a, b) => {
            const aValue = $(a).find('td').eq(columnIndex).text().toLowerCase();
            const bValue = $(b).find('td').eq(columnIndex).text().toLowerCase();
            return (isAscending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue));
        });

        // 更新表格
        $.each(rows, function(index, row) {
            $('#orderTable tbody').append(row);
        });

        // 切換排序順序
        isAscending = !isAscending;
    });

    // 搜尋功能
    $('#searchInput').on('keyup', function() {
        const searchText = $(this).val().toLowerCase();
        $('#orderTable tbody tr').each(function() {
            let found = false;
            $(this).find('td').each(function() {
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
	  
	  
	// 刪除餐點
	$('.deleteButton').click(function(event) {
        event.preventDefault(); // 防止默認的表單提交行為

        var form = $(this).closest('form'); // 獲取當前按鈕所在的表單
    	var orderId = form.find('input[name="orderId"]').val(); // 獲取orderId

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
			      title: `${orderId}號餐點刪除成功!`,
			      icon: "success",
			      iconColor: '#4CAF50',
			      showConfirmButton: false
			    });
                form.submit();
            }
        });
    });
    
    
    
    
    // 傳送訂餐資料
    $('.details').click(function() {
            var id = $(this).data('id');
            var tableNumber = $(this).data('table-number');
            var totalPrice = $(this).data('total-price');
            getOrderItems(id,tableNumber, totalPrice);
        });

        function getOrderItems(id,tableNumber, totalPrice) {
            $.ajax({
                url: "http://localhost:8080/order_backend/" + id,
                type: "GET",
                dataType: "json",
                success: function(data) {

                    // 遍歷陣列並顯示資料
                    var output = "<div class='d-flex justify-content-between'><h3>訂單編號：" + id + "</h3></div>";
                    output += "<h3>桌號：" + tableNumber + "</h3>";
                    output += "<table class='table table-striped table-bordered text-center table-hover'>";
                    output += "<thead><tr><th>餐點名稱</th><th>數量</th><th>單價</th><th>總價</th></tr></thead><tbody>";
                    $.each(data, function(index, item) {
                        output += "<tr>";
                        output += "<td>" + item.orderName + "</td>";
                        output += "<td>" + item.quantity + "</td>";
                        output += "<td>" + item.price + "元</td>";
                        output += "<td>" + item.quantity * item.price + "元</td>";
                        output += "</tr>";
                    });
                    output += "</tbody></table>";
                    output += "<h3 class='text-end'>總金額：" + totalPrice + "元</h3>";
                    
                    output += `<div class="modal-button my-3 text-center">
				                   <button type="button" class="btn btn-outline-secondary me-3" data-bs-dismiss="modal">取消</button>
				               </div>`;

                    $(".modal-body").html(output);
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        }
	  
	  

});
