<%--
  Created by IntelliJ IDEA.
  User: DianjiYo
  Date: 2024/9/16
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户管理</title>
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
        table {
            border-collapse: collapse;
            margin: 0 auto;
            text-align: center;
            width: 100%;
        }
        table td, table th {
            border: 1px solid #cad9ea;
            color: #666;
            height: 30px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        table thead th {
            background-color: #CCE8EB;
            min-width: 100px;
        }
        table tr:nth-child(odd) {
            background: #fff;
        }
        table tr:nth-child(even) {
            background: #F5FAFA;
        }
        .delete-button {
            padding: 5px 10px;
            background-color: #f44336;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-button:hover {
            background-color: #e53935;
        }
        .annotation {
            font-size: 0.8em;
            color: #aaa;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回首页</a>
<div id="manage">
    <h1>用户管理</h1>
    <table>
        <tr>
            <th>用户名</th>
            <th>年龄</th>
            <th>电话号码</th>
            <th>删除</th>
        </tr>
        <c:forEach var="deleteduser" items="${deletedUserList}">
            <tr>
                <td>${deleteduser.uname}</td>
                <td>${deleteduser.uage}</td>
                <td>${deleteduser.uphone}</td>
                <td><button class="delete-button" onclick="if(confirm('确定删除此用户吗？')) location.href='UserServlet?action=deleteduser&deleteuid=${deleteduser.uid}'">删除</button></td>
            </tr>
        </c:forEach>
        <tr class="annotation">
            <td colspan="4">表内用户为已注销用户</td>
        </tr>
    </table>
</div>
<script>
    window.onload = function() {
        if (${sessionScope.deleteSuccess}) {
            alert('删除成功！');
            // 清除 deleteSuccess 属性
            document.cookie = "deleteSuccess=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "UserServlet?action=clearSuccess", true);
            xhr.send();
        }
    };
</script>
</body>
</html>