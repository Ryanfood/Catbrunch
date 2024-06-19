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


});
