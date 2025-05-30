package com.dao;

import com.model.StudentMark;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MarkDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/Structure";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    
    // Database connection
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }
    
    // Add new student mark
    public boolean addMark(StudentMark mark) {
        String sql = "INSERT INTO StudentMarks (StudentID, StudentName, Subject, Marks, ExamDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, mark.getStudentID());
            pstmt.setString(2, mark.getStudentName());
            pstmt.setString(3, mark.getSubject());
            pstmt.setInt(4, mark.getMarks());
            pstmt.setDate(5, mark.getExamDate());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update existing mark
    public boolean updateMark(StudentMark mark) {
        String sql = "UPDATE StudentMarks SET StudentName=?, Subject=?, Marks=?, ExamDate=? WHERE StudentID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, mark.getStudentName());
            pstmt.setString(2, mark.getSubject());
            pstmt.setInt(3, mark.getMarks());
            pstmt.setDate(4, mark.getExamDate());
            pstmt.setInt(5, mark.getStudentID());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete student mark
    public boolean deleteMark(int studentID) {
        String sql = "DELETE FROM StudentMarks WHERE StudentID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, studentID);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all marks
    public List<StudentMark> getAllMarks() {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks ORDER BY StudentID";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return marks;
    }
    
    // Get mark by student ID
    public StudentMark getMarkByStudentID(int studentID) {
        String sql = "SELECT * FROM StudentMarks WHERE StudentID=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, studentID);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                return mark;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get students with marks above threshold
    public List<StudentMark> getStudentsAboveMarks(int threshold) {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks WHERE Marks > ? ORDER BY Marks DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, threshold);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return marks;
    }
    
    // Get students by subject
    public List<StudentMark> getStudentsBySubject(String subject) {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks WHERE Subject=? ORDER BY Marks DESC";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, subject);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return marks;
    }
    
    // Get top N students
    public List<StudentMark> getTopStudents(int limit) {
        List<StudentMark> marks = new ArrayList<>();
        String sql = "SELECT * FROM StudentMarks ORDER BY Marks DESC LIMIT ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StudentMark mark = new StudentMark();
                mark.setStudentID(rs.getInt("StudentID"));
                mark.setStudentName(rs.getString("StudentName"));
                mark.setSubject(rs.getString("Subject"));
                mark.setMarks(rs.getInt("Marks"));
                mark.setExamDate(rs.getDate("ExamDate"));
                marks.add(mark);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return marks;
    }
}