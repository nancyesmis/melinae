
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
    // This is a scriptlet.  Notice that the "date"
    // variable we declare here is available in the
    // embedded expression later on.
    	long a = System.currentTimeMillis();
		long offset = 0;
	    System.out.println( "!Evaluating date now" );
	    java.util.Date date = new java.util.Date();
	    String str = "";
	    try{
	    	Class.forName("org.postgresql.Driver"); 
	    	String dbName = "jdbc:postgresql://localhost:5432/tpcw";
	    	Connection con = DriverManager.getConnection(dbName,"postgres","aA19871121");
	    	
	    	for(int i=0;i<10000;i++){
    	
		    	Statement ps = con.createStatement();
		    	
		    	int lower = (int)(Math.random()*1000);
		    	//int lower = 0;
		    	
		    	ResultSet rs = ps.executeQuery("SELECT * FROM item where i_id<" + (lower+100) + "AND i_id>"
		    			+ lower);
		    	System.out.println(5);
		    	System.out.println(rs.getFetchSize());
		    	rs.next();
		    	str = rs.getString("i_id");
		    	System.out.println(rs.getString("i_id"));
		    	
		    	long b = System.currentTimeMillis();
		    	offset = b - a;
		    	
		    	Thread.sleep(500);
		    	
	    	}
	    	
	    	con.close();
	    	
	    }catch(Exception e){
	    	System.out.println(e.toString());
	    }
    
%>
Hello!  The time is now <%= date %>
<br/>
iid = <%= str %>
<br/>
useTime = <%= offset %>

</body>
</html>