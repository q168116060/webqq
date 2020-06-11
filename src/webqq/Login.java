package webqq;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Login {

	String id = null;
	String name = null;
	String password = null;
	String avatar = null;
	String sql = null;
	ResultSet rs = null;
	DbProcess db = new DbProcess();
	
	public String getName() {
		return name;
	}
	
	//如果用户没有设置头像，返回默认头像
	public String getAvatar() {
		if(avatar.equals("null")) {
			return "img/a.png";
		}
		return avatar;
	}
	
	public Login(String id,String password) {
		this.id=id;
		this.password=password;
	}
	//查询用户是否存在
	public Boolean queryId() {
		db.connect();
		sql = "select id from user where id = '"+id+"';";
		rs = db.executeQuery(sql);
		try {
			rs.last();
			if(rs.getRow()==1) {
				db.disconnect();
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			db.disconnect();
			return false;
		}
		db.disconnect();
		return false;
	}
	
	//根据账号和密码查昵称，查到则登陆成功
	public Boolean queryName() {
		db.connect();
		sql = "select name , avatar from user where id = '"+id+"' AND password = '"+password+"';";
		rs = db.executeQuery(sql);
		try {
			while(rs.next()) {
				name=rs.getString("name");
				avatar=rs.getString("avatar");
			}
			rs.last();
			if(rs.getRow()==1) {
				db.disconnect();
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			db.disconnect();
			return false;
		}
		db.disconnect();
		return false;
		
	}
	


	
	
	
}
