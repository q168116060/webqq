package webqq;

import java.io.IOException;
import java.util.HashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint(value="/WebSocket")
public class WebSocket {

	private Session session;
	private String userName;
	
	private static final HashMap<String,WebSocket> connectMap = new HashMap<String,WebSocket>();
	
	private static final HashMap<String,String> userMap = new HashMap<String,String>();
	
	

	@OnOpen
	public void start(Session session) {
		this.session = session;
		connectMap.put(session.getId(), this);
	}

	@OnMessage
	public void chat(String clientMessage,Session session) {
		WebSocket client = null;
		this.userName = clientMessage;
		userMap.put(session.getId(),userName);
		String message = "系统消息"+userName+"进入聊天室";
		System.out.print(message);
		for(String connectKey:connectMap.keySet()) {
			client = connectMap.get(connectKey);
			try {
				client.session.getBasicRemote().sendText(message);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
