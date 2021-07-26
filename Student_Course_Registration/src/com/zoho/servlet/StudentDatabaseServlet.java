package com.zoho.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zoho.model.CourseDetails;
import com.zoho.model.EncodeDecode;
import com.zoho.model.StudentDetails;


public class StudentDatabaseServlet  {
	
	public static boolean availableUser(Connection con, String username) throws SQLException {
		String query = "select * from user where user_id = ?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, EncodeDecode.encryptText(username));
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			return true;
		}
		return false;

	} 
	
	public static void addForgetUser(Connection con, String username, String password) throws SQLException {
		String query = " update user set password = ? where user_id  =?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, EncodeDecode.encryptPass(password));
		pst.setString(2, EncodeDecode.encryptText(username));
		pst.executeUpdate();
		pst.close();

	}
	
	public static void addUser(Connection con, String fname, String lname, String email, String username,
			String password) throws SQLException {
			String query = "insert into user(fname,lname,email,user_id,password) values(?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, fname);
			pst.setString(2, lname);
			pst.setString(3, email);
			pst.setString(4, EncodeDecode.encryptText(username));
			pst.setString(5, EncodeDecode.encryptPass(password));
			pst.executeUpdate();
			pst.close();

		}
	
	public static boolean availableUserData(Connection con, String fname, String lname, String email, String username)
			throws SQLException {
		String query = "select * from user where fname = ? and lname = ? and email=? and user_id =?";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, fname);
		pst.setString(2, lname);
		pst.setString(3, email);
		pst.setString(4, EncodeDecode.encryptText(username));
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			return true;
		}
		return false;

	}
	
	public static boolean loginUser(Connection con, String username, String password) throws SQLException {
		String query = "select * from user where user_id=? and password=?";
		PreparedStatement pst = con.prepareStatement(query);
		String user = EncodeDecode.encryptText(username);
		String pass = EncodeDecode.encryptPass(password);
		pst.setString(1, user);
		pst.setString(2, pass);
		ResultSet rs = pst.executeQuery();
		if (rs.next()) {
			if ((rs.getString(4).equals(user) && rs.getString(5).equals(pass))) {
				return true;
			} else {
				return false;
			}
		}
		pst.close();
		rs.close();
		return false;
	}
	
	public static void insertSubject(Connection con,ArrayList<CourseDetails> cru) throws SQLException
	{
		String query = "truncate table course";
		PreparedStatement pst = con.prepareStatement(query);
        query = "insert course_name,course_no,dept,instructor into course values(?,?,?,?)";
        for(CourseDetails cd : cru)
        {
    		pst.setString(1, cd.getName());
    		pst.setInt(2, cd.getId());
    		pst.setString(3, cd.getDepartment());
    		pst.setString(4, cd.getInstructor());
    		pst.executeUpdate();
        }
		pst.close();
	}
	public static void insertStudent(Connection con,ArrayList<StudentDetails> stu) throws SQLException
	{
        String query = "insert name,rollno,dept into student values(?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);

        for(StudentDetails std : stu)
        {
        	pst.setString(1, std.getName());
        	pst.setInt(2, std.getRollno());
        	pst.setString(3, std.getDepartment());
    		pst.executeUpdate();
        }
        pst.close();
        insertSelection(con,stu);
	}
	public static void insertSelection(Connection con ,ArrayList<StudentDetails> stu) throws SQLException
	{
        String query = "insert rollno,course_no into selection values(?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);
        for(StudentDetails std : stu)
        {
        	String query1 = "select course_no from course where course_name like ?";
    		PreparedStatement pstm = con.prepareStatement(query1);
    		pst.setString(1, std.getCoursename());
    		ResultSet rs = pstm.executeQuery();
            int no = rs.getInt(1);
        	pst.setInt(1, std.getRollno());
        	pst.setInt(2, no);
    		pst.executeUpdate();
        }
        pst.close();

	}
}
