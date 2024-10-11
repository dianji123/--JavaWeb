<%--
Created by IntelliJ IDEA.
User: DianjiYo
Date: 2024/9/16
Time: 14:28
To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>购买书籍</title>
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
        input, button {
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #cad9ea;
        }
        button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
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

        /*留言板*/
        #messageBoard {
            margin: 30px auto;
            padding: 20px;
            max-width: 600px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #messageBoard h2 {
            color: #4CAF50;
        }
        #messageBoard ul {
            list-style-type: none;
            padding: 0;
        }
        #messageBoard li {
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #cad9ea;
        }
        #messageForm label {
            display: block;
            margin-top: 10px;
        }
        #messageForm input[type="text"],
        #messageForm textarea {
            width: 95%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #cad9ea;
        }
        #messageForm textarea {
            height: 100px;
        }
        #messageForm button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        #messageForm button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div id="manage">
    <h1>购买书籍</h1>
    <form id="orderForm" action="SaleServlet?action=bookSale" method="POST">
        <table>
            <tr>
                <th>书名</th>
                <th>单价(元)</th>
                <th>种类</th>
                <th>库存</th>
                <th>售出</th>
                <th>描述</th>
                <th>购买数量</th>
                <th>总额</th>
            </tr>
            <tr>
                <td>${buyBook.bname}</td>
                <td>${buyBook.bprice}</td>
                <td>${buyBook.btype}</td>
                <td>${buyBook.bstock}</td>
                <td>${buyBook.bsale}</td>
                <td>${buyBook.bdesc}</td>
                <td>
                    <input type="number" id="scount" name="scount" min="1" max="${buyBook.bstock}" value="1" onchange="updateTotal()">
                </td>
                <td id="total">0元</td>
            </tr>
        </table>
        <input type="hidden" name="bid" value="${buyBook.bid}">
        <input type="hidden" name="bname" value="${buyBook.bname}">
        <input type="hidden" name="bprice" value="${buyBook.bprice}">
        <input type="hidden" name="btype" value="${buyBook.btype}">
        <input type="hidden" name="bstock" value="${buyBook.bstock}">
        <input type="hidden" name="bsale" value="${buyBook.bsale}">
        <input type="hidden" name="bdesc" value="${buyBook.bdesc}">
        <button type="button" onclick="submitOrder()">提交订单</button>
    </form>
</div>

<%--<!-- 留言板区域 -->--%>
<%--<div id="messageBoard">--%>
<%--    <h2>留言板</h2>--%>
<%--    <form id="messageForm" action="MessageServlet?action=addMessage" method="POST">--%>
<%--        <label for="content">留言:</label>--%>
<%--        <textarea id="content" name="message" required minlength="1" maxlength="200"></textarea>--%>
<%--        <button type="submit">留言</button>--%>
<%--    </form>--%>
<%--    <ul id="messages">--%>
<%--        <!-- 留言显示区域 -->--%>
<%--        <c:forEach var="message" items="${messages}">--%>
<%--            <li><strong>${message.uname}</strong>: ${message.message}</li>--%>
<%--        </c:forEach>--%>
<%--    </ul>--%>
<%--</div>--%>
<!-- 留言板区域 -->
<div id="messageBoard">
    <h2>留言板</h2>
    <form id="messageForm" action="MessageServlet?action=addMessage" method="post">
        <label for="content">留言:</label>
        <textarea id="content" name="message" required minlength="1" maxlength="200"></textarea>
        <button type="submit">留言</button>
    </form>

    <button class="return-home" onclick="location.href='${pageContext.request.contextPath}/MessageServlet?action=getMessageList'">查看留言</button>
</div>

<script>
    var price = ${buyBook.bprice}; // 单价
    var stock = ${buyBook.bstock}; // 库存

    function updateTotal() {
        var scount = document.getElementById('scount').value; // 购买数量
        if(scount <= 0 || scount > stock) {
            alert('购买数量必须大于0且不超过库存数量！');
            document.getElementById('scount').value = 1; // 重置数量为1
            // document.getElementById('total').innerText = '0元'; // 重置总额
            updateTotal();
        } else {
            var total = price * scount; // 计算总额
            document.getElementById('total').innerText = total.toFixed(2) + '元'; // 显示总额
        }
    }

    function submitOrder() {
        updateTotal();
        var scount = document.getElementById('scount').value;
        if(scount <= 0 || scount > stock) {
            alert('购买数量必须大于0且不超过库存数量！');
            setTimeout(updateTotal, 0); // 递归调用以更新总额
            return false; // 阻止提交
        } else {
            document.getElementById('orderForm').submit();
        }
    }

    window.onload = function() {
        // 页面加载完成后立即更新总额
        // 只有当库存大于0时，才调用updateTotal函数
        if (stock > 0) {
            updateTotal();
        } else {
            alert("该书已售罄，请等待管理员补货");
            location.href = "${pageContext.request.contextPath}/BookServlet?action=list";
        }
    };

</script>
</body>
</html>
