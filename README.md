# 貓貓早午餐 CatBrunch

![CatBrunch Logo](https://github.com/Ryanfood/Catbrunch/src/main/resources/static/img/Logo/logo.png)

## 簡介
貓貓早午餐是一個結合美食分享和貓咪愛好者的早午餐網站。你可以在這裡品嘗美味的早午餐，並欣賞可愛貓咪的趣味故事和照片。

## 動機與目的
此專案的靈感來自於我對美食和貓咪的熱愛，旨在創建一個能分享美食並為愛貓人士提供交流的平台。

## 功能
- 分享美味的早午餐
- 展示貓咪的趣味故事和照片
- 愛貓人士的交流平台

## 技術細節
此專案使用了以下技術：
- **前端**：HTML, JavaScript, Bootstrap 5, CSS
- **後端**：Java, Spring Framework
- **資料庫**：ER Model
- **視圖**：Google Charts
- **架構**：MVC (Model-View-Controller), 包括 Controller, Service, DAO
- **安全性**：
  - CAPTCHA 驗證碼防止機器人攻擊
  - SHA-256 密碼加鹽防止彩虹表攻擊

## 系統架構
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
