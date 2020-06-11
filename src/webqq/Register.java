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
	
	//查账号存不存在，不存在才允许注册
	public Boolean queryId() {
		db.connect();
		sql = "select id from user where id = '"+id+"';";
		rs = db.executeQuery(sql);
		try {
			rs.last();
			if(rs.getRow()==0) {
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
	
	//判断账号是否存在，注册成功写进数据库
	public Boolean insert() {
		if(this.queryId()) {
			db.connect();
			sql = "insert into user values('"+id+"','"+name+"','"+password+"','null');";
			int count = db.executeUpdate(sql);
			if(count == 1)
				db.disconnect();
				return true;
		}
		db.disconnect();
		return false;
		
	}
	


	
	
	
}
