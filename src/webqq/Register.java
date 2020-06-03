package webqq;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Register {

	String id = null;
	String name = null;
	String password = null;
	String sql = null;
	ResultSet rs = null;
	DbProcess db = new DbProcess();
	
	public Register(String id,String name,String password) {
		this.id=id;
		this.name=name;
		this.password=password;
	}
	public Boolean queryId() {
		sql = "select id from user where id = "+id+";";
		db.connect();
		rs = db.executeQuery(sql);
		try {
			rs.last();
			if(rs.getRow()==0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			db.disconnect();
			return false;
		}
		return false;
	}
	
	
	public Boolean insert() {
		if(this.queryId()) {
			sql = "insert into user values('"+id+"','"+name+"','"+password+"');";
			int count = db.executeUpdate(sql);
			db.disconnect();
			if(count == 1)
				return true;
		}
		return false;
		
	}
	


	
	
	
}
