package webqq;

import java.sql.ResultSet;

public class SetUserinfo {
	
	String id = null;
	String name = null;
	String avatar = null;
	String sql = null;
	ResultSet rs = null;
	DbProcess db = new DbProcess();
	


	public SetUserinfo(String id,String avatar,String name) {
		this.id=id;
		this.avatar=avatar;
		this.name=name;
		update();
	}
	//更新用户信息
	public void update() {
		db.connect();
		sql = "update user set avatar = '"+avatar+"',name = '"+name+"' where id = '"+id+"';";
		int i = db.executeUpdate(sql);
		db.disconnect();
		if(i == 1) {
			System.out.println("更新信息成功");
		}
	}
	

}
