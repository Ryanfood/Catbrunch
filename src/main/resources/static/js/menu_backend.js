$(document).ready(function () {
  // 初始化頁面加載時顯示分頁
  initializePagination('appetizer');

  // 獲取按鈕對應的分類
  $('.list-group-item').click(function () {
    var category = $(this).data('category');
  });

  // 監聽視窗大小改變事件，並重新初始化分頁
  $(window).resize(function () {
    getPerPage();
    initializePagination();
  });

  // 根據視窗寬度設置每頁顯示的項目數量
  function getPerPage() {
    if (window.innerWidth < 767) {
      return 4;
    } else if (window.innerWidth < 992) {
      return 6;
    } else {
      return 9;
    }
  }

  function initializePagination(category) {
    var perPage = getPerPage();
    // 總共有多少個項目
    var numItems = $("." + category + " .list-item").length;
    // 初始化時先顯示前幾個項目
    $("." + category + " .list-item").addClass('d-none').slice(0, perPage).removeClass('d-none');

    // 初始化分頁
    $('#pagination-container').pagination('destroy').pagination({
      items: numItems,
      itemsOnPage: perPage,
      prevText: "&laquo",
      nextText: "&raquo",
      onPageClick: function (pageNumber) {
        var from = perPage * (pageNumber - 1);
        var to = from + perPage;
        $("." + category + " .list-item").addClass('d-none').slice(from, to).removeClass('d-none');
      }
    });
  }
  
  // 刷新表單內的圖片
  $('#mealImage').change(function (event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        // 找到已有的 img 標籤，並更新其 src 屬性
        $('#imagePreview img').attr('src', e.target.result);
      };
      reader.readAsDataURL(file);

    }
  });
  


  // 新增或修改菜單按鈕
  $('#addMenuForm').on('submit', function (event) {
    // 阻止表單的默認提交行為
    event.preventDefault();

    // 獲取按鈕的 data-action 屬性的值
    var action = $('button[type="submit"]').data('action');

    // 根據 data-action 的值顯示相應的 SweetAlert2 警告框
    if (action === 'update') {
      Swal.fire({
        icon: "success",
        iconColor: '#4CAF50',
        title: "修改菜單成功",
        showConfirmButton: false,
        timer: 1000
      });
    } else if (action === 'create') {
      Swal.fire({
        icon: "success",
        iconColor: '#4CAF50',
        title: "新增菜單成功",
        showConfirmButton: false,
        timer: 1000
      });
    }
    // 表單提交
    this.submit();
  });



  // 刪除按鈕
  $('.deleteButton').on('click', function (event) {
    event.preventDefault(); // 阻止表單的默認提交行為

    var form = $(this).closest('form'); // 獲取當前按鈕所在的表單

    // closest 方法找最近具有 list-item 類的父元素，在該元素內部找具有 card-title 類的元素，然後取得文本內容並去除頭尾空白
    var mealName = $(this).closest('.list-item').find('.card-title').text().trim();

    // 使用 SweetAlert2 顯示確認提示框
    Swal.fire({
      title: '確定要刪除嗎?',
      text: '此操作無法恢復！',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: '刪除',
      cancelButtonText: '取消'
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire({
          title: `${mealName}刪除成功!`,
          icon: "success",
          iconColor: '#4CAF50',
          timer: 1300,
          showConfirmButton: false
        });
        form.submit();
      }
    });
  });





});
