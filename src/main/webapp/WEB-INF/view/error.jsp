<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>錯誤頁面</title>
</head>
<body>
    <h1>發生錯誤</h1>
    <p>對不起，請求處理過程中發生錯誤。</p>
    <p>錯誤信息：${exception.message}</p>
</body>
</html>
