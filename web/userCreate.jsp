<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户注册</title>
</head>
<style>
    html{
        width: 100%;
        height: 100%;
        overflow: hidden;
        /*font-style: sans-serif;*/
    }
    body{
        width: 100%;
        height: 100%;
        font-family: 'Open Sans',sans-serif;
        margin: 0;
        background-color: #566C73;
    }
    #login{
        position: absolute;
        top: 50%;
        left:50%;
        margin: -225px 0 0 -150px;
        width: 300px;
        height: 300px;
    }
    #login h1{
        color: #fff;
        font-size: 35px;
        text-shadow:0 0 10px;
        letter-spacing: 1px;
        text-align: center;
    }
    h1{
        font-size: 2em;
        margin: 0.67em 0;
    }
    label {
        display: block;
        color: #bbb;
        margin-bottom: 5px;
    }
    input{
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
    .but{
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
<body>
<a href="${pageContext.request.contextPath}/BookServlet?action=list" class="return-home">返回主页</a>
<div id="login">
    <h1>用户注册</h1>
    <form method="post" action="UserServlet?action=usercreate">
        <div>
            <label for="uname">用户名</label>
            <input type="text" id="uname" name="uname" required minlength="3" maxlength="10" placeholder="用户名" pattern="[a-zA-Z0-9_]{3,10}" title="用户名应为3-10位字母、数字或下划线">
            <span class="validation-error" id="uname-error"></span>
        </div>
        <div>
            <label for="upassword">密码</label>
            <input type="password" id="upassword" name="upassword" required placeholder="密码" pattern=".{6,20}" title="密码长度应在6-20位之间">
            <span class="validation-error" id="upassword-error"></span>
        </div>
        <div>
            <label for="uage">年龄</label>
            <input type="number" id="uage" name="uage" required placeholder="年龄" min="0" max="200" pattern="[0-9]{1,3}" title="请输入正确的年龄">
            <span class="validation-error" id="uage-error"></span>
        </div>
        <div>
            <label for="uphone">电话</label>
            <input type="tel" id="uphone" name="uphone" required placeholder="电话" pattern="(1[3-9]\d{9})|(0\d{2,3}-\d{7,8})" title="电话号码格式不正确">
            <span class="validation-error" id="uphone-error"></span>
        </div>
        <button class="but" type="submit">注册</button>
        <button class="but" type="button" onclick="location.href='login.jsp'">返回登录</button>
    </form>
</div>
</body>
</html>