
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
    	String rss = "";
		long offset = 0;
		double avgOffset = 0;
		long maxIter = 50;
		long failed = 0;
		long succeed = 0;
	    System.out.println( "!Evaluating date now" );
	    java.util.Date date = new java.util.Date();
	    String str = "";
	    
	    	Class.forName("org.postgresql.Driver"); 
	    	String dbName = "jdbc:postgresql://128.105.12.66:5432/tpcw";
	    	Connection con = DriverManager.getConnection(dbName,"postgres","sa");
	    	
	    	//for(int i=0;i<10000;i++){
    		int ct = 0;
    		loop:
    			
		    while(true){
		    	try{
		    		long a = System.currentTimeMillis();
			    	Statement ps = con.createStatement();
			    	
			    	//int lower = (int)(Math.random()*1000);
			    	int lower = 0;
			    	
			    	ResultSet rs = ps.executeQuery("SELECT * FROM item where i_id<" + (lower+100) + "AND i_id>"
			    			+ lower);
			    	System.out.println(5);
			    	System.out.println(rs.getFetchSize());
			    	rs.next();
			    	str = rs.getString("i_id");
			    	System.out.println(rs.getString("i_id"));
			    	
			    	long b = System.currentTimeMillis();
			    	offset = b - a;
			    	
			    	if(offset != 0){
			    		if(maxIter == ct++)
			    			break;
			    		rss += offset + ", ";
			    		avgOffset += offset;
			    		succeed ++;
			    	}
			    	
		    	}catch(Exception e){
		    	//continue loop;
			    	failed ++;
			    	System.out.println(e.toString());
			    	continue;
		    	}	
	   	 	}
    		avgOffset /= maxIter;
    	
    		con.close();
    
%>
Hello!  The time is now <%= date %>
<br/>
iid = <%= str %>
<br/>
UseTime = <%= rss %>
<br/>
avgUseTime = <%= avgOffset %>
<br/>
succeed = <%= succeed %>
<br/>
failed = <%= failed %>

</body>
</html>