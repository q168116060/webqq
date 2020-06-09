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
.fail{
height:180px;
}
img{
	display:inline-block;
	width:150px;
	height:150px;
	border-radius:50%;
	margin-top:-10px;
	margin-left:115px;
	background-size:cover;
}
a {
	text-decoration: none;
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
		String avatar = login.getAvatar();
		%>
		<div>
		<h3>登录成功</h3>
		<a href="JavaScript:void(0)" onclick="setAvatar()">
		<input type="file" id="imageFile" style="display: none" />
		<img src="<%=avatar%>">
		</a>
		<a href="JavaScript:void(0)">
		<h3 contenteditable="true"><%=name%></h3>
		</a>
		<form action="chat.jsp" method="post" onsubmit="return check();">
		<input type="hidden" name="id" value=<%=id%>>
		<input type="hidden" id="name" name="name" value=<%=name %>>
		<input type="hidden" name="password" value=<%=password%>>
		<input type="hidden" id="avatar" name="avatar" value=<%=avatar%>>
		<input class="button" type="submit" value="开始聊天">
		</form>
		</div>
		<%
	}else{
		%>
		<div class="fail">
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
	<div class="fail">
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
<script type="text/javascript">
function setAvatar() {
	document.getElementById("imageFile").click();
}

document.getElementById("imageFile").addEventListener("change",function() {
	var reader = new FileReader();
	reader.readAsDataURL(this.files[0]);
	reader.onload = function() {
		var img = document.getElementsByTagName("img")[0];
		img.src = reader.result;
		var input = document.getElementById("avatar");
		input.value = reader.result;
	}

})

function check(){
	var h3 = document.getElementsByTagName("h3")[1];
	var name = h3.innerText;
	
	if(name == "") {
		alert("昵称不能为空!");
		h3.innerText = "<%=login.getName() %>";
		return false;
	}
	document.getElementById("name").value = name;
	return true;
}

</script>
</body>
</html>