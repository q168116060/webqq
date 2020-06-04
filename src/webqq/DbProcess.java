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
			System.out.println("mysql���ݿ��������سɹ�");


		}
		catch(java.lang.ClassNotFoundException e) {
			e.printStackTrace();
		}
	}


	public void connect(){
		try{

			connection = DriverManager.getConnection(urlMySql);  
			if(connection!=null){
	            System.out.println("���ݿ����ӳɹ�");
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
				System.out.println("���ݿ��Ѿ��Ͽ�");
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
			// ִ�в�ѯ
			rs = pstm.executeQuery();
		} 
		catch(SQLException ex) { 
			ex.printStackTrace();
			this.disconnect();
		}
		return rs;
	}
	
	//����
	//executeUpdate �ķ���ֵ��һ��������ָʾ��Ӱ��������������¼�������
	//executeUpdate����ִ�� INSERT��UPDATE �� DELETE ���
	//�Լ� SQL DDL�����ݶ������ԣ���䣬���� CREATE TABLE �� DROP TABLE��
	
	//ִ������ɾ�������ķ���
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