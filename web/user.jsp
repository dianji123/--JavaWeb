<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户信息</title>
    <style>
        html {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        body {
            width: 100%;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            background-color: #566C73;
        }
        #user-form {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            padding: 20px;
            background-color: #383838;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }
        h1 {
            color: #fff;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }
        form > div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            color: #bbb;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: auto;
            max-width: 280px;
            font-size: 13px;
            color: #fff;
            border: 1px solid #56536A;
            border-radius: 4px;
            background-color: #2D2D3F;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            border: none;
            color: #fff;
            font-size: 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
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
            margin-bottom: 20px;
        }
        .return-home:hover {
            background-color: #0056b3;
        }
        input:invalid {
            border: 2px solid red;
        }
        .validation-error {
            color: red;
            font-size: 0.8em;
            margin-top: 3px;
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div id="user-form">
    <h1>用户信息</h1>
    <form action="UserServlet?action=change" method="post">
        <div>
            <label for="username">用户名</label>
            <input type="text" id="username" name="uname" value="${userinfo[0].uname}" required minlength="3" maxlength="20" pattern="[a-zA-Z0-9_]{3,20}" title="用户名应为3-20位字母、数字或下划线">
            <span class="validation-error" id="username-error"></span>
        </div>
        <div>
            <label for="password">密码</label>
            <input type="password" id="password" name="upassword" placeholder="请输入密码" required minlength="6" maxlength="20" pattern=".{6,20}" title="密码长度应在6-20位之间">
            <span class="validation-error" id="password-error"></span>
        </div>
        <div>
            <label for="age">年龄</label>
            <input type="number" id="age" name="uage" value="${userinfo[0].uage}" required min="0" max="200" pattern="[0-9]{1,3}" title="请输入正确的年龄">
            <span class="validation-error" id="age-error"></span>
        </div>
        <div>
            <label for="phone">电话</label>
            <input type="tel" id="phone" name="uphone" value="${userinfo[0].uphone}" required pattern="(1[3-9]\d{9})|(0\d{2,3}-\d{7,8})" title="电话号码格式不正确">
            <span class="validation-error" id="phone-error"></span>
        </div>
        <button type="submit">确认修改</button>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var inputs = document.querySelectorAll('form input[required]');
        inputs.forEach(function(input) {
            input.addEventListener('input', function() {
                if (input.validity.patternMismatch) {
                    var errorSpan = document.getElementById(input.id + '-error');
                    errorSpan.textContent = input.title;
                } else {
                    var errorSpan = document.getElementById(input.id + '-error');
                    errorSpan.textContent = '';
                }
            });
        });
    });
</script>
<script>
    window.onload = function() {
        if (${sessionScope.updateSuccess}) {
            alert('修改成功！');
            // 清除 updateSuccess 属性
            document.cookie = "updateSuccess=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "UserServlet?action=clearSuccess", true);
            xhr.send();
        }
    };
</script>

</body>
</html>