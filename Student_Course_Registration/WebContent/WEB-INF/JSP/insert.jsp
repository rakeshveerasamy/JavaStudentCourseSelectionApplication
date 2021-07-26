<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $.getJSON("JSONServlet", function(result){
     localStorage.setItem('person', JSON.stringify(result));
   });
   $.getJSON("subjectDetailsServlet",function(result){
	     localStorage.setItem("subject",JSON.stringify(result));
   });
});

const pages = {
		  Dashboard: "dashboard",
		  insertDetails:"insert-details",
		  addSubject :"add-Subject",
		  SubjectSearch :"subject-search",
		  StudentSearch :"student-search"
		};
		
var confirmMssg = document.getElementsByClassName("confirm-mssg"); 

function navigatePages(val) {
	  var arr = Array.from(document.getElementsByTagName("section")); 
	  for (var elem of arr) {
	    if (elem.id === pages[val]) {
	      elem.style.display = "unset";
	    } else {
	      elem.style.display = "none";
	    }
	  }
	}

function displayTable()
{
	var myBooks = JSON.parse(localStorage.getItem("person"));
    var col = [];
    for (var i = 0; i < myBooks.length; i++) {
        for (var key in myBooks[i]) {
            if (col.indexOf(key) === -1) {
                col.push(key);
            }
        }
    }
    var table = document.createElement("table");
    var tr = table.insertRow(-1); 
    for (var i = 0; i < col.length; i++) {
        var th = document.createElement("th");
        th.innerHTML = col[i];
        tr.appendChild(th);
    }
    for (var i = 0; i < myBooks.length; i++) {
        tr = table.insertRow(-1);
        for (var j = 0; j < col.length; j++) {
            var tabCell = tr.insertCell(-1);
            if(isNaN(myBooks[i][col[j]]))
	                   tabCell.innerHTML = myBooks[i][col[j]].toUpperCase();
	                else
		               tabCell.innerHTML = myBooks[i][col[j]];
            }
    }
    var divContainer = document.getElementById("showData");
    divContainer.innerHTML = "";
    divContainer.appendChild(table);
}

function gotoEdit() {
	  navigatePages("insertDetails");
      confirmMssg[0].style.display = "none"; 
	}
	
function gotoAddSubject() {
	  navigatePages("addSubject");
	  confirmMssg[1].style.display = "none"; 

	}
	
function searchSubject(){
	  navigatePages("SubjectSearch");
	  var sub  = document.getElementById("subjectSearchInput").value;
      var myBooks = JSON.parse(localStorage.getItem("person"));
      var subDetails = JSON.parse(localStorage.getItem("subject"));
      
      var col = [];
      for (var i = 0; i < myBooks.length; i++) {
          for (var key in myBooks[i]) {
              if (col.indexOf(key) === -1) {
                  col.push(key);
              }
          }
      }
      var name;
      if(!isNaN(sub))
	  {
	    for(var i =0;i<subDetails.length;i++)
	    	{
	    	  if (subDetails[i]['COURSE_ID'] == Number(sub))
	    			  {
	    		          name = subDetails[i]['COURSE_NAME'];
	    		          break;
	    			  }
	    	}
	  }
      var table = document.createElement("table");
      var tr = table.insertRow(-1); 
      for (var i = 0; i < col.length; i++) {
          var th = document.createElement("th");
          th.innerHTML = col[i];
          tr.appendChild(th);
      }
      for (var i = 0; i < myBooks.length; i++) {
          tr = table.insertRow(-1);
          if(!isNaN(sub) && myBooks[i]['COURSE_NAME']==String(name))
        	  {
          for (var j = 0; j < col.length; j++) {
	                var tabCell = tr.insertCell(-1);
	                if(isNaN(myBooks[i][col[j]]))
	                   tabCell.innerHTML = myBooks[i][col[j]].toUpperCase();
	                else
		               tabCell.innerHTML = myBooks[i][col[j]];
             }
          
             }
          else if(isNaN(sub) && (myBooks[i]['COURSE_NAME']==String(sub)))
        	  {
	        	 for (var j = 0; j < col.length; j++) {
		                var tabCell = tr.insertCell(-1);
		                if(isNaN(myBooks[i][col[j]]))
			                   tabCell.innerHTML = myBooks[i][col[j]].toUpperCase();
			                else
				               tabCell.innerHTML = myBooks[i][col[j]];
	               }
        	  }
      }
      var divContainer = document.getElementById("showSubject");
      divContainer.innerHTML = "";
      divContainer.appendChild(table);
    }
  
