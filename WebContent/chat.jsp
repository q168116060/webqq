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

#emojidiv {
	display: none;
	position: absolute;
	top: -105px;
	left: 82%;
	padding: 0px;
	border: 0px;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}

a {
	text-decoration: none;
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
		
		document.onkeydown = function(e){
			if(e.keyCode == 13){
				var box_ft=document.getElementsByClassName("box-ft")[0];
				var text_div = box_ft.getElementsByTagName("div")[0];
				if(text_div.id !=""){
					sendMessage();
				}
				e.preventDefault();
			}
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
				<li onclick="setdisplay(this)">
					<div>
						<img class="avatar" src="img/group.png" alt="" />
						<p class="message-name">群聊</p>
						<p class="message-content" id="groupmessage"></p>
					</div>
				</li>
				<li class="border"></li>
			</ul>
		</div>

		<div id="friend" class="list" style="display: none;">
			<div class="list-hd">
				<h3>在线联系人</h3>
			</div>
			<ul>
			</ul>
		</div>

		<div class="box" style="display: none;">
			<div id="main"></div>
			<div class="box-ft">
				<a href="JavaScript:void(0)" onclick="sendimage()"> <span
					id="fileico"></span>
				</a> <input type="file" id="imageFile" style="display: none" />
				<div class="text" contenteditable="true" id=""></div>
				<div>

					<div id="emojidiv">
						<table border="1">
							<tr>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😀</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😃</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😄</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😁</a></td>
							</tr>
							<tr>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😆</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😅</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">🤣</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😂</a></td>
							</tr>
							<tr>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">🙂</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">🙃</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😉</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😊</a></td>
							</tr>
							<tr>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😲</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😦</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😎</a></td>
								<td><a href="javascript:void(0)"
									onclick="insertemoji(this)">😌</a></td>
							</tr>
						</table>
					</div>
					<a href="JavaScript:void(0)" onclick="sendemoji()"> <span
						id="emojiico"></span>
					</a>
				</div>
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

		ws.onclose = function(){
			window.alert("您已掉线，请检查网络，重启客户端!");
		}
		
		ws.onmessage = function(message) {
			var json = JSON.parse(message.data);
			if (json.message[0].type == "0") {
				var box = document.getElementsByClassName("box")[0];
				var div = box.getElementsByTagName("div")[0];
				var div1 = document.getElementById("group");
				if (div1 == null) {
					div.innerHTML = div.innerHTML+"<div id=\"group\" class=\"chat\" style=\"display:none;\">\r\n" + 
					"<div class=\"box-hd\"><h3>群聊("+
					json.message[0].onlineCount+
							")</h3></div>\r\n" + 
					"<div class=\"box-bd\">\r\n" + 
					"</div>\r\n" + 
					"</div>";
				}else{
					var box_hd = div1.getElementsByClassName("box-hd")[0];
					var h3 = box_hd.getElementsByTagName("h3")[0];
					h3.innerHTML = "群聊("+json.message[0].onlineCount+")";
				}
				div1 = document.getElementById("group");
				var box_bd = div1.getElementsByClassName("box-bd")[0];
				box_bd.innerHTML = box_bd.innerHTML
						+ "<div class=\"system\"><p class=\"message_system\"><span class=\"content\">"
						+ json.message[0].message + "</span></p></div>";
				var message_list = document.getElementById("message");
				var message_list_li = message_list.getElementsByTagName("li")[0];
				var message_list_li_p = message_list_li
						.getElementsByClassName("message-content")[0];
				message_list_li_p.innerHTML = json.message[0].message;
				
				var friend_list = document.getElementById("friend");
				var friend_list_ul = friend_list.getElementsByTagName("ul")[0];
				for(var i=1;i<=json.message[0].onlineCount;i++){
					var id = json.message[i].id+"friend";
					if(document.getElementById(id) == null && json.message[i].id!=<%=request.getParameter("id")%>){
						friend_list_ul.innerHTML += "<li class=\"user\" onclick=\"creatdiv(this)\" id=\""+
						id+"\"><div><img class=\"avatar\" src=\"img/a.png\" alt=\"\"><p class=\"friend-name\">"+
						json.message[i].name+"</p></div></li>";
					}
				}
				setscroll(div1);
			}else if(json.message[0].type == "1"){
				if(json.message[0].receive == "grouptext"){
					var div = document.getElementById("group");
					var box_bd = div.getElementsByClassName("box-bd")[0];
					if(json.message[0].name == "<%=request.getParameter("name")%>"){
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\">\r\n" + 
						"<div class=\"my message\"><img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
						"<div class=\"content\"><div class=\"bubble\"><div class=\"bubble_cont\">"+
						json.message[0].message+
						"</div></div></div>\r\n" + 
						"</div></div>";
					}else{
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\"><div class=\"other message\"><img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
						"<div class=\"content\"><div class=\"nickname\">"+
						json.message[0].name+
						"</div><div class=\"bubble\"><div class=\"bubble_cont\">"+
						json.message[0].message+
						"</div></div></div></div></div>";
					}
					
					var message_list = document.getElementById("message");
					var message_list_li = message_list.getElementsByTagName("li")[0];
					var message_list_li_p = message_list_li
							.getElementsByClassName("message-content")[0];
					message_list_li_p.innerHTML = json.message[0].message;
					setscroll(div);
				}else {
					var receive = "<%=request.getParameter("id")%>"+"text";
					if(receive == json.message[0].receive){
						var box = document.getElementsByClassName("box")[0];
						var div = box.getElementsByTagName("div")[0];
						var div1 = document.getElementById(json.message[0].id+"div");
						if (div1 == null) {
							div.innerHTML = div.innerHTML+"<div id=\""+json.message[0].id+"div\" class=\"chat\" style=\"display:none;\">\r\n" + 
							"<div class=\"box-hd\"><h3>"+
							json.message[0].name+
									"</h3></div>\r\n" + 
							"<div class=\"box-bd\">\r\n" + 
							"</div>\r\n" + 
							"</div>";
						}
						var div1 = document.getElementById(json.message[0].id+"div");
						var box_bd = div1.getElementsByClassName("box-bd")[0];
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"othermessage\"><div><img class=\"avatar\" src=\"img/a.png\" /></div><div><div class=\"left-triangle\"></div><span>"
						+json.message[0].message+"</span></div>";
						
						var message_list_li_p = document.getElementById(json.message[0].id+"message");
						if(message_list_li_p == null){
							var message_list = document.getElementById("message");
							var message_list_ul = message_list.getElementsByTagName("ul")[0];
							message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n" + 
							"<img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
							"<p class=\"message-name\">"+
							json.message[0].name+"</p>\r\n" + 
							"<p class=\"message-content\" id=\""+
							json.message[0].id+"message\">"+
							json.message[0].message+"</p></div></li>";
						}else{
							message_list_li_p.innerHTML = json.message[0].message;
						}
						setscroll(div1);
						
					}else if(json.message[0].name=="<%=request.getParameter("name")%>"){
						var receive = json.message[0].receive;
						receive = receive.substring(0,receive.length-4);
						var div1 = document.getElementById(receive+"div");
						var box_bd = div1.getElementsByClassName("box-bd")[0];
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"mymessage\"><div><img class=\"avatar\" src=\"img/a.png\" /></div><div><div class=\"right-triangle\"></div><span>"
						+json.message[0].message+"</span></div>";
						
						var message_list_li_p = document.getElementById(receive+"message");
						if(message_list_li_p == null){
							var friend_list_li = document.getElementById(receive+"friend");
							var friend_list_li_p = friend_list_li.getElementsByClassName("friend-name")[0];
							var name = friend_list_li_p.innerHTML;
							var message_list = document.getElementById("message");
							var message_list_ul = message_list.getElementsByTagName("ul")[0];
							message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n" + 
							"<img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
							"<p class=\"message-name\">"+
							name+"</p>\r\n" + 
							"<p class=\"message-content\" id=\""+
							receive+"message\">"+
							json.message[0].message+"</p></div></li>";
						}else{
							message_list_li_p.innerHTML = json.message[0].message;
						}		
						setscroll(div1);
					}
					
				}
			}else if (json.message[0].type == "2") {
				var box = document.getElementsByClassName("box")[0];
				var div = box.getElementsByTagName("div")[0];
				var div1 = document.getElementById("group");
				if (div1 == null) {
					div.innerHTML = div.innerHTML+"<div id=\"group\" class=\"chat\" style=\"display:none;\">\r\n" + 
					"<div class=\"box-hd\"><h3>群聊("+
					json.message[0].onlineCount+
							")</h3></div>\r\n" + 
					"<div class=\"box-bd\">\r\n" + 
					"</div>\r\n" + 
					"</div>";
				}else{
					var box_hd = div1.getElementsByClassName("box-hd")[0];
					var h3 = box_hd.getElementsByTagName("h3")[0];
					h3.innerHTML = "群聊("+json.message[0].onlineCount+")";
				}
				div1 = document.getElementById("group");
				var box_bd = div1.getElementsByClassName("box-bd")[0];
				box_bd.innerHTML = box_bd.innerHTML
						+ "<div class=\"system\"><p class=\"message_system\"><span class=\"content\">"
						+ json.message[0].message + "</span></p></div>";
				var message_list = document.getElementById("message");
				var message_list_li = message_list.getElementsByTagName("li")[0];
				var message_list_li_p = message_list_li
						.getElementsByClassName("message-content")[0];
				message_list_li_p.innerHTML = json.message[0].message;
				
				var friend_list = document.getElementById("friend");
				var friend_list_ul = friend_list.getElementsByTagName("ul")[0];
				var id = json.message[1].id+"friend";
				var li = document.getElementById(id);
				if(li == null){
				}else{
					li.parentNode.removeChild(li);
				}
				setscroll(div1);

			}else if(json.message[0].type == "3"){
				if(json.message[0].receive == "grouptext"){
					var div = document.getElementById("group");
					var box_bd = div.getElementsByClassName("box-bd")[0];
					if(json.message[0].name == "<%=request.getParameter("name")%>"){
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\">\r\n" + 
						"<div class=\"my message\"><img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
						"<div class=\"content\"><div class=\"bubble\"><div class=\"bubble_cont\"><img src=\""+
						json.message[0].message+"\"/>"+
						"</div></div></div>\r\n" + 
						"</div></div>";
					}else{
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\"><div class=\"other message\"><img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
						"<div class=\"content\"><div class=\"nickname\">"+
						json.message[0].name+
						"</div><div class=\"bubble\"><div class=\"bubble_cont\"><img src=\""+
						json.message[0].message+"\"/>"+
						"</div></div></div></div></div>";
					}
					
					var message_list = document.getElementById("message");
					var message_list_li = message_list.getElementsByTagName("li")[0];
					var message_list_li_p = message_list_li
							.getElementsByClassName("message-content")[0];
					message_list_li_p.innerHTML = "[图片]";
					setscroll(div);
				}else {
					var receive = "<%=request.getParameter("id")%>"+"text";
					if(receive == json.message[0].receive){
						var box = document.getElementsByClassName("box")[0];
						var div = box.getElementsByTagName("div")[0];
						var div1 = document.getElementById(json.message[0].id+"div");
						if (div1 == null) {
							div.innerHTML = div.innerHTML+"<div id=\""+json.message[0].id+"div\" class=\"chat\" style=\"display:none;\">\r\n" + 
							"<div class=\"box-hd\"><h3>"+
							json.message[0].name+
									"</h3></div>\r\n" + 
							"<div class=\"box-bd\">\r\n" + 
							"</div>\r\n" + 
							"</div>";
						}
						var div1 = document.getElementById(json.message[0].id+"div");
						var box_bd = div1.getElementsByClassName("box-bd")[0];
						box_bd.innerHTML = box_bd.innerHTML+"<div class=\"othermessage\"><div><img class=\"avatar\" src=\"img/a.png\" /></div>"+
						"<div><div class=\"left-triangle\"></div><span><img style=\"max-width: 350px;max-height: 240px;\" src=\""+
						json.message[0].message+"\"/>"+"</span></div>";
						
						var message_list_li_p = document.getElementById(json.message[0].id+"message");
						if(message_list_li_p == null){
							var message_list = document.getElementById("message");
							var message_list_ul = message_list.getElementsByTagName("ul")[0];
							message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n" + 
							"<img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n" + 
							"<p class=\"message-name\">"+
							json.message[0].name+"</p>\r\n" + 
							"<p class=\"message-content\" id=\""+
							json.message[0].id+"message\">"+
							"[图片]"+"</p></div></li>";
						}else{
							message_list_li_p.innerHTML ="[图片]";
						}
						setscroll(div1);
						
					}else if(json.message[0].name == "<%=request.getParameter("name")%>") {
						var receive = json.message[0].receive;
						receive = receive.substring(0, receive.length - 4);
						var div1 = document.getElementById(receive + "div");
						var box_bd = div1.getElementsByClassName("box-bd")[0];
						box_bd.innerHTML = box_bd.innerHTML
								+ "<div class=\"mymessage\"><div><img class=\"avatar\" src=\"img/a.png\" /></div><div><div class=\"right-triangle\"></div><span><img style=\"max-width: 350px;max-height: 240px;\" src=\""+
								json.message[0].message+"\"/>"+ "</span></div>";

						var message_list_li_p = document.getElementById(receive
								+ "message");
						if (message_list_li_p == null) {
							var friend_list_li = document
									.getElementById(receive + "friend");
							var friend_list_li_p = friend_list_li
									.getElementsByClassName("friend-name")[0];
							var name = friend_list_li_p.innerHTML;
							var message_list = document
									.getElementById("message");
							var message_list_ul = message_list
									.getElementsByTagName("ul")[0];
							message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n"
									+ "<img class=\"avatar\" src=\"img/a.png\" alt=\"\" />\r\n"
									+ "<p class=\"message-name\">"
									+ name
									+ "</p>\r\n"
									+ "<p class=\"message-content\" id=\""+
							receive+"message\">"
									+ "[图片]"
									+ "</p></div></li>";
						} else {
							message_list_li_p.innerHTML = "[图片]";
						}
						setscroll(div1);
					}

				}
			}
		}

		function sendMessage() {
			var text = document.getElementsByClassName("text")[0];
			if (text.innerText != "") {
				var message = "{\"message\":[{\"type\":\"1\", \"message\":\""
						+ text.innerText + "\",\"name\":\"" + name
						+ "\",\"id\":\"" + id + "\",\"receive\":\"" + text.id
						+ "\"}]}";
				ws.send(message);
				text.innerHTML = "";
			}
		}

		function creatdiv(li) {
			var box = document.getElementsByClassName("box")[0];
			box.style = "display:block;";
			var div3 = document.getElementById("main");
			var div = document.getElementsByClassName("chat");
			for (var i = 0; i < div.length; i++) {
				div[i].style = "display:none;";
			}
			var li_id = li.id;
			var id = li_id.substring(0, li_id.length - 6);
			var div1 = document.getElementById(id + "div");
			if (div1 == null) {
				var p = li.getElementsByTagName("p")[0];
				div3.innerHTML = div3.innerHTML
						+ "<div id=\""+id+"div\" class=\"chat\" style=\"display:block;\">\r\n"
						+ "<div class=\"box-hd\"><h3>" + p.innerHTML
						+ "</h3></div>\r\n" + "<div class=\"box-bd\">\r\n"
						+ "</div>\r\n" + "</div>";
			} else {
				div1.style = "display:block;";
			}
			var box_ft = document.getElementsByClassName("box-ft")[0];
			var text_div = box_ft.getElementsByTagName("div")[0];
			text_div.id = id + "text";

		}

		function setdisplay(li) {
			var box = document.getElementsByClassName("box")[0];
			box.style = "display:block;";
			var div = document.getElementsByClassName("chat");
			for (var i = 0; i < div.length; i++) {
				div[i].style = "display:none;";
			}
			var p = li.getElementsByClassName("message-content")[0];
			var p_id = p.id;
			var id = p_id.substring(0, p_id.length - 7);
			var div1 = document.getElementById(id + "div");
			if (div1 == null) {
				div1 = document.getElementById("group");
			}
			div1.style = "display:block;";
			var box_ft = document.getElementsByClassName("box-ft")[0];
			var text_div = box_ft.getElementsByTagName("div")[0];
			text_div.id = id + "text";

		}

		function setscroll(div) {
			var box_bd = div.getElementsByClassName("box-bd")[0];
			box_bd.scrollTop = box_bd.scrollHeight - box_bd.offsetHeight;
		}

		function sendemoji() {
			document.getElementById('emojidiv').style.display = 'block';
		}
		function insertemoji(a) {
			document.getElementById('emojidiv').style.display = 'none';
			var text = document.getElementsByClassName("text")[0];
			text.innerHTML += a.innerHTML;
		}

		function sendimage() {
			document.getElementById("imageFile").click();
		}

		document.getElementById("imageFile").addEventListener("change",function() {
			if(this.value!=""){
				var reader = new FileReader();
				reader.readAsDataURL(this.files[0]);
				reader.onload = function() {
					var text = document.getElementsByClassName("text")[0];
					var message = "{\"message\":[{\"type\":\"3\", \"message\":\""
							+ reader.result
							+ "\",\"name\":\""
							+ name
							+ "\",\"id\":\""
							+ id
							+ "\",\"receive\":\""
							+ text.id
							+ "\"}]}";
					ws.send(message);
					document.getElementById("imageFile").value = "";
				}
			}

		})
	</script>
</body>
</html>