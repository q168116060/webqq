<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC访问数据库</title>
</head>
<body bgcolor="pink">
<h3 align="center" >使用mysql的jdbc驱动访问数据库</h3>
<hr>
<table border="1" bgcolor="#ccceee" align="center">
<tr>
<td>姓名</td>
<td>年龄</td>
</tr>
<%
Connection con=null;
Statement stmt=null;
ResultSet rs=null;
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/Student?useUnicode=true&characterEncoding=gbk";
con=DriverManager.getConnection(url,"root","111");
stmt=con.createStatement();
String sql="select * from name_age;";
rs=stmt.executeQuery(sql);
while(rs.next())
{
%>
<tr>
<td><%=rs.getString("name") %></td>
<td><%=rs.getString("age") %></td>
</tr>
<%} 
rs.close();
stmt.close();
con.close();

%>



</table>
</body>
</html>