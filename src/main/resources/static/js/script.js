// 確保當整個網頁載入完畢後執行
$(document).ready(function() {
    // 從 localStorage 中取得 memberName 資料
    var memberName = localStorage.getItem('memberName');
    
    // 找到具有 hello 類別的 <a> 元素，並將歡迎回來 memberName 設定為其內容
    $('.hello').text('歡迎回來 ' + memberName);
});
