<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="webqq.SetUserinfo" %>
<!DOCTYPE html>
<html>
<head>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String avatar = request.getParameter("avatar");
String name = request.getParameter("name");
if(request.getParameter("id")==null){
%>
<script type="text/javascript">window.location.href='login.jsp'; </script>
<%
}
SetUserinfo set = new SetUserinfo(id,avatar,name);

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
	background: url(<%=avatar%>) center;
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

#blackground{ 
	display: none; 
	position: absolute; 
	top: 0%; 
	left: 0%; 
	width: 100%; 
	height: 100%; 
	background-color: black; 
	z-index:1001; 
	-moz-opacity: 0.8; 
	opacity:.80; 
	filter: alpha(opacity=88); 
} 
#picturediv{ 
	display: none; 
	position: absolute; 
	top: 10%; 
	left: 10%; 
	width: 80%; 
	height: 80%; 
	border: 0px; 
	z-index:1002; 
	text-align:center;

} 

a {
	text-decoration: none;
}
.red{
	border: 9px solid red;
	border-radius:9px;
	position: absolute;
	z-index: 1000;
	margin-left: 53px;
	margin-top: 8px;
}
</style>
<script type="text/javascript">
	window.onload = function() {
		var messageico = document.getElementById("messageico");
		var message = document.getElementById("message");
		var friendico = document.getElementById("friendico");
		var friend = document.getElementById("friend");
		<!--为消息图标注册点击事件，点击则显示消息列表-->
		messageico.onclick = function() {
			message.style.display = "block";
			friend.style.display = "none";

		}
		
		<!--为联系人图标注册点击事件，点击则显示在线列表-->
		friendico.onclick = function() {
			friend.style.display = "block";
			message.style.display = "none";

		}
		<!--为enter添加监听，实现enter键发消息-->
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
	
	<!--放大被点击的图片-->
	function large (a){
		document.getElementById("picturediv_img").src = a.src;
		document.getElementById("blackground").style="display:block;";
		document.getElementById("picturediv").style="display:block;";
	}
	
	<!--缩小图片-->
	function small (){
		document.getElementById("blackground").style="display:none;";
		document.getElementById("picturediv").style="display:none;";
	}
	
</script>
<meta charset="UTF-8">
<title>聊天界面</title>
</head>
<body>
<div id="blackground"></div> 
<div id="picturediv"><img id="picturediv_img" onclick="small()" style="max-width:100%;max-height:100%;" src=""></div>
	<div class="container">
		<!--个人信息显示，及交互按钮-->
		<div class="choose">
			<span id="userico"></span>
			<p id="myname"><%=request.getParameter("name")%></p>
			<a href="JavaScript:void(0)"><span id="messageico"></span></a>
			<a href="JavaScript:void(0)"><span id="friendico"></span></a>
		</div>
		<!--消息列表-->
		<div id="message" class="list" style="display: block;">
			<div class="list-hd">
				<h3>消息</h3>
			</div>
			<ul>
				<li onclick="setdisplay(this)">
					<div>
						<span class="red"></span><img class="avatar" src="img/group.png" alt="" />
						<p class="message-name">群聊</p>
						<p class="message-content" id="groupmessage"></p>
					</div>
				</li>
				<li class="border"></li>
			</ul>
		</div>
		
		<!--在线联系人列表-->
		<div id="friend" class="list" style="display: none;">
			<div class="list-hd">
				<h3>在线联系人</h3>
			</div>
			<ul>
			</ul>
		</div>
		<!--右侧聊天框-->
		<div class="box" style="display: none;">
			<div id="main"></div>
			<div class="box-ft" style="display:block;">
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
	<!--打开indexeddb-->
	var request = window.indexedDB.open('webqqMessage',1);
	var db;
	var ws;
	<!--indexeddb连接成功的回调-->
	request.onsuccess = function(event) {
		db = request.result;
		console.log("数据库打开成功");
		<!--查询聊天历史记录-->
		var requestMessage = db.transaction(["message"],"readwrite").objectStore("message").get("<%=request.getParameter("id")%>");
		<!--查询成功的回调-->
		requestMessage.onsuccess = function(e){
			if(requestMessage.result==undefined){

			}else{
				console.log(requestMessage.result);
				document.getElementById("message").innerHTML=requestMessage.result.message;
				document.getElementById("main").innerHTML=requestMessage.result.main;
			}
			<!--websocket链接-->
			ws = new WebSocket("ws://localhost:80/webqq/WebSocket/"+"<%=request.getParameter("id")%>");


			<!--连接成功的回调-->
			ws.onopen = function() {
				ws.send("<%=request.getParameter("name")%>");

			}
			<!--断开链接的回调-->
			ws.onclose = function(){
				window.alert("您已掉线，请检查网络，重启客户端!");
			}
			<!--收到信息的回调-->
			ws.onmessage = function(message) {
				<!--将消息解析成json对象，方便使用-->
				var json = JSON.parse(message.data);
				<!--消息为用户登录成功通知的系统消息的处理-->
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
						div1 = document.getElementById("group");
					}else{
						var box_hd = div1.getElementsByClassName("box-hd")[0];
						var h3 = box_hd.getElementsByTagName("h3")[0];
						h3.innerHTML = "群聊("+json.message[0].onlineCount+")";
					}
					var box_bd = div1.getElementsByClassName("box-bd")[0];
					box_bd.innerHTML = box_bd.innerHTML
							+ "<div class=\"system\"><p class=\"message_system\"><span class=\"content\">"
							+ json.message[0].message + "</span></p></div>";
					var message_list = document.getElementById("message");
					var message_list_li = message_list.getElementsByTagName("li")[0];
					var message_list_li_p = message_list_li
							.getElementsByClassName("message-content")[0];
					message_list_li_p.innerHTML = json.message[0].message;
					if(red("group")){
						var message_list_li_red = message_list_li.getElementsByClassName("red")[0];
						message_list_li_red.style="display:block;";
					}
					
					var friend_list = document.getElementById("friend");
					var friend_list_ul = friend_list.getElementsByTagName("ul")[0];
					for(var i=1;i<=json.message[0].onlineCount;i++){
						var id = json.message[i].id+"friend";
						if(document.getElementById(id) == null && json.message[i].id!="<%=request.getParameter("id")%>"){
							onLine(json.message[i].id);
							friend_list_ul.innerHTML += "<li class=\"user\" onclick=\"creatdiv(this)\" id=\""+
							id+"\"><div><img class=\"avatar\" src=\""+
							json.message[i].avatar+"\" alt=\"\"><p class=\"friend-name\">"+
							json.message[i].name+"</p></div></li>";
						}
					}
					
					
					setscroll(div1);
					<!--消息为用户发出的聊天消息的处理-->
				}else if(json.message[0].type == "1"){
					if(json.message[0].receive == "grouptext"){
						var div = document.getElementById("group");
						var box_bd = div.getElementsByClassName("box-bd")[0];
						if(json.message[0].name == "<%=request.getParameter("name")%>"){
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\">\r\n" + 
							"<div class=\"my message\"><img class=\"avatar\" src=\"<%=avatar%>\" />\r\n" + 
							"<div class=\"content\"><div class=\"bubble\"><div class=\"bubble_cont\">"+
							json.message[0].message+
							"</div></div></div>\r\n" + 
							"</div></div>";
						}else{
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\"><div class=\"other message\"><img class=\"avatar\" src=\""+
							getAvatarById(json.message[0].id)+"\"/>\r\n" + 
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
						if(red("group")){
							var message_list_li_red = message_list_li.getElementsByClassName("red")[0];
							message_list_li_red.style="display:block;";
						}
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
								
								var chatdiv = document.getElementsByClassName("chat");
								for (var i = 0; i < chatdiv.length; i++) {
									setscroll(chatdiv[i]);
								}
								div1 = document.getElementById(json.message[0].id+"div");
								
							}else{
								var h3 = div1.getElementsByClassName("box-hd")[0].getElementsByTagName("h3")[0];
								h3.innerText = json.message[0].name;
								
							}
							var box_bd = div1.getElementsByClassName("box-bd")[0];
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"othermessage\"><div><img class=\"avatar\" src=\""+
							getAvatarById(json.message[0].id)+"\" /></div><div><div class=\"left-triangle\"></div><span>"
							+json.message[0].message+"</span></div>";
							
							var message_list_li_p = document.getElementById(json.message[0].id+"message");
							if(message_list_li_p == null){
								var message_list = document.getElementById("message");
								var message_list_ul = message_list.getElementsByTagName("ul")[0];
								message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n" + 
								"<span class=\"red\"></span><img class=\"avatar\" src=\""+
								getAvatarById(json.message[0].id)+"\" />\r\n" + 
								"<p class=\"message-name\">"+
								json.message[0].name+"</p>\r\n" + 
								"<p class=\"message-content\" id=\""+
								json.message[0].id+"message\">"+
								json.message[0].message+"</p></div></li>";
							}else{
								message_list_li_p.parentNode.getElementsByTagName("p")[0].innerText = json.message[0].name;
								message_list_li_p.parentNode.getElementsByTagName("img")[0].src = getAvatarById(json.message[0].id);
								message_list_li_p.innerHTML = json.message[0].message;
							}
							if(red(json.message[0].id)){
								var message_list_li_red = document.getElementById(json.message[0].id+"message").parentNode.getElementsByClassName("red")[0];
								message_list_li_red.style="display:block;";
							}
							setscroll(div1);
							
						}else if(json.message[0].name=="<%=request.getParameter("name")%>"){
							var receive = json.message[0].receive;
							receive = receive.substring(0,receive.length-4);
							var div1 = document.getElementById(receive+"div");
							var box_bd = div1.getElementsByClassName("box-bd")[0];
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"mymessage\"><div><img class=\"avatar\" src=\""+
							"<%=avatar%>"
							+"\" /></div><div><div class=\"right-triangle\"></div><span>"
							+json.message[0].message+"</span></div>";
							
							var message_list_li_p = document.getElementById(receive+"message");
							if(message_list_li_p == null){
								var friend_list_li = document.getElementById(receive+"friend");
								var friend_list_li_p = friend_list_li.getElementsByClassName("friend-name")[0];
								var name = friend_list_li_p.innerHTML;
								var message_list = document.getElementById("message");
								var message_list_ul = message_list.getElementsByTagName("ul")[0];
								message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n" + 
								"<img class=\"avatar\" src=\""+
								getAvatarById(receive)+"\"/>\r\n" + 
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
					<!--消息为用户退出的系统消息的处理-->
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
					var message_list_li_red = message_list_li_p.parentNode.getElementsByClassName("red")[0];
					message_list_li_red.style="display:block;";
					var friend_list = document.getElementById("friend");
					var friend_list_ul = friend_list.getElementsByTagName("ul")[0];
					var id = json.message[1].id+"friend";
					var li = document.getElementById(id);
					if(li == null){
					}else{
						li.parentNode.removeChild(li);
					}
					offLine(json.message[1].id);
					if(red("group")){
						var message_list_li_red = message_list_li.getElementsByClassName("red")[0];
						message_list_li_red.style="display:block;";
					}
					setscroll(div1);
					<!--发送接受图片的处理-->
				}else if(json.message[0].type == "3"){
					if(json.message[0].receive == "grouptext"){
						var div = document.getElementById("group");
						var box_bd = div.getElementsByClassName("box-bd")[0];
						if(json.message[0].name == "<%=request.getParameter("name")%>"){
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\">\r\n" + 
							"<div class=\"my message\"><img class=\"avatar\" src=\"<%=avatar%>\" alt=\"\" />\r\n" + 
							"<div class=\"content\"><div class=\"bubble\"><div class=\"bubble_cont\"><img onclick=\"large(this)\" src=\""+
							json.message[0].message+"\"/>"+
							"</div></div></div>\r\n" + 
							"</div></div>";
						}else{
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"message-box\"><div class=\"other message\"><img class=\"avatar\" src=\""+
							getAvatarById(json.message[0].id)+"\"/>\r\n" + 
							"<div class=\"content\"><div class=\"nickname\">"+
							json.message[0].name+
							"</div><div class=\"bubble\"><div class=\"bubble_cont\"><img onclick=\"large(this)\" src=\""+
							json.message[0].message+"\"/>"+
							"</div></div></div></div></div>";
						}
						
						var message_list = document.getElementById("message");
						var message_list_li = message_list.getElementsByTagName("li")[0];
						var message_list_li_p = message_list_li
								.getElementsByClassName("message-content")[0];
						message_list_li_p.innerHTML = "[图片]";
						if(red("group")){
							var message_list_li_red = message_list_li.getElementsByClassName("red")[0];
							message_list_li_red.style="display:block;";
						}
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
								div1 = document.getElementById(json.message[0].id+"div");
							}else{
								var h3 = div1.getElementsByClassName("box-hd")[0].getElementsByTagName("h3")[0];
								h3.innerText = json.message[0].name;
								
							}
							var box_bd = div1.getElementsByClassName("box-bd")[0];
							box_bd.innerHTML = box_bd.innerHTML+"<div class=\"othermessage\"><div><img class=\"avatar\" src=\""+
							getAvatarById(json.message[0].id)+"\" /></div>"+
							"<div><div class=\"left-triangle\"></div><span><img onclick=\"large(this)\" style=\"max-width: 350px;max-height: 240px;\" src=\""+
							json.message[0].message+"\"/>"+"</span></div>";
							
							var message_list_li_p = document.getElementById(json.message[0].id+"message");
							if(message_list_li_p == null){
								var message_list = document.getElementById("message");
								var message_list_ul = message_list.getElementsByTagName("ul")[0];
								message_list_ul.innerHTML += "<li class=\"user\" onclick=\"setdisplay(this)\"><div>\r\n" + 
								"<span class=\"red\"></span><img class=\"avatar\" src=\""+
								getAvatarById(json.message[0].id)+"\"/>\r\n" + 
								"<p class=\"message-name\">"+
								json.message[0].name+"</p>\r\n" + 
								"<p class=\"message-content\" id=\""+
								json.message[0].id+"message\">"+
								"[图片]"+"</p></div></li>";
							}else{
								message_list_li_p.parentNode.getElementsByTagName("p")[0].innerText = json.message[0].name;
								message_list_li_p.parentNode.getElementsByTagName("img")[0].src = getAvatarById(json.message[0].id);
								message_list_li_p.innerHTML ="[图片]";
							}
							message_list_li_p = document.getElementById(json.message[0].id+"message");
							if(red(json.message[0].id)){
								var message_list_li_red = message_list_li_p.parentNode.getElementsByClassName("red")[0];
								message_list_li_red.style="display:block;";
							}

							setscroll(div1);
							
						}else if(json.message[0].name == "<%=request.getParameter("name")%>") {
							var receive = json.message[0].receive;
							receive = receive.substring(0, receive.length - 4);
							var div1 = document.getElementById(receive + "div");
							var box_bd = div1.getElementsByClassName("box-bd")[0];
							box_bd.innerHTML = box_bd.innerHTML
									+ "<div class=\"mymessage\"><div><img class=\"avatar\" src=\""+
									"<%=avatar%>"
									+"\" /></div><div><div class=\"right-triangle\"></div><span><img onclick=\"large(this)\" style=\"max-width: 350px;max-height: 240px;\" src=\""+
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
										+ "<img class=\"avatar\" src=\""+
										getAvatarById(receive)+"\"/>\r\n"
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
				savemessage();
			}
			

		}
	}
	
	<!--数据库不存在时，建表的回调-->
	request.onupgradeneeded = function (event){
		db = event.target.result;
		var objectStore;
		if(!db.objectStoreNames.contains("message")){
			objectStore = db.createObjectStore("message",{keyPath:"id"});
		}
		console.log("建表成功");
	}
	<!--存聊天记录进入数据库的方法-->
	function savemessage() {
		var id = "<%=request.getParameter("id")%>";
		var message = document.getElementById("message").innerHTML;
		var main = document.getElementById("main").innerHTML;
		var data = new Object();
		data.id = id;
		data.message = message;
		data.main = main;
		console.log(data);
		db.transaction(["message"],"readwrite").objectStore("message").put(data);
		console.log("保存成功");
	}
	
		<!--发消息的方法-->
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
		<!--点击在线联系人，创建聊天窗口的方法-->
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
		<!--点击别的联系人或者消息时，将当前聊天框隐藏的方法，将被点击的显示出来-->
		function setdisplay(li) {
			var message_list_li_red = li.getElementsByClassName("red")[0];
			if(message_list_li_red!=null){
				message_list_li_red.style="display:none;";	
			}
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
				div1.style = "display:block;";
				var box_ft = document.getElementsByClassName("box-ft")[0];
				box_ft.style = "display:block;";
				var text_div = box_ft.getElementsByTagName("div")[0];
				text_div.id = id + "text";
			}else if(findFriend(id)){
				div1.style = "display:block;";
				var box_ft = document.getElementsByClassName("box-ft")[0];
				box_ft.style = "display:block;";
				var text_div = box_ft.getElementsByTagName("div")[0];
				text_div.id = id + "text";
			}else{
				window.alert("对方不在线，暂不可对其发消息");
				div1.style = "display:block;";
				var box_ft = document.getElementsByClassName("box-ft")[0];
				box_ft.style = "display:none;";
				var text_div = box_ft.getElementsByTagName("div")[0];
				text_div.id = id + "text";
			}
			setscroll(div1);

		}
		<!--接收到消息，滚动条跟随消息自动下拉的方法-->
		function setscroll(div) {
			var box_bd = div.getElementsByClassName("box-bd")[0];
			box_bd.scrollTop = box_bd.scrollHeight - box_bd.offsetHeight;
		}
		<!--发表情，掉出表情选择表格的方法-->
		function sendemoji() {
			document.getElementById('emojidiv').style.display = 'block';
		}
		<!--将选择的表情显示到输入框的方法-->
		function insertemoji(a) {
			document.getElementById('emojidiv').style.display = 'none';
			var text = document.getElementsByClassName("text")[0];
			text.innerHTML += a.innerHTML;
		}
		<!--调出文件选择窗口的方法-->
		function sendimage() {
			document.getElementById("imageFile").click();
		}
		<!--文件选择框内容发生变化，发送图片的方法-->
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
		<!--通过账号从在线联系人中获取头像的方法-->
		function getAvatarById(id){
			id=id+"friend";
			var li = document.getElementById(id);
			var img = li.getElementsByClassName("avatar")[0];
			return img.src;
			
		}
		<!--根据账号查询联系人在不在的方法-->
		function findFriend(id){
			id=id+"friend";
			var li = document.getElementById(id);
			if(li==null){
				return false;
			}
			return true;
			
		}
		<!--正在聊天的时候，对方下线，隐藏输入框的方法-->
		function offLine(id){
			var box_ft = document.getElementsByClassName("box-ft")[0];
			var text_id = box_ft.getElementsByClassName("text")[0].id;
			var text_id = text_id.substring(0,text_id.length-4);
			if(id==text_id){
				box_ft.style="display:none;";
				window.alert("对方已离线，暂不可对其发消息！");
			}
		}
		<!--对方上线，显示输入框的方法-->
		function onLine(id){
			var box_ft = document.getElementsByClassName("box-ft")[0];
			var text_id = box_ft.getElementsByClassName("text")[0].id;
			var text_id = text_id.substring(0,text_id.length-4);
			
			if(id==text_id){
				box_ft.style="display:block;";
				window.alert("对方已上线，可对其发消息了！");
			}
		}
		<!--判断是否显示未读消息红点-->
		function red(id){
			var box_ft = document.getElementsByClassName("box-ft")[0];
			var text_id = box_ft.getElementsByClassName("text")[0].id;
			var text_id = text_id.substring(0,text_id.length-4);
			
			if(id==text_id){
				return false;
			}else{
				return true;
			}
		}
	</script>
</body>
</html>