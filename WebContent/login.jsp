<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/login.css" />
<style type="text/css">
#loginBtn{
margin: 30px auto 20px auto;
}
</style>
<meta charset="UTF-8">
<title>登录页面</title>
</head>
<body>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
if(id == null){
	id = "";
}
if(password == null){
	password = "";
}
%>
<div style="display: block;">
<h3>用户登录</h3>
<form action="" onsubmit="return check();">
<input class="text" type="text" placeholder="用户名" id="id" name="id" maxlength='11' value=<%=id%>>
<input class="text" type="password" placeholder="密码" id="password" name="password" maxlength='11' value=<%=password%>>
<input class="button" id="loginBtn" type='submit' value='登录'></input>
</form>
<form action="register.html"><input class="button" type="submit" value="注册"></form>
</div>

<script type="text/javascript">
function check() {
	var id = document.getElementById("id").value;
	var password = document.getElementById("password").value;
	if(id == "") {
		alert("账号不能为空!");
		return false;
	} else if(password == "") {
		alert("密码不能为空!");
		return false;
	} 
	return true;
}
</script>
</body>
</html>