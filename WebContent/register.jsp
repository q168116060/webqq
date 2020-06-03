<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="webqq.Register" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/login.css" />
<style type="text/css">
div{
height:200px;
}
</style>
<meta charset="UTF-8">
<% request.setCharacterEncoding("utf-8"); %>
<title>注册处理页面</title>
</head>
<body>
<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String password = request.getParameter("password");
System.out.print(id+name+password);
Register register = new Register(id,name,password);
Boolean i = register.insert();
if(i){
%>
<div style="display: block;">
<h3>注册成功！</h3>
<form action="login.jsp" method="post">
<input type="hidden" name="id" value=<%=id%>>
<input type="hidden" name="password" value=<%=password%>>
<input class="button" type="submit" value="返回登录">
</form>
</div>
<%
}else{
%>
<script type="text/javascript">alert("用户名已被注册！");</script>
<div style="display: block;">
<h3>注册失败！</h3>
<form action="register.html">
<input class="button" type="submit" value="重新注册">
</form>
</div>
<%
}
%>
</body>
</html>