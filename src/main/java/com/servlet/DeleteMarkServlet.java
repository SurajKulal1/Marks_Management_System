package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteMarkServlet")
public class DeleteMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;

    public void init() {
        markDAO = new MarkDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Handle search action
        if ("search".equals(action)) {
            String studentIDParam = request.getParameter("studentID");
            if (studentIDParam == null || studentIDParam.trim().isEmpty()) {
                request.setAttribute("message", "Student ID cannot be empty for search.");
                request.setAttribute("messageType", "error");
                request.setAttribute("found", false); // Explicitly set to false if search ID is empty
            } else {
                try {
                    int studentID = Integer.parseInt(studentIDParam);
                    StudentMark mark = markDAO.getMarkByStudentID(studentID);

                    if (mark != null) {
                        request.setAttribute("studentMark", mark);
                        request.setAttribute("found", true);
                        request.setAttribute("message", "Student record found."); // Optional success message
                        request.setAttribute("messageType", "success");
                    } else {
                        request.setAttribute("message", "Student with ID " + studentID + " not found!");
                        request.setAttribute("messageType", "error");
                        request.setAttribute("found", false);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("message", "Invalid Student ID format for search. Please enter a valid number.");
                    request.setAttribute("messageType", "error");
                    request.setAttribute("found", false);
                    System.err.println("NumberFormatException in DeleteMarkServlet doGet (search): " + e.getMessage());
                }
            }
        }
        // If no action or invalid action, just forward to display the page
        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String studentIDParam = request.getParameter("studentID");

            if (studentIDParam == null || studentIDParam.trim().isEmpty()) {
                request.setAttribute("message", "Student ID cannot be empty for deletion.");
                request.setAttribute("messageType", "error");
            } else {
                int studentID = Integer.parseInt(studentIDParam);

                if (markDAO.deleteMark(studentID)) {
                    request.setAttribute("message", "Student mark for ID " + studentID + " deleted successfully!");
                    request.setAttribute("messageType", "success");
                    request.setAttribute("found", false); // Reset found status after successful deletion
                    request.removeAttribute("studentMark"); // Clear student data after deletion
                } else {
                    // This else block might be hit if the studentID doesn't exist in DB even if parsed
                    request.setAttribute("message", "Failed to delete student mark for ID " + studentID + ". Student may not exist or an error occurred.");
                    request.setAttribute("messageType", "error");
                    // Keep existing studentMark data if available, to re-display it for failed delete attempts
                    // For example, if the ID was valid but delete failed due to DB issue.
                    // If you want to clear it always on failed delete, add request.removeAttribute("studentMark");
                }
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid Student ID format for deletion. Please enter a valid number.");
            request.setAttribute("messageType", "error");
            System.err.println("NumberFormatException in DeleteMarkServlet doPost: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("message", "An unexpected error occurred during deletion: " + e.getMessage());
            request.setAttribute("messageType", "error");
            System.err.println("Error in DeleteMarkServlet doPost: " + e.getMessage());
            e.printStackTrace();
        }

        // Always forward back to markdelete.jsp to display the message and/or updated state
        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }
}