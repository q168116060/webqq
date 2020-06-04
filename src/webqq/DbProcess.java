package webqq;

import java.sql.*;



public class DbProcess{
	Connection connection = null;
	ResultSet rs = null;


	String userMySql="root"; 
	String passwordMySql="1111";
	String urlMySql = "jdbc:mysql://localhost:3306/webqq?user="
			+userMySql+"&password="+passwordMySql + "&useUnicode=true&characterEncoding=gbk";
	
	public DbProcess() {
		try {

			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("mysql数据库驱动加载成功");


		}
		catch(java.lang.ClassNotFoundException e) {
			e.printStackTrace();
		}
	}


	public void connect(){
		try{

			connection = DriverManager.getConnection(urlMySql);  
			if(connection!=null){
	            System.out.println("数据库连接成功");
	        }
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void disconnect(){
		try{
			if(connection != null){
				connection.close();
				connection = null;
				System.out.println("数据库已经断开");
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}


	public ResultSet executeQuery(String sql) {
		try {
			System.out.println("executeQuery(). sql = " + sql);
			PreparedStatement pstm = connection.prepareStatement(sql);
			// 执行查询
			rs = pstm.executeQuery();
		} 
		catch(SQLException ex) { 
			ex.printStackTrace();
			this.disconnect();
		}
		return rs;
	}
	
	//插入
	//executeUpdate 的返回值是一个整数，指示受影响的行数（即更新计数）。
	//executeUpdate用于执行 INSERT、UPDATE 或 DELETE 语句
	//以及 SQL DDL（数据定义语言）语句，例如 CREATE TABLE 和 DROP TABLE。
	
	//执行增、删、改语句的方法
	public int executeUpdate(String sql) {
		int count = 0;
		try {
			System.out.println("executeupdate(). sql = " + sql);
			Statement stmt = connection.createStatement();
			count = stmt.executeUpdate(sql);
		} 
		catch(SQLException ex) { 
			System.err.println(ex.getMessage());
		}
		return count;
	}
}