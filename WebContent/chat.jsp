<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
			<span id="userico"></span> <span id="messageico"></span> <span
				id="friendico"></span>
		</div>

		<div id="message" class="list" style="display: none;">
			<div class="list-hd">
				<h3>消息</h3>
			</div>
			<ul>
			    <li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="message-name">111</p><p class="message">12312</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="message-name">111</p><p class="message">12312</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="message-name">111</p><p class="message">12312</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="message-name">111</p><p class="message">12312</p></div>
				</li>
			</ul>
		</div>

		<div id="friend" class="list" style="display: block;">
			<div class="list-hd">
				<h3>在线联系人</h3>
			</div>
			<ul>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">1</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">2</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">3</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">4</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">5</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">6</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">7</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">8</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">9</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">10</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">11</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">12</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">13</p></div>
				</li>
				<li class="user">
					<div><img class="avatar" src="img/a.png" alt="" /><p class="friend-name">14</p></div>
				</li>

			</ul>
		</div>


		<div class="box">
			<div class="box-hd">
				<h3>
					公共聊天(<span>99</span>)
				</h3>
			</div>
			<div class="box-bd">
			
			
			
			<div class="system">
                <p class="message_system">111</p>
              </div>
                <div class="mymessage">
                  <img class="avatar" src="img/a.png" alt="" />
                    <div class="bubble">
                      <div class="bubble_cont">11112111</div>
                    </div>
                  </div>
                <div class="othermessage">
                  <img class="avatar" src="img/a.png" alt="" />
                   <div class="chatname">22</div>
                    <div class="bubble">
                      <div class="bubble_cont">22222</div>
                    </div>
                  </div>
   
			
			
			
			</div>
			
			<div class="box-ft">
				<span id="fileico"></span>
				<div class="text" contenteditable></div>
				<span id="emojiico"></span>
				<button id="sendBtn">发送</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var wsUrl = "ws://localhost:8080/webqq/WebSocket";
		var ws = new WebSocket(wsUrl);

		ws.onopen = function() {

		}

		ws.onmessage = function(message) {

		}
	</script>
</body>
</html>