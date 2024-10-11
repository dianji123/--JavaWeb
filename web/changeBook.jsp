<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>修改图书</title>
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
        input[type="number"] {
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=changeList" class="return-home">返回列表</a>
<div class="container">
    <h1>修改书籍</h1>
    <form id="editForm" action="BookServlet?action=changeBook" method="POST" onsubmit="return confirmSubmit()">
        <input type="hidden" name="bid" value="${oneBook.bid}" />
        <table>
            <tr>
                <th>书名</th>
                <th>价格</th>
                <th>库存</th>
                <th>操作</th>
            </tr>
            <tr>
                <td>${oneBook.bname}</td>
                <td><input type="number" name="bprice" value="${oneBook.bprice}" step="any" required /></td>
                <td><input type="number" name="bstock" value="${oneBook.bstock}" required /></td>
                <td><button type="submit" class="button edit">提交修改</button></td>
            </tr>
        </table>
    </form>
</div>
<script>
    function confirmSubmit() {
        return confirm("确定要提交修改吗？");
    }
</script>
</body>
</html>