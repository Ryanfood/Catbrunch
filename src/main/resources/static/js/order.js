$(document).ready(function () {
    // 初始化頁面加載時顯示分頁
    initializePagination('appetizer');

    // 獲取按鈕對應的分類
    $('.list-group-item').click(function () {
        var category = $(this).data('category');
    });

    // 當視窗大小改變時重新初始化分頁
    $(window).resize(function () {
        initializePagination();
    });

    // 定義全局變數，初始值為 localStorage 中的值或 null
    let orderData = JSON.parse(localStorage.getItem('orderData')) || {
        tableNumber: null,
        total: 0,
        orderTime: null,
        items: []
    };

    // 監聽選擇框的變化事件
    $('.form-select').change(function () {
        orderData.tableNumber = $(this).val();
        saveOrderData();
    });

    // 渲染購物車
    function renderCart() {
        let cartItems = $('#cart-items'); // 選擇購物車項目容器
        cartItems.empty(); // 清空購物車容器的內容
        let totalPrice = 0; // 初始化總金額
        orderData.items.forEach((item, index) => {
            totalPrice += item.price * item.quantity; // 計算總金額
            cartItems.append(`
                <tr class="">
                    <td class="text-center py-2">${item.orderName}</td>
                    <td class="text-center py-2">${item.price}</td>
                    <td class="text-center py-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-outline-secondary btn-sm change-quantity" data-index="${index}" data-action="decrease">-</button>
                            </div>
                            <input type="text" class="form-control text-center quantity-input" value="${item.quantity}" readonly>
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary btn-sm change-quantity" data-index="${index}" data-action="increase">+</button>
                            </div>
                        </div>
                    </td>
                    <td class="text-center py-2">NT$${item.price * item.quantity}</td>
                    <td class="text-center py-2"><button type="button" class="btn btn-outline-danger btn-sm remove-item" data-index="${index}">刪除</button></td>
                </tr>
            `);
        });
        $('#total-amount').text(`總金額: NT$${totalPrice}`); // 更新總金額顯示
        $('#table-number').text(`桌號: ${orderData.tableNumber}`); // 更新桌號顯示
        orderData.totalPrice = totalPrice; // 更新總金額
        saveOrderData(); // 保存訂單資料
    }

    // 將訂單資料儲存到 localStorage
    function saveOrderData() {
        localStorage.setItem('orderData', JSON.stringify(orderData));
    }

    // 將項目添加到購物車
    function addToCart(item) {
        let existingItem = orderData.items.find(cartItem => cartItem.orderName === item.orderName);
        if (existingItem) {
            existingItem.quantity++; // 如果存在，增加其數量
        } else {
            orderData.items.push({ ...item, quantity: 1 }); // 如果不存在，將其添加到購物車中
        }

        Swal.fire({
            position: "center",
            icon: "success",
            iconColor: '#4CAF50',
            title: `${item.orderName}已加入購物車`,
            showConfirmButton: false,
            timer: 1000
        });

        renderCart(); // 渲染更新後的購物車
    }

    // 點擊添加到購物車按鈕時將餐點添加到購物車
    $('#meal-container').on('click', '.add-to-cart', function () {
        let orderName = $(this).data('name'); // 獲取餐點名稱
        let price = $(this).data('price'); // 獲取餐點價格
        if (orderName && price) { // 檢查名稱和價格是否有效
            addToCart({ orderName, price }); // 添加到購物車
        }
    });

    // 點擊刪除按鈕時從購物車中移除對應項目
    $('#cart-items').on('click', '.remove-item', function () {
        let index = $(this).data('index'); // 獲取項目索引
        var itemName = $(this).closest('tr').find('td').eq(0).text().trim(); // 獲取當前按鈕所在的行，並直接取第一個單元格的內容

        Swal.fire({
            title: "確定要刪除嗎?",
            text: "此操作無法恢復！",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "刪除",
            cancelButtonText: "取消"
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: `${itemName}刪除成功!`,
                    icon: "success",
                    iconColor: '#4CAF50',
                    timer: 1000,
                    showConfirmButton: false
                });

                orderData.items.splice(index, 1); // 刪除對應項目
                renderCart(); // 渲染更新後的購物車
            }
        });
    });

    // 點擊增加或減少數量按鈕時更新對應項目的數量
    $('#cart-items').on('click', '.change-quantity', function () {
        let index = $(this).data('index'); // 獲取項目索引
        let action = $(this).data('action'); // 獲取操作類型（增加或減少）

        if (action === 'increase') {
            orderData.items[index].quantity++; // 增加數量
        } else if (action === 'decrease') {
            if (orderData.items[index].quantity > 1) {
                orderData.items[index].quantity--; // 減少數量
            }
        }

        renderCart(); // 渲染更新後的購物車
    });

    // 點擊送出訂單按鈕時，使用 AJAX 將購物車資料發送到後端
    $('#submit-order').on('click', function (event) {
        event.preventDefault(); // 阻止表單的默認提交行為

        // 獲取選擇的桌號
        var tableNumber = $('.form-select').val();
        if (!tableNumber) {
            Swal.fire({
                icon: "error",
                title: "請選擇桌號！",
                timer: 1500,
                showConfirmButton: false
            });
            return;
        }



        if (orderData.items.length === 0) {
            Swal.fire({
                icon: "error",
                title: "購物車是空的，無法結帳！",
                timer: 1500,
                showConfirmButton: false
            });
            return;
        }

        // 更新桌號
        orderData.tableNumber = tableNumber;

        // 更新訂單時間
        orderData.orderTime = new Date().toISOString().replace('T', ' ').substring(0, 19); // 新增訂單時間，格式為 "yyyy-MM-dd HH:mm:ss"

        /*
        // 獲取當前時間
        var currentDate = new Date();
    	
        // 格式化輸出
        orderData.orderTime = currentDate.getFullYear() + '-' +
            ('0' + (currentDate.getMonth() + 1)).slice(-2) + '-' +
            ('0' + currentDate.getDate()).slice(-2) + ' ' +
            ('0' + currentDate.getHours()).slice(-2) + ':' +
            ('0' + currentDate.getMinutes()).slice(-2) + ':' +
            ('0' + currentDate.getSeconds()).slice(-2);
         */

        // 使用 AJAX 發送資料到後端
        $.ajax({
            url: 'http://localhost:8080/order_backend/', // 替換為你的後端提交訂單的 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(orderData),
            success: function (response) {
                Swal.fire({
                    icon: "success",
                    iconColor: '#4CAF50',
                    title: "訂單已送出！",
                    timer: 1500,
                    showConfirmButton: false
                });

                if (response.redirectUrl) {
                    window.location.href = response.redirectUrl;
                } else {
                    orderData = { // 重置訂單資料
                        tableNumber: null,
                        total: 0,
                        orderTime: null,
                        items: []
                    };
                    $('.form-select').val(null).prop('selectedIndex', 0);
                    renderCart(); // 渲染空的購物車
                }
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    icon: "error",
                    title: "送出訂單失敗，請稍後再試",
                    timer: 1500,
                    showConfirmButton: false
                });
            }
        });
    });

    renderCart(); // 在頁面載入時渲染購物車

    // 分頁相關函數
    function getPerPage() {
        if (window.innerWidth < 767) {
            return 4;
        } else if (window.innerWidth < 992) {
            return 6;
        } else {
            return 9;
        }
    }

    function initializePagination() {
        var perPage = getPerPage();
        // 總共有多少個項目
        var numItems = $(".list-item").length;
        // 初始化時先顯示前幾個項目
        $(".list-item").hide().slice(0, perPage).show();

        // 如果頁面已經有分頁控制元件，先移除
        if ($(".pagination-container").length) {
            $(".pagination-container").remove();
        }

        // 添加新的分頁控制元件
        $("#pagination").pagination({
            items: numItems,
            itemsOnPage: perPage,
            cssStyle: "light-theme",
            prevText: "&laquo;",
            nextText: "&raquo;",
            onPageClick: function (pageNumber) {
                var showFrom = perPage * (pageNumber - 1);
                var showTo = showFrom + perPage;
                $(".list-item").hide().slice(showFrom, showTo).show();
            },
        });
    }
});
