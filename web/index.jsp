<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>网上书店系统</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }
    header {
      background-color: #333;
      color: #fff;
      padding: 10px 20px;
      text-align: center;
    }
    nav {
      display: flex;
      justify-content: space-around;
      background-color: #444;
      padding: 10px 0;
    }
    nav a, .dropdown .dropbtn {
      color: #fff;
      text-decoration: none;
      padding: 5px 15px;
      display: block;
    }
    nav a:hover, .dropdown .dropbtn:hover {
      background-color: #555;
    }
    .dropdown {
      position: relative;
      display: inline-block;
    }
    .dropdown .dropbtn {
      padding: 5px 15px;
    }
    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f9f9f9;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
    }
    .dropdown-content a {
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }
    .dropdown-content a:hover {
      background-color: #f1f1f1;
    }
    .dropdown:hover .dropdown-content {
      display: block;
    }
    .container {
      width: 90%;
      margin: 40px auto;
      display: flex;
      flex-wrap: wrap; /* 允许项目换行 */
      justify-content: flex-start; /* 从行的开始位置对齐项目 */
    }
    .book {
      background-color: #fff;
      border: 1px solid #ddd;
      margin: 10px;
      padding: 20px;
      width: calc(25% - 20px); /* 每行显示4本书，所以宽度是容器宽度的25%减去20px的间隔 */
      box-sizing: border-box; /* 包括padding和border在内的宽度计算 */
      float: left; /* 使书籍从左到右排列 */
    }
    .book h3 {
      margin: 10px 0;
    }
    .book p {
      margin: 5px 0;
    }
    .book button {
      background-color: #5cb85c;
      color: white;
      border: none;
      padding: 10px 20px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin: 4px 2px;
      cursor: pointer;
    }
    .book button:hover {
      background-color: #4cae4c;
    }
    .footer {
      background-color: #333;
      color: #fff;
      text-align: center;
      padding: 10px 0;
      position: fixed;
      bottom: 0;
      width: 100%;
    }
  </style>
</head>
<body>
<header>
  <h1>欢迎来到网上书店系统</h1>
</header>
<nav>
  <a href="${pageContext.request.contextPath}/BookServlet?action=list">主页</a>
  <a href="searchBook.jsp">搜索</a>
  <c:choose>
    <c:when test="${not empty sessionScope.username}">
      <!-- 如果用户已登录，显示用户名 -->
      <div class="dropdown">
        <a href="javascript:void(0);" class="dropbtn">${sessionScope.username}</a>
        <div class="dropdown-content">
          <a href="${pageContext.request.contextPath}/UserServlet?action=user">个人中心</a>
          <a href="addBook.jsp">添加图书</a>
          <a href="${pageContext.request.contextPath}/BookServlet?action=changeList">管理图书</a>
          <a href="saleManage.jsp">售卖管理</a>
          <a href="${pageContext.request.contextPath}/UserServlet?action=manage">用户管理</a>
          <a href="${pageContext.request.contextPath}/UserServlet?action=logout">退出登录</a>
        </div>
      </div>
    </c:when>
    <c:otherwise>
      <!-- 如果用户未登录，显示登录和注册链接 -->
      <a href="login.jsp">登录</a>
      <a href="userCreate.jsp">注册</a>
    </c:otherwise>
  </c:choose>
</nav>
<div class="container">
  <form action="SaleServlet?action=buyBook" method="POST">
    <c:forEach var="book" items="${books}" varStatus="status">
      <div class="book">
        <h3>${book.bname}</h3>
        <p>类型: ${book.btype}</p>
        <p>价格: ${book.bprice}元</p>
        <input type="hidden" name="bid[${status.index}]" value="${book.bid}">
        <input type="hidden" name="bname[${status.index}]" value="${book.bname}">
        <input type="hidden" name="bprice[${status.index}]" value="${book.bprice}">
        <input type="hidden" name="btype[${status.index}]" value="${book.btype}">
        <input type="hidden" name="bstock[${status.index}]" value="${book.bstock}">
        <input type="hidden" name="bsale[${status.index}]" value="${book.bsale}">
        <input type="hidden" name="bdesc[${status.index}]" value="${book.bdesc}">
        <button type="submit" name="buyButton" value="${status.index}">购买</button>
      </div>
    </c:forEach>
  </form>
</div>
<div class="footer">
  <p>版权所有 © 2024 网上书店系统</p>
</div>
</body>
</html>