package webqq;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;

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
	String friend;
	JSONObject friend_json =null;
	ResultSet rs;
	DbProcess db = new DbProcess();
	
	private static int onlineCount = 0;
	
	private static HashMap<String,WebSocket> webSocketMap = new HashMap<String,WebSocket>(); //id websocket
	
	private static  HashMap<String,String> idMap = new HashMap<String,String>(); //session.id id
	
	private static  HashMap<String,String> nameMap = new HashMap<String,String>(); //session.id name
	Boolean flag1 = true;
	Boolean flag2 = false;
	

	@OnOpen
	public void onOpen (@PathParam("id") String id,Session session) {
		this.session = session;
		this.id = id;
		this.queryAvatarAndFriend();
		webSocketMap.put(id, this);
		idMap.put(session.getId(),id);
		onlineCount++;
		System.out.println("id:"+id);
		if(!friend.equals("null")) {
			friend_json = JSONObject.fromObject(friend);
			Iterator  iterator = friend_json.keys();
		    while(iterator.hasNext()){
		    	String key = (String) iterator.next();
		    	String table;
				if(id.compareTo(key)<0) {
					table=id+"_"+key;
				}else {
					table=key+"_"+id;
				}
				this.queryMessage(table);	
		    }
		}
		this.queryMessage("grouptext");
		flag2 = true;
	}

	@OnMessage
	public void onMessage(String message,Session session) {
		WebSocket client = null;
		if(flag1&&flag2) {
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
				flag1 = false;
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
				if(!flag2) {
					try {
						session.getBasicRemote().sendText(message);
						System.out.println("服务端下发消息成功");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}else {
					for(String webSocketKey:webSocketMap.keySet()) {
						client=webSocketMap.get(webSocketKey);
						try {
							client.session.getBasicRemote().sendText(message);
							System.out.println("服务端下发消息成功");
						} catch (IOException e) {
							e.printStackTrace();
						}
						}
					this.insertMessage("grouptext", message);
				}
			}else {
				receive = receive.substring(0, receive.length()-4);
				String send = json_send_id.getString("id");
				if(friend_json==null) {
					if(receive.equals(id)) {
						friend = "{\""+send+"\":\"1\"}";
					}else {
						friend = "{\""+receive+"\":\"1\"}";
					}
					friend_json = JSONObject.fromObject(friend);
					this.creatTable(send, receive);
				}else if(friend_json.getString(id).equals("null")) {
					friend_json.put(id, "1");
					this.creatTable(send, receive);
				}
				if(flag2) {
					String table;
					if(send.compareTo(receive)<0) {
						table=send+"_"+receive;
					}else {
						table=receive+"_"+send;
					}
					try {
						webSocketMap.get(receive).session.getBasicRemote().sendText(message);
						webSocketMap.get(send).session.getBasicRemote().sendText(message);
					} catch (IOException e) {
						e.printStackTrace();
					}
					this.insertMessage(table,message);
				}else {
					try {
						session.getBasicRemote().sendText(message);
					} catch (IOException e) {
						e.printStackTrace();
					}
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
		this.insertFriend();
		
	}
	
	
	public void queryAvatarAndFriend() {
		db.connect();
		sql = "select avatar,friend from user where id = "+id+";";
		rs = db.executeQuery(sql);
		try {
			while(rs.next()) {
				avatar = rs.getString("avatar");
				if(avatar.equals("null")) {
					avatar = "img/a.png";
				}
				friend = rs.getString("friend");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			db.disconnect();
		}
		db.disconnect();
	}
	
	public String creatTable(String send,String receive){
		String table;
		if(send.compareTo(receive)<0) {
			table=send+"_"+receive;
		}else {
			table=receive+"_"+send;
		}
		sql = "create table "+table+"(" + 
				"message mediumtext" + 
				") ENGINE=InnoDB DEFAULT CHARSET=gbk;";
		db.connect();
		if(db.executeUpdate(sql)==0) {
			System.out.println("建表成功");
		}
		db.disconnect();
		return table;
	}
	
	
	public void insertMessage(String table,String message) {
		sql = "insert into "+table+" values('"+message+"');";
		db.connect();
		if(db.executeUpdate(sql)==1) {
			System.out.println("插入消息记录成功");
		}
		db.disconnect();
	}
	
	public void queryMessage(String table) {
		sql = "select * from "+table+";";
		db.connect();
		rs=db.executeQuery(sql);
		try {
			while(rs.next()) {
				String message=rs.getString("message");
				this.onMessage(message, session);
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			db.disconnect();
		}
		System.out.println("查询历史记录成功");
		db.disconnect();
	}
	
	
	
	public void insertFriend() {
		sql = "update user set friend = '"+friend+"';";
		db.connect();
		if(db.executeUpdate(sql)==1) {
			System.out.println("插入最近联系人成功");
		}
		db.disconnect();
	}
	
}
