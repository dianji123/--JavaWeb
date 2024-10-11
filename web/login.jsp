<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户登录</title>
    <style>
        html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            /*font-style: sans-serif;*/
        }
        body {
            width: 100%;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            background-color: #566C73;
        }
        #login {
            position: absolute;
            top: 50%;
            left: 50%;
            margin: -150px 0 0 -150px;
            width: 300px;
            height: 200px;
        }
        #login h1 {
            color: #fff;
            font-size: 35px;
            text-shadow: 0 0 10px;
            letter-spacing: 1px;
            text-align: center;
        }
        h1 {
            font-size: 2em;
            margin: 0.67em 0;
        }
        input {
            width: 278px;
            height: 18px;
            margin-bottom: 10px;
            outline: none;
            padding: 10px;
            font-size: 13px;
            color: #fff;
            border-top: 1px solid #312E3D;
            border-left: 1px solid #312E3D;
            border-right: 1px solid #312E3D;
            border-bottom: 1px solid #56536A;
            border-radius: 4px;
            background-color: #2D2D3F;
        }
        .but {
            width: 300px;
            min-height: 20px;
            display: block;
            background-color: #4a77d4;
            border: 1px solid #3762bc;
            color: #fff;
            padding: 9px 14px;
            font-size: 15px;
            line-height: normal;
            border-radius: 5px;
            margin: 0 0 10px 0;
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
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div id="login">
    <h1>用户登录</h1>
    <form method="post" action="UserServlet?action=login">
        <input type="text" required="required" placeholder="用户名" name="uname"></input>
        <input type="password" required="required" placeholder="密码" name="upassword"></input>
        <button class="but" type="submit">登录</button>
        <button class="but" type="button" onclick="location.href='userCreate.jsp'">注册</button>
    </form>
</div>
</body>
</html>