<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<link rel="stylesheet" href="css/chat.css" />
<style type="text/css">
#userico {
	display: inline-block;
	width: 60px;
	height: 60px;
	border-radius: 50%;
	margin-top: 10px;
	margin-left: 10px;
	background: url(img/a.png) center;
	background-size: cover;
}
</style>
<script type="text/javascript">
	window.onload = function() {
		
		var messageico = document.getElementById("messageico");
		var message = document.getElementById("message");
		var friendico = document.getElementById("friendico");
		var friend = document.getElementById("friend");
		messageico.onclick = function() {
			message.style.display = "block";
			friend.style.display = "none";

		}

		friendico.onclick = function() {
			friend.style.display = "block";
			message.style.display = "none";

		}
		
	}
</script>
<meta charset="UTF-8">
<title>聊天界面</title>
</head>
<body>
	<div class="container">
		<div class="choose">
			<span id="userico"></span>
			<p id="myname"><%=request.getParameter("name")%></p>
			<span id="messageico"></span> <span id="friendico"></span>
		</div>

		<div id="message" class="list" style="display: block;">
			<div class="list-hd">
				<h3>消息</h3>
			</div>
			<ul>
				<li>
					<div>
						<img class="avatar" src="img/group.png" alt="" />
						<p class="message-name">群聊</p>
						<p class="message-content"></p>
					</div>
				</li>
				<li class="border"></li>

				<li class="user">
					<div>
						<img class="avatar" src="img/a.png" alt="" />
						<p class="message-name">111</p>
						<p class="message-content">12312</p>
					</div>
				</li>

			</ul>
		</div>

		<div id="friend" class="list" style="display: none;">
			<div class="list-hd">
				<h3>在线联系人</h3>
			</div>
			<ul>
				<li class="user">
					<div>
						<img class="avatar" src="img/a.png" alt="" />
						<p class="friend-name">1</p>
					</div>
				</li>

			</ul>
		</div>

		<div class="box">
			<div></div>
			<div class="box-ft">
				<span id="fileico"></span>
				<div class="text" contenteditable="true" id="" ></div>
				<span id="emojiico"></span>
				<button id="sendBtn" onclick="sendMessage()">发送</button>
			</div>
		</div>

	</div>


	<script type="text/javascript">
var id = "<%=request.getParameter("id")%>";
var name = "<%=request.getParameter("name")%>"
var ws = new WebSocket("ws://localhost:8080/webqq/WebSocket/"+id);

		ws.onopen = function() {
			ws.send("<%=request.getParameter("name")%>");
		}

		ws.onmessage = function(message) {
			var json = JSON.parse(message.data);
			if (json.name == "系统消息") {
				var box = document.getElementsByClassName("box")[0];
				var div = box.getElementsByTagName("div")[0];
				var div1 = document.getElementById("group");
				if (div1 == null) {
					div.innerHTML = div.innerHTML+"<div id=\"group\" display=\"block\">\r\n" + 
					"<div class=\"box-hd\"><h3>群聊()</h3></div>\r\n" + 
					"<div class=\"box-bd\">\r\n" + 
					"</div>\r\n" + 
					"</div>"
				}
				var div1 = document.getElementById("group");
				var box_bd = div1.getElementsByClassName("box-bd")[0];
				box_bd.innerHTML = box_bd.innerHTML
						+ "<div class=\"system\"><p class=\"message_system\"><span class=\"content\">"
						+ json.message + "</span></p></div>"
				var message_list = document.getElementById("message");
				var message_list_li = message_list.getElementsByTagName("li")[0];
				var message_list_li_p = message_list_li
						.getElementsByClassName("message-content")[0];
				message_list_li_p.innerHTML = json.message;

			}else{
				if(json.receive == "group"){
					var div = document.getElementById("group");
					var box_bd = div.getElementsByClassName("box-bd")[0];
					if(json.name == name){
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\">\r\n" + 
						"<div class=\"my message\"><img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
						"<div class=\"content\"><div class=\"bubble\"><div class=\"bubble_cont\">"+
						json.message+
						"</div></div></div>\r\n" + 
						"</div></div>"
					}else{
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\"><div class=\"other message\"><img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
						"<div class=\"content\"><div class=\"nickname\">"+
						json.name+
						"</div><div class=\"bubble\"><div class=\"bubble_cont\">"+
						json.message+
						"</div></div></div></div></div>"
					}
				}else{
					alert("点对点信息");
				}
			}

		}

		function sendMessage() {
			var text = document.getElementsByClassName("text")[0];
			text.id="group";
			var message = "{\"name\":\""+name+"\",\"message\":\""+text.innerHTML+"\",\"receive\":\""+text.id+"\"}";
			ws.send(message);
			text.innerHTML="";
		}
	</script>
</body>
</html>