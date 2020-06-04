package webqq;

import java.io.IOException;
import java.util.HashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint(value="/WebSocket/{id}")
public class WebSocket {

	private Session session;
	
	private String name;
	
	private String id;
	
	private int onlineCount = 0;
	
	private static HashMap<String,WebSocket> webSocketMap = new HashMap<String,WebSocket>();
	
	private static  HashMap<String,String> userMap = new HashMap<String,String>();
	
	Boolean flag = true;
	

	@OnOpen
	public void OnOpen (@PathParam("id") String id,Session session) {
		this.session = session;
		this.id = id;
		webSocketMap.put(id, this);
		onlineCount++;
		System.out.println("id:"+id);
	}

	@OnMessage
	public void OnMessage(String message,Session session) {
		WebSocket client = null;
		if(flag) {
			this.name = message;
			userMap.put(id, name);
			String sendMessage="{\"name\":\"系统消息\",\"message\":\""+name+"加入群聊\"}";
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
			System.out.println(message);
			for(String webSocketKey:webSocketMap.keySet()) {
			client=webSocketMap.get(webSocketKey);
			try {
				client.session.getBasicRemote().sendText(message);
				System.out.println("服务端下发消息成功");
			} catch (IOException e) {
				e.printStackTrace();
			}

			}
			
			
		}

	}
	
}
