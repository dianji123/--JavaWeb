<%--
  Created by IntelliJ IDEA.
  User: DianjiYo
  Date: 2024/9/16
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>留言信息</title>
    <style>

        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #566C73;
            margin: 0;
        }
        #messages {
            list-style-type: none;
            padding: 0;
            margin: 0;
            width: 60%; /* 设置留言板的宽度 */
            margin-left: auto; /* 自动边距 */
            margin-right: auto; /* 自动边距，这将使留言板居中 */
        }
        #messages li {
            background-color: #fff;
            border: 1px solid #cad9ea;
            margin-bottom: 10px;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
        }
        #messages li strong {
            color: #4CAF50;
            display: block; /* 使用户名独占一行 */
            margin-bottom: 5px; /* 在用户名和消息之间添加一些空间 */
        }
        #messages li:nth-child(even) {
            background-color: #f9f9f9; /* 为偶数留言设置不同的背景颜色 */
        }
        /* 设置滚动条样式 */
        #messages::-webkit-scrollbar {
            width: 12px; /* 滚动条宽度 */
        }
        #messages::-webkit-scrollbar-track {
            background-color: #f1f1f1; /* 滚动条轨道颜色 */
        }
        #messages::-webkit-scrollbar-thumb {
            background-color: #888; /* 滚动条颜色 */
            border-radius: 6px; /* 滚动条圆角 */
        }
        #messages::-webkit-scrollbar-thumb:hover {
            background-color: #555; /* 滚动条悬停颜色 */
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
    <ul id="messages">
        <!-- 留言显示区域 -->
        <c:choose>
            <c:when test="${empty messages}">
                <li>暂无评论</li>
            </c:when>
            <c:otherwise>
                <c:forEach var="message" items="${messages}">
                    <li><strong>${message.uname}</strong>  ${message.message}</li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
</body>
</html>
