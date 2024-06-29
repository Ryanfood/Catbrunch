# 貓貓早午餐 CatBrunch

<img src="https://raw.githubusercontent.com/Ryanfood/Catbrunch/master/src/main/resources/static/img/Logo/Logo.gif" alt="CatBrunch Logo" width="100" height="100">

## 簡介
貓貓早午餐是一個結合美食分享和貓咪愛好者的早午餐網站。你可以在這裡品嘗美味的早午餐，並欣賞可愛貓咪的趣味故事和照片。

## 動機與目的
此專題名稱是因為常和朋友到處嘗試一些美食，也加上本身蠻喜歡貓咪，又覺得貓咪慵懶的樣子看起來很療癒，所以想把這兩項興趣做結合，做成一個早午餐的網站。貓貓早午餐不僅是分享美食的地方，更是愛貓人士的交流平台。在這裡，你可以品嘗到美味的早午餐，也能看到可愛貓咪的趣味故事和照片。

## 系統架構
![image](https://github.com/Ryanfood/Catbrunch/assets/163374121/fa1f4717-b1a3-4286-943d-45f83dc34b02)


## 技術細節
此專案使用了以下技術：
- **前端**：HTML, CSS, JavaScript, Bootstrap 5, JQuery
- **後端**：Java, Spring boot
- **資料庫**：MySQL
- **視圖**：Google Charts
- **架構**：MVC (Model-View-Controller), 包括 Controller, Service, DAO
- **安全性**：
  - CAPTCHA 驗證碼防止機器人攻擊
  - SHA-256 密碼加鹽防止彩虹表攻擊

## 網站架構
- **前臺**：用戶可以瀏覽和選擇餐點、查看最新活動資訊等
- **後臺**：管理員可以新增、修改、刪除菜單和活動，查看訂單明細，使用 Google Charts 分析銷售數據

## RWD響應式設計
網站設計為響應式，可在手機、平板和桌機上流暢使用。

## 安裝
請按照以下步驟安裝和配置此專案：

```bash
# 克隆此存儲庫
git clone https://github.com/username/repo.git

# 進入專案目錄
cd repo

# 安裝依賴
npm install
