package webqq;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


import net.sf.json.JSONObject;


@ServerEndpoint(value="/WebSocket/{id}")
public class WebSocket {

	private Session session;
	
	String name;
	String id;
	String avatar;
	String sql;
	ResultSet rs;
	DbProcess db = new DbProcess();
	
	
	private static HashMap<String,WebSocket> webSocketMap = new HashMap<String,WebSocket>(); //id websocket
	
	private static  HashMap<String,String> idMap = new HashMap<String,String>(); //session.id id
	
	private static  HashMap<String,String> nameMap = new HashMap<String,String>(); //session.id name
	Boolean flag = true;
	
//连接成功时调用，存储用户的id，session，头像
	@OnOpen
	public void onOpen (@PathParam("id") String id,Session session) {
		this.session = session;
		this.id = id;
		this.queryAvatar();
		webSocketMap.put(id, this);
		idMap.put(session.getId(),id);
		System.out.println("id:"+id);
	}
//收到消息是调用，将收到的消息，根据发送者和接收者进行有甄别的分发
	@OnMessage
	public void onMessage(String message,Session session) {
		WebSocket client = null;
		//初次收到用户的消息时处理逻辑，即系统通知用户登录成功的处理
		if(flag) {
			this.name = message;
			nameMap.put(session.getId(), name);
			String sendMessage="{\"message\":[{\"type\":\"0\", \"message\":\""+name
					+"进入群聊\",\"onlineCount\":\""+webSocketMap.size()+"\"}";
			for(String webSocketKey:webSocketMap.keySet()) {
				client=webSocketMap.get(webSocketKey);
				sendMessage = sendMessage + 
						", {\"name\":\""+client.name+
						"\", \"avatar\":\""+client.avatar+
						"\", \"id\":\""+client.id+"\"}";
				}
			sendMessage = sendMessage + "]}";
			System.out.println(sendMessage);
			for(String webSocketKey:webSocketMap.keySet()) {
			client=webSocketMap.get(webSocketKey);
			try {
				client.session.getBasicRemote().sendText(sendMessage);
				flag = false;
				System.out.println("服务端下发消息成功");
			} catch (IOException e) {
				e.printStackTrace();
			}

			}
		}else {
			//对群消息的处理，发给所有人
			String[] strArr = message.split(",");
			String receive_id = strArr[strArr.length-1];
			String send_id = strArr[strArr.length-2];
			receive_id = receive_id.split("]")[0];
			receive_id = "{"+receive_id;
			JSONObject json_receive_id = JSONObject.fromObject(receive_id);
			send_id="{"+send_id+"}";
			JSONObject json_send_id = JSONObject.fromObject(send_id);
			String receive = json_receive_id.getString("receive");
			System.out.println(message);
			if(receive.equals("grouptext")) {
				for(String webSocketKey:webSocketMap.keySet()) {
				client=webSocketMap.get(webSocketKey);
				try {
					client.session.getBasicRemote().sendText(message);
					System.out.println("服务端下发消息成功");
				} catch (IOException e) {
					e.printStackTrace();
				}

				}
			}else {
				//对私聊消息的处理，只发给发送者和接收者
				receive = receive.substring(0, receive.length()-4);
				String send = json_send_id.getString("id");
				try {
					webSocketMap.get(receive).session.getBasicRemote().sendText(message);
					webSocketMap.get(send).session.getBasicRemote().sendText(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
				System.out.println("服务端下发消息成功,"+send+"发给"+receive);
			}
		}

	}
	
	//连接发送错误的处理方法
	
	@OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        error.printStackTrace();
    }
	
	
	//连接关闭的处理方法，将用户退出的通知发给在线的人
	@OnClose
	public void onclose() {
		webSocketMap.remove(id);
		nameMap.remove(session.getId());
		idMap.remove(session.getId());
		WebSocket client = null;
		String sendMessage="{\"message\":[{\"type\":\"2\", \"message\":\""+
		name+"退出群聊\",\"onlineCount\":\""+webSocketMap.size()+"\"}, {\"name\":\""+name+"\", \"id\":\""+id+"\"}]}";
		System.out.println(sendMessage);
		for(String webSocketKey:webSocketMap.keySet()) {
		client=webSocketMap.get(webSocketKey);
		try {
			client.session.getBasicRemote().sendText(sendMessage);
			System.out.println("服务端下发消息成功");
		} catch (IOException e) {
			e.printStackTrace();
		}

		}
		
	}
	
	//根据账号查询头像
	public void queryAvatar() {
		db.connect();
		sql = "select avatar from user where id = '"+id+"';";
		rs = db.executeQuery(sql);
		try {
			while(rs.next()) {
				avatar=rs.getString("avatar");
				if(avatar.equals("null")) {
					avatar = "img/a.png";
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			db.disconnect();
		}
		db.disconnect();
		
	}
}
