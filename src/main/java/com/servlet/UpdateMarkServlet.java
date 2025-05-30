package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/UpdateMarkServlet")
public class UpdateMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;
    
    public void init() {
        markDAO = new MarkDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("search".equals(action)) {
            int studentID = Integer.parseInt(request.getParameter("studentID"));
            StudentMark mark = markDAO.getMarkByStudentID(studentID);
            
            if (mark != null) {
                request.setAttribute("studentMark", mark);
                request.setAttribute("found", true);
            } else {
                request.setAttribute("message", "Student not found!");
                request.setAttribute("messageType", "error");
                request.setAttribute("found", false);
            }
        }
        
        request.getRequestDispatcher("markupdate.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int studentID = Integer.parseInt(request.getParameter("studentID"));
            String studentName = request.getParameter("studentName");
            String subject = request.getParameter("subject");
            int marks = Integer.parseInt(request.getParameter("marks"));
            Date examDate = Date.valueOf(request.getParameter("examDate"));
            
            StudentMark studentMark = new StudentMark(studentID, studentName, subject, marks, examDate);
            
            if (markDAO.updateMark(studentMark)) {
                request.setAttribute("message", "Student mark updated successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to update student mark. Please try again.");
                request.setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher("markupdate.jsp").forward(request, response);
    }
}