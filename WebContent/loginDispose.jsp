<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="webqq.Login" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/login.css" />
<style type="text/css">
div{
height:430px;
}
span{
	display:inline-block;
	width:150px;
	height:150px;
	border-radius:50%;
	margin-top:-10px;
	margin-left:115px;
	background:url(img/a.png) center;
	background-size:cover;
	}
</style>
<meta charset="UTF-8">
<title>登录处理界面</title>
</head>
<body>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
Login login = new Login(id,password);
if(login.queryId()){
	if(login.queryName()){
		String name = login.getName();
		%>
		<div>
		<h3>登录成功</h3>
		<span></span>
		<h3><%=name%></h3>
		<form action="chat.jsp" method="post">
		<input type="hidden" name="id" value=<%=id%>>
		<input type="hidden" name="name" value=<%=name %>>
		<input type="hidden" name="password" value=<%=password%>>
		<input class="button" type="submit" value="开始聊天">
		</form>
		</div>
		<%
	}else{
		%>
		<div>
		<h3>密码错误！</h3>
		<form action="login.jsp">
		<input type="hidden" name="id" value=<%=id%>>
		<input type="hidden" name="password" value=<%=password%>>
		<input class="button" type="submit" value="重新登录">
		</form>
		</div>
		<%
	}
}else{
	%>
	<div>
	<h3>用户不存在！</h3>
	<form action="login.jsp">
	<input type="hidden" name="id" value=<%=id%>>
	<input type="hidden" name="password" value=<%=password%>>
	<input class="button" type="submit" value="重新登录">
	</form>
	</div>
	<%
}

%>
</body>
</html>