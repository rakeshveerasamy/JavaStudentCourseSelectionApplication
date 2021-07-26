<%@page import="com.zoho.model.EncodeDecode"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
   .center-align{
      text-align:center;
      margin:auto;
   }
   .paddingControl
   {
        padding:20px 20px;
   }
   
</style>
</head>
<body>
	<form class ="center-align paddingControl" action ="StudentLoginServlet" method = "Post">
	<input type = "hidden" name = "status" value = "login"required/>
	  <p style="color: red;">${errorString}</p>
	  <div class ="paddingControl">
	     <h2 style="color:blue">Welcome... Please Login</h2>
	  </div>
	  <div class="paddingControl">
	      <label for="userid"><font face="consolas" size="3px">User name :</font></label>
	      <input type ="text" name = "userid" required/>
	  </div>
	  <div class="paddingControl" >
	     <label for="password"><font face="consolas" size="3px">Password :</font></label>
	     <input type="password" name ="password" required/>
	  </div>
	  <input type = "Submit" name = "Login"/>
	  <div class="paddingControl">
	     <label for= "newUser"><font face="consolas" size="3px">New User </font></label>
	     <a href="signup.jsp">SignUp Here</a>
	  </div>
	  <div class="paddingControl">
	     <label for= "forgetpassword"><font face="consolas" size="3px">Forget Password </font></label>
	     <a href="forget.jsp">Click Here</a>
	  </div>
	</form>
</body>
</html>