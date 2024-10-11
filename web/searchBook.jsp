<%--
  Created by IntelliJ IDEA.
  User: DianjiYo
  Date: 2024/9/16
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索书籍</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #566C73;
            height: 100vh;
        }
        #search-book {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        #search-book h1 {
            color: #333;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            width: 100%;
        }
        select, button {
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 16px;
            color: #333;
        }
        select {
            background-color: #fafafa;
        }
        button.but {
            background-color: #4CAF50;
            border: none;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button.but:hover {
            background-color: #45a049;
        }
        .return-home {
            display: inline-block; /* 使链接表现得像一个块级元素 */
            padding: 10px 20px; /* 添加一些内边距 */
            font-size: 16px; /* 设置字体大小 */
            color: #fff; /* 设置文字颜色 */
            background-color: #007bff; /* 设置背景颜色 */
            text-decoration: none; /* 去除下划线 */
            border-radius: 5px; /* 设置边角的圆角 */
            transition: background-color 0.3s; /* 添加背景颜色变化的过渡效果 */
        }

        .return-home:hover {
            background-color: #0056b3; /* 鼠标悬停时的背景颜色 */
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
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div id="search-book">
    <h1>搜索书籍</h1>
    <form method="post" action="BookServlet?action=searchByType">
        <select name="btype" required>
            <option value="">--选择类型--</option>
            <option value="文学类">文学类</option>
            <option value="科技类">科技类</option>
            <option value="社会科学类">社会科学类</option>
            <option value="艺术类">艺术类</option>
            <option value="教育类">教育类</option>
        </select>
        <button class="but" type="submit">搜索</button>
    </form>
</div>
<div class="container">
    <c:if test="${empty booktype}">
        <p>没有找到匹配的图书类型：${btype}。</p>
    </c:if>
    <form action="SaleServlet?action=buyBook" method="POST">
        <c:forEach var="book" items="${booktype}" varStatus="status">
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
</body>
</html>