<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>管理书籍</title>
    <style>
        body {
            width: 100%;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            background-color: #566C73;
        }
        .container {
            width: 90%;
            margin: 20px auto;
            overflow: hidden;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .button {
            padding: 8px 15px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .edit {
            background-color: #4CAF50;
            color: white;
        }
        .delete {
            background-color: #f44336;
            color: white;
        }
        .button:hover {
            opacity: 0.8;
        }
        h1 {
            text-align: center;
            color: #51aae7;
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
        }

        .return-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div class="container">
    <h1>所有书籍</h1>
    <table>
        <tr>
            <th>书名</th>
            <th>类型</th>
            <th>价格</th>
            <th>库存</th>
            <th>售出</th>
            <th>描述</th>
            <th>操作</th>
        </tr>
        <c:forEach var="book" items="${books}">
            <tr>
                <td>${book.bname}</td>
                <td>${book.btype}</td>
                <td>${book.bprice}</td>
                <td>${book.bstock}</td>
                <td>${book.bsale}</td>
                <td>${book.bdesc}</td>
                <td>
                    <button class="button edit" onclick="change(${book.bid})">修改</button>
                    <button class="button delete" onclick="confirmDelete(${book.bid})">删除</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    function change(bid) {
        window.location.href = "BookServlet?action=change&bid=" + bid;
    }

    function confirmDelete(bid) {
        if (confirm("确定要删除这本书吗？")) {
            // 发送删除请求到服务器
            window.location.href = "BookServlet?action=delete&bid=" + bid;
        }
    }
</script>
</body>
</html>