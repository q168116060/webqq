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
	
	private static int onlineCount = 0;
	
	private static HashMap<String,WebSocket> webSocketMap = new HashMap<String,WebSocket>(); //id websocket
	
	private static  HashMap<String,String> idMap = new HashMap<String,String>(); //session.id id
	
	private static  HashMap<String,String> nameMap = new HashMap<String,String>(); //session.id name
	Boolean flag = true;
	

	@OnOpen
	public void onOpen (@PathParam("id") String id,Session session) {
		this.session = session;
		this.id = id;
		this.queryAvatar();
		webSocketMap.put(id, this);
		idMap.put(session.getId(),id);
		onlineCount++;
		System.out.println("id:"+id);
	}

	@OnMessage
	public void onMessage(String message,Session session) {
		WebSocket client = null;
		if(flag) {
			this.name = message;
			nameMap.put(session.getId(), name);
			String sendMessage="{\"message\":[{\"type\":\"0\", \"message\":\""+name
					+"进入群聊\",\"onlineCount\":\""+onlineCount+"\"}";
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
	
	@OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        error.printStackTrace();
    }
	
	@OnClose
	public void onclose() {
		webSocketMap.remove(id);
		nameMap.remove(session.getId());
		idMap.remove(session.getId());
		onlineCount--;
		WebSocket client = null;
		String sendMessage="{\"message\":[{\"type\":\"2\", \"message\":\""+
		name+"退出群聊\",\"onlineCount\":\""+onlineCount+"\"}, {\"name\":\""+name+"\", \"id\":\""+id+"\"}]}";
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
	
	
	public void queryAvatar() {
		db.connect();
		sql = "select avatar from user where id = "+id+";";
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
