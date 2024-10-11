<%--
  Created by IntelliJ IDEA.
  User: DianjiYo
  Date: 2024/9/16
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>售卖管理</title>
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #566C73;
            margin: 0;
        }
        #manage {
            width: 100%;
            max-width: 1000px;
            margin: auto;
            text-align: center;
            padding-top: 50px;
        }
        .return-home {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-bottom: 20px;
        }
        .return-home:hover {
            background-color: #0056b3;
        }
        table
        {
            border-collapse: collapse;
            margin: 0 auto;
            text-align: center;
            width: 100%;
        }
        table td, table th
        {
            border: 1px solid #cad9ea;
            color: #666;
            height: 30px;
        }
        table thead th
        {
            background-color: #CCE8EB;
            width: 100px;
        }
        table tr:nth-child(odd)
        {
            background: #d9d9d9;
        }
        table tr:nth-child(even)
        {
            background: #F5FAFA;
        }

    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div id="manage">
    <h1>售卖管理</h1>
    <button class="return-home" onclick="location.href='${pageContext.request.contextPath}/SaleServlet?action=saleList'">售卖记录</button>
</div>

<c:if test="${not empty saleList}">
    <div id="manage">
        <table>
            <tr>
                <th>用户名</th>
                <th>书籍名</th>
                <th>数量</th>
                <th>单价(元)</th>
                <th>总额(元)</th>
            </tr>
            <c:forEach var="sale" items="${saleList}">
                <tr>
                    <td>${sale.uname}</td>
                    <td>${sale.bname}</td>
                    <td>${sale.scount}</td>
                    <td>${sale.bprice}</td>
                    <td><fmt:formatNumber type="number" value="${sale.scount * sale.bprice}" minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

</body>
</html>