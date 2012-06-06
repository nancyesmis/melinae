package gourmand;

import java.sql.*;

public class main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	    System.out.println( "Evaluating date now" );
	    java.util.Date date = new java.util.Date();
	    try{
	    	Class.forName("org.postgresql.Driver"); 
	    	String dbName = "jdbc:postgresql://128.105.12.66:5432/tpcw";
	    	Connection con = DriverManager.getConnection(dbName,"postgres","sa");
	    	
	    	for(int i=0;i<10000;i++){
		    	Statement ps = con.createStatement();
		    	
		    	int lower = (int)(Math.random()*1000);
		    	int offset = args.length > 0 ? 2 : 100;
		    			
		    	System.out.println("~~~~~" + offset);
		    	
		    	ps.execute("SELECT * FROM item where i_id<" + (lower+offset) + "AND i_id>"+ lower);
		    	
		    	//ResultSet rs = ps.executeQuery("SELECT * FROM item where i_id<" + (lower+100) + "AND i_id>"
		    	//		+ lower);
		    	
		    	//System.out.println(5);
		    	//System.out.println(rs.getFetchSize());
		    	//rs.next();
		    	//System.out.println(rs.getString("i_id"));
		    	
		    	
		    	Thread.sleep(500);
		    	
	    	}
	    	con.close();
	    	
	    }catch(Exception e){
	    	System.out.println(e.toString());
	    }
	}

}
