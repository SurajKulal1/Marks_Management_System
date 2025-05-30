package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DisplayMarksServlet")
public class DisplayMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;
    
    public void init() {
        markDAO = new MarkDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("search".equals(action)) {
            try {
                int studentID = Integer.parseInt(request.getParameter("studentID"));
                StudentMark mark = markDAO.getMarkByStudentID(studentID);
                
                if (mark != null) {
                    request.setAttribute("studentMark", mark);
                    request.setAttribute("searchResult", true);
                } else {
                    request.setAttribute("message", "Student not found!");
                    request.setAttribute("messageType", "error");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Please enter a valid Student ID!");
                request.setAttribute("messageType", "error");
            }
        } else {
            // Display all marks
            List<StudentMark> allMarks = markDAO.getAllMarks();
            request.setAttribute("allMarks", allMarks);
        }
        
        request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}