function searchStudent(){
	 navigatePages("StudentSearch");
	var stu  = document.getElementById("studentSearchInput").value;
    var myBooks = JSON.parse(localStorage.getItem("person"));
    var col = [];
    for (var i = 0; i < myBooks.length; i++) {
        for (var key in myBooks[i]) {
            if (col.indexOf(key) === -1) {
                col.push(key);
            }
        }
    }
    var table = document.createElement("table");
    var tr = table.insertRow(-1); 
    for (var i = 0; i < col.length; i++) {
        var th = document.createElement("th");
        th.innerHTML = col[i];
        tr.appendChild(th);
    }
    for (var i = 0; i < myBooks.length; i++) {
        tr = table.insertRow(-1);
        if(!isNaN(stu) && myBooks[i]['ROLLNO']==Number(stu))
      	  {
        for (var j = 0; j < col.length; j++) {
	                var tabCell = tr.insertCell(-1);
	                if(isNaN(myBooks[i][col[j]]))
		                   tabCell.innerHTML = myBooks[i][col[j]].toUpperCase();
		                else
			               tabCell.innerHTML = myBooks[i][col[j]];          
	                }
        
           }
        else if(isNaN(stu) && myBooks[i]['NAME']==String(stu.toLowerCase()))
      	  {
	        	 for (var j = 0; j < col.length; j++) {
		                var tabCell = tr.insertCell(-1);
		                if(isNaN(myBooks[i][col[j]]))
			                   tabCell.innerHTML = myBooks[i][col[j]].toUpperCase();
			                else
				               tabCell.innerHTML = myBooks[i][col[j]];	       
		               }
      	  }
      	  
    }
    var divContainer = document.getElementById("showStudent");
    divContainer.innerHTML = "";
    divContainer.appendChild(table);
  }
function resetEdit()
{
	document.getElementById('name').value = "";
	document.getElementById('rollno').value = "";
	document.getElementById('department').value = "";
	document.getElementById('email').value = "";
	document.getElementById('phonenumber').value = "";
    document.getElementById('sel').value = "";
}

function resetAdd()
{
	document.getElementById('subjectid').value = "";
	document.getElementById('subjectname').value = "";
	document.getElementById('subjectdepartment').value = "";
	document.getElementById('instructor').value = "";
}


$(document).ready(function(){
	var status = true;
	$("#sel").click(function(){
		if(status)
			{
			var details = JSON.parse(localStorage.getItem("subject"));
			 var ele = document.getElementById('sel');
			 for(var i=0;i<details.length;i++)
				 {
				 ele.innerHTML = ele.innerHTML+
				  '<option value="'+details[i]['INSTRUCTOR']+'" >'+details[i]['COURSE_NAME']+'</option>';
				 }
		     status = !status;
			}
	});
});

function show(ele)
{
   document.getElementById('Subject').value = ele.options[ele.selectedIndex].text;
}

function submitInsert()
{
	 var a = [];
	 a = JSON.parse(localStorage.getItem('person'))||[];
     var name = insert["name"].value.toLowerCase();
     var rollnumber = insert["rollno"].value;
     var department = insert["department"].value.toLowerCase();
     var subjectinstructor = insert["instructor"].value.toLowerCase();
     var subjectname = insert["subject"].value.toLowerCase();
     var email = insert['email'].value;
     var flag = true;
     for(var index = 0;index<a.length;index++)
    	 {
    	   if(((a[index]['NAME']==String(name))||(a[index]['ROLLNO']==Number(rollnumber)))&&(a[index]['COURSE_NAME']==String(subjectname)))
    	    {
    		   flag = false;
    		   break;
    	    }
    	 }
     if(flag)
    	 {
		     var entry = {};
		     entry.ROLLNO = Number(rollnumber);
		     entry.DEPARTMENT = department;
		     entry.NAME = name;
		     entry.COURSE_NAME = subjectname;
		     entry.INSTRUCTOR = subjectinstructor;
			 a.push(entry);
			 localStorage.setItem('person',JSON.stringify(a));
		     navigatePages('Dashboard');
		     displayTable();
    	 }
     else
    	 {
         confirmMssg[0].style.display = "block"; 
    	 }
}

