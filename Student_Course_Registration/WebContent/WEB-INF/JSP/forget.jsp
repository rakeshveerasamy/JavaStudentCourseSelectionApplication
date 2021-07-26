<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	<form class ="center-align paddingControl" action ="forgetPasswordServlet" method = "Post">
	  <p style="color: red;">${errorString}</p>
	  <p style="color: green;">${successString}</p>
	  <div class="paddingControl">
	      <label for="username"><font face="consolas" size="3px">User name :</font></label>
	      <input type ="text" name = "username" required/>
	  </div>
	  <div class="paddingControl" >
	     <label for="password"><font face="consolas" size="3px">Password :</font></label>
	     <input type="text" name ="password" required/>
	  </div>
	  <div class="paddingControl" >
	     <label for="confirmpassword"><font face="consolas" size="3px">Confirm Password :</font></label>
	     <input type="password" name ="confirmpassword" required/>
	  </div>
	  <input type = "Submit" name = "Login"/>
	  <div class="paddingControl">
	     <a href="login.jsp">Go to Login</a>
	  </div>
	  <div class="paddingControl">
	     <a href="signup.jsp">Go to New Registration</a>
	  </div>
	</form>
</body>
</html>