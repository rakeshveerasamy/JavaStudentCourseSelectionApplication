<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
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
	<form class ="center-align paddingControl" action ="userRegistration" method = "Post">
	  <p style="color: red;">${errorString}</p>
      <p style="color: green;">${successString}</p>
	  <div class="paddingControl">
	      <label for="fname"><font face="consolas" size="3px">First Name :</font></label>
	      <input type ="text" name = "fname" required/>
	  </div>
	  <div class="paddingControl" >
	     <label for="lname"><font face="consolas" size="3px">Last Name :</font></label>
	     <input type="text" name ="lname"/>
	  </div>
	  <div class = "paddingControl">
	     <label for="email"><font face="consolas" size="3px">Email ID :</font></label>	     
	  	 <input type="email" pattern="[a-zA-Z0-9.-_]{1,}@[a-zA-Z.-]{2,}[.]{1}[a-zA-Z]{2,}"
 name = "email" required>
	  </div>
	  <div class = "paddingControl">
	     <label for="username"><font face="consolas" size="3px">User Name :</font></label>	     
	     <input type="text" name ="username" required/>
	  </div>
	  <div class = "paddingControl">
	     <label for="password"><font face="consolas" size="3px">Password :</font></label>	     
	  	 <input type="text" pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]*" name = "password" required>
	  </div>
	  <div class = "paddingControl">
	     <label for="confirmpassword"><font face="consolas" size="3px">Confirm Password :</font></label>	     
	  	 <input type="password" pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]*" name = "confirmpassword" required>
	  </div>
	  <input type = "Submit" name = "Submit"/>
	  <div class="paddingControl">
	     <a href="login.jsp">Go to Login</a>
	  </div>
	</form>
</body>
</html>