function submitSubject()
{
	 var a = [];
	 a = JSON.parse(localStorage.getItem('subject'))||[];
     var id = add["subjectid"].value;
     var name = add["subjectname"].value.toLowerCase();
     var department = add["subjectdepartment"].value.toLowerCase();
     var instructor = add["instructor"].value.toLowerCase();
     var flag = true;
     for(var index = 0;index<a.length;index++)
	 {
	   if(((a[index]['COURSE_NAME']==String(name))||(a[index]['COURSE_ID']==Number(id)))&&(a[index]['INSTRUCTOR']==String(instructor)))
	    {
		   flag = false;
		   break;
	    }
	 }
     if(flag)
    	 {
		     var entry = {};
		     entry.COURSE_Dept = department;
		     entry.COURSE_ID = Number(id);
		     entry.COURSE_NAME = name;
		     entry.INSTRUCTOR = instructor;
		     a.push(entry);
		     localStorage.setItem('subject',JSON.stringify(a));
		     navigatePages('Dashboard');
    	 }
     else
	 {
     confirmMssg[1].style.display = "block"; 
	 }
}

function gotoSignOut()
{
	 var stu = [];
	 var sub = [];
	 stu = JSON.stringify(JSON.parse(localStorage.getItem('person')));
	 sub = JSON.stringify(JSON.parse(localStorage.getItem('subject')));
	 $.ajax({
			type:'POST',
			data:{
				person:stu,
				subject:sub
				},
			dataType:"json",
			url :"StudentLogoutServlet"
		});
}

</script>
 <style>
       table,th,td{
	         border:1px solid white;
	         border-collapse:collapse;
	     }
	     table{
	        cellspacing :100px;
	        cellpadding:100px;
	        margin:auto;
	        width:60%;
	     }
	     th{
	        padding: 10px 30px;
	        background-color:dodgerblue;
	        color:white;
	     }
	      th,td{
	       colspan:3;
	       rowspan:3;
	     }
	     td
	     {
	       padding: 10px 30px;
	       text-align:center;
	     }
	     tr:nth-child(even)
	      {background: #CCC}
         tr:nth-child(odd) 
         {background: #FFF}
         #clear-list1{
           text-align:center;
           justify-content:center;
           align-item:center;
         }
         .dropbtn {
			  background-color: #04AA6D;
			  color: white;
			  padding: 16px;
			  font-size: 16px;
			  border: none;
			}
			#insert-details,#add-Subject,#subject-search,#student-search{
			  display :none;
			}
			.confirm-mssg {
				      display: none;
					  float: none;
					  font-size: 18px;
					  color:red;
			}
    </style>
</head>
<body>
<div>
 
   <section id="dashboard">
    <input type ="hidden" name = "personJSON" id = "personJ" value = ""/>
     <input type = "hidden" name = "subjectJSON" id = "subjectJ" value = ""/>
   	  <p style="color: green;">${successString}</p>
        <h2 style = "color:blue; text-align:center">Student Elective Selection Forum</h2>
        <p id="showData"></p>
        <div style="text-align:center">
	        <div>
		        <button class="dropbtn" type="button" name="clear-list" onclick="gotoEdit(); resetEdit(); return false;">Insert</button>
	        </div>
	        <br/>
	        <div>
		        <input id = "subjectSearchInput" placeholder = "Enter Subject ID / Name" />
		        <button class="dropbtn" type = "button" onclick ="searchSubject(); return false;">Search by Subject</button>
		        &nbsp;
		        <input  id = "studentSearchInput" placeholder = "Enter Student ID / Name" />
		        <button class="dropbtn" type = "button" onclick = "searchStudent(); return false;">Search by Student</button>
		         &nbsp;
		        <button class="dropbtn" type="button"  onclick="gotoAddSubject(); return false;">Add Subject</button>
	        </div>
	        <br/>
	        <div>
		        <a class="dropbtn" id="clear-list" href ="" type="button" name="clear-list" onclick ="gotoSignOut()"  >SignOut</a>
	        </div>
        </div>
        <script>
		        var myBooks = JSON.parse(localStorage.getItem("person"));
		        var col = [];
		        for (var i = 0; i < myBooks.length; i++) {
		            for (var key in myBooks[i]) {
		                if (col.indexOf(key) === -1) {
		                    col.push(key);
		                }
		            }
		        }
		        var table = document.createElement("table");
		        var tr = table.insertRow(-1); 
		        for (var i = 0; i < col.length; i++) {
		            var th = document.createElement("th");
		            th.innerHTML = col[i];
		            tr.appendChild(th);
		        }
		        for (var i = 0; i < myBooks.length; i++) {
		            tr = table.insertRow(-1);
		            for (var j = 0; j < col.length; j++) {
		                var tabCell = tr.insertCell(-1);
		                if(isNaN(myBooks[i][col[j]]))
			                   tabCell.innerHTML = myBooks[i][col[j]].toUpperCase();
			                else
				               tabCell.innerHTML = myBooks[i][col[j]];
		                }
		        }
		        var divContainer = document.getElementById("showData");
		        divContainer.innerHTML = "";
		        divContainer.appendChild(table);
		</script>
      </section>
      
      
      <section id="insert-details">
      <div style="text-align:center">
        <h2 style = "color:blue">
          Insert Student Details
        </h2>
        <div class="signup-form">
          <form name="insert" id="insert">
              <div class="confirm-mssg">
                <span class="required">
                 Please Enter the Correct details.<br/>
                 ----Note----<br/>
                  * A Student is allowed to choose a subject for only one time<br/></span>
              </div>
              <div>
                <label>Name<span class="required">*</span>:</label>
                <input type="text" name="name" id = "name" placeholder="Your Name" required />
              </div>
              <br/>
              <div>
                <label>Roll Number<span class="required">*</span>:</label>
                <input type="number" name="rollno" id = "rollno" placeholder="Your RollNumber"  required/>
              </div>
              <br/>
              <div>
                <label>Department<span class="required">*</span>:</label>
                <input type="text" name="department" id = "department" placeholder="Your Department" required />
              </div>
              <br/>
              <div>
                <label>Email<span class="required">*</span>:</label>
                <input type="email" name="email" id = "email" placeholder="Your Email" required/>
              </div>
              <br/>
              <div>
                <label>Phone Number<span class="required">*</span>:</label>
                <input type="number" name="phonenumber" id = "phonenumber" placeholder="Your Phone Number" required/>
              </div>
              <br/>
              <div>
               <div>
                <label>Subject<span class="required">*</span>:</label>
                <select id = "sel" onchange = "show(this)" name = "instructor">
                	<option value = "">----Select----</option>
                </select>
                 <input type = "hidden" id = "Subject" name = "subject"/>
               </div>
              </div>
          </form>
          <br/>
          <br/>
          <input  class="dropbtn" type="button" name="clear-list" onclick="submitInsert();resetEdit();return false;"  value ="Insert"/>
        </div>
        <br/>
        <br/>
        <div>
        <a class="dropbtn" class="edit"  onclick="navigatePages('Dashboard'); resetEdit(); return false;" >Back To Dashboard</a>
        </div>
        </div>
      </section>
      
      
      <section id="add-Subject">
      <div style = "text-align:center">
        <h2 style = "color:blue">
            Add Subject
        </h2>
        <div class="add-form">
          <form name="add" id="add">
               <div class="confirm-mssg">
                <span class="required">
                 Please Enter the Correct details.<br/>
                 ----Note----<br/>
                  * A Staff is allowed to enter a subject for only one time<br/></span>
              </div>
              <div>
                <label>Subject Id<span class="required">*</span>:</label>
                <input type="number" name="subjectid" id ="subjectid" placeholder="Enter Subject Id" required/>
              </div>
              <br/>
              <div>
                <label>Subject Name<span class="required">*</span>:</label>
                <input type="text" name="subjectname" id = "subjectname" placeholder="Enter Subject Name" required/>
              </div>
              <br/>
              <div>
                <label>Department<span class="required">*</span>:</label>
                <input type="text" name="subjectdepartment" id = "subjectdepartment" placeholder="Enter Subject Department" required/>
              </div>
              <br/>
              <div>
                <label>Instructor<span class="required">*</span>:</label>
                <input type="text" name="instructor" id = "instructor" placeholder="Enter Subject Instructor" required/>
              </div>
              <br/>
          </form>
          <br/>
          <br/>
                <a  class="dropbtn" type="button"  onclick="submitSubject(); resetAdd(); return false;">Insert Subject</a>
        </div>
        <br/>
        <br/>
        <div>
        <a class="edit dropbtn"  onclick="navigatePages('Dashboard'); resetAdd(); return false;">Back To Dashboard</a>
        </div>
        </div>
      </section>
      
      <section id="subject-search">
       <div style = "text-align:center">
        <h2 style = "color:blue; text-align:center">Subject Search Result</h2>
        <p id="showSubject"></p>
       <a class="edit dropbtn"  href="#" onclick="navigatePages('Dashboard'); resetEdit(); return false;" >Back To Dashboard</a>
       </div>
      </section>
      
      <section id="student-search">
         <div style = "text-align:center">
        <h2 style = "color:blue; text-align:center">Student Search Result</h2>
        <p id="showStudent"></p>
       <a class="edit dropbtn"  href="#" onclick="navigatePages('Dashboard'); resetEdit(); return false;" >Back To Dashboard</a>
      </div>
      </section>
 </div>
</body>
</html>