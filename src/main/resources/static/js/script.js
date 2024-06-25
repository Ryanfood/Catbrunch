// 確保當整個網頁載入完畢後執行
$(document).ready(function() {
    // 從 localStorage 中取得 memberName 資料
    var memberName = localStorage.getItem('memberName');
    // 從 localStorage 中取得 isMember 資料
    var isMember = localStorage.getItem('isMember');
    
    // 若權限不是1或2則隱藏歡迎詞
    if (isMember !== '1' && isMember !== '2') {
        $('.hello').hide(); // 隱藏歡迎語句元素
    }
    
    // 找到具有 hello 類別的 <a> 元素，並將歡迎回來 memberName 設定為其內容
    $('.hello').text('歡迎回來 ' + memberName + ' 鏟屎官');

	// 登出按鈕
	$('.logout').on('click', function(event) {
        event.preventDefault(); // 防止默認的跳轉行為
        
        // 清空 localStorage 中的資料
	    localStorage.removeItem('memberName');
	    localStorage.removeItem('isMember');
	    
        Swal.fire({
            title: '登出成功!',
            icon: 'success',
            iconColor: '#4CAF50',
            showConfirmButton: false,
            timer: 900
        }).then(() => {
            window.location.href = '/logout';
        });
    });
	    
});
