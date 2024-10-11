<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加图书</title>
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
        #add-book {
            position: absolute;
            top: 50%;
            left: 50%;
            margin: -270px 0 0 -250px; /* Adjusted margin to match new width */
            width: 450px; /* Reduced width */
            height: auto;
        }
        #add-book h1 {
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
        input, select, textarea, button {
            width: 100%;
            margin-bottom: 10px;
            outline: none;
            padding: 10px;
            font-size: 13px;
            color: #fff;
            border: 1px solid #312E3D;
            border-radius: 4px;
            background-color: #2D2D3F;
            box-sizing: border-box; /* Ensure padding is included in width */
        }
        select {
            -webkit-appearance: none; /* Remove default styling for WebKit browsers */
            -moz-appearance: none; /* Remove default styling for Mozilla browsers */
            appearance: none;
            background: #2D2D3F url('data:image/svg+xml;utf8,<svg fill="%23ffffff" height="30" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>') no-repeat right 10px center; /* Add custom arrow */
            cursor: pointer;
        }
        .but {
            background-color: #4a77d4;
            border: 1px solid #3762bc;
            color: #fff;
            padding: 9px 14px;
            font-size: 15px;
            line-height: normal;
            border-radius: 5px;
            cursor: pointer;
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
<div id="add-book">
    <h1>添加图书</h1>
    <form method="post" action="BookServlet?action=add">
        <input type="text" required="required" placeholder="书名" name="bname"></input>
        <input type="text" required="required" placeholder="单价" name="bprice"></input>
        <select name="btype" required="required">
            <option value="">--选择类型--</option>
            <option value="文学类">文学类</option>
            <option value="科技类">科技类</option>
            <option value="社会科学类">社会科学类</option>
            <option value="艺术类">艺术类</option>
            <option value="教育类">教育类</option>
            <!-- 更多类型 -->
        </select>
        <input type="number" min="0" required="required" placeholder="库存" name="bstock"></input>
        <textarea required="required" placeholder="描述" name="bdesc"></textarea>
        <button class="but" type="submit">添加图书</button>
    </form>
</div>
<script>
    window.onload = function() {
        if (${sessionScope.addSuccess}) {
            alert('添加图书成功！');
            // 清除 updateSuccess 属性
            document.cookie = "addSuccess=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "BookServlet?action=clearSuccess", true);
            xhr.send();
        }
    };
</script>
</body>
</html>