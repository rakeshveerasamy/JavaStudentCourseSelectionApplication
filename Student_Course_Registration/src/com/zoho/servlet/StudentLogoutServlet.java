package com.zoho.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.zoho.jdbc.DatabaseHandler;
import com.zoho.model.CourseDetails;
import com.zoho.model.StudentDetails;

/**
 * Servlet implementation class StudentLogoutServlet
 */
@WebServlet("/StudentLogoutServlet")
public class StudentLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentLogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//
//		PrintWriter pw = response.getWriter();
//		String s = request.getParameter("person");
//		pw.print(s);
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		Connection con = null;
		String person  = request.getParameter("person");
		String subject = request.getParameter("subject");
		JSONParser parser = new JSONParser();  
		ArrayList<CourseDetails> subarrayList = new ArrayList<CourseDetails>();
		ArrayList<StudentDetails> stuarrayList = new ArrayList<StudentDetails>();
		try {
            con = DatabaseHandler.getConnection();
			JSONArray jsonstu = (JSONArray) parser.parse(person);
			JSONArray jsonsub = (JSONArray) parser.parse(subject);
		    JSONObject myJSONObject = new JSONObject();
		    
		    for (Object myObject : jsonsub) {
		        myJSONObject = (JSONObject) myObject;

		        String coursename = (String) ((JSONObject) myJSONObject).get("COURSE_NAME");
		        int courseid = (int) ((JSONObject) myJSONObject).get("COURSE_ID");
		        String coursedept = (String) ((JSONObject) myJSONObject).get("COURSE_Dept");
		        String courseinstructor = (String) ((JSONObject) myJSONObject).get("INSTRUCTOR");
                CourseDetails cru = new CourseDetails(courseid,coursename,coursedept,courseinstructor);
		        subarrayList.add(cru);
		    }
		    for (Object myObject : jsonstu) {

		        myJSONObject = (JSONObject) myObject;

		        String name = (String) ((JSONObject) myJSONObject).get("NAME");
		        int rollno = (int) ((JSONObject) myJSONObject).get("ROLLNO");
		        String dept = (String) ((JSONObject) myJSONObject).get("DEPARTMENT");
		        String coursename = (String) ((JSONObject) myJSONObject).get("COURSE_NAME");
		        String instructor = (String) ((JSONObject) myJSONObject).get("INSTRUCTOR");
		        StudentDetails stu = new StudentDetails(name,rollno,dept,coursename,instructor);
		       stuarrayList.add(stu);
		    }
            StudentDatabaseServlet.insertSubject(con,subarrayList);
	        StudentDatabaseServlet.insertStudent(con,stuarrayList);


		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		finally{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		RequestDispatcher rd = request.getRequestDispatcher("StudentLogout.jsp");
		rd.forward(request, response);
		
	}

}
