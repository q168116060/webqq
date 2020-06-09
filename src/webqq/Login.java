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
	
	public Boolean queryId() {
		db.connect();
		sql = "select id from user where id = "+id+";";
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
