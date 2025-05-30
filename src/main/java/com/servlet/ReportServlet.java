package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
// Removed iText imports as PDF generation is removed
// import com.itextpdf.text.*;
// import com.itextpdf.text.pdf.PdfPCell;
// import com.itextpdf.text.pdf.PdfPTable;
// import com.itextpdf.text.pdf.PdfWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
// Removed ByteArrayOutputStream, IOException related to PDF
// import java.io.ByteArrayOutputStream;
import java.io.IOException;
// import java.io.OutputStream;
import java.util.Collections;
// import java.util.Comparator; // Not needed if statistics are removed
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MarkDAO markDAO;

    /**
     * Initializes the servlet and the MarkDAO.
     */
    @Override
    public void init() throws ServletException {
        super.init();
        markDAO = new MarkDAO();
    }

    /**
     * Handles GET requests.
     * Only used for directing to the reports JSP in this streamlined version.
     * PDF download action is removed.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // The "download" action is removed.
        // Direct to reports.jsp for displaying report options or just go home if direct access.
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    /**
     * Handles POST requests.
     * Used for generating various types of student reports based on user selection.
     * Statistics calculation and PDF session storage are removed.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        List<StudentMark> reportData = null;
        String reportTitle = "";
        // Removed totalStudents variable as it's no longer displayed on JSP
        // int totalStudents = 0;

        try {
            switch (reportType) {
                case "above_marks":
                    String thresholdStr = request.getParameter("threshold");
                    if (thresholdStr == null || thresholdStr.trim().isEmpty()) {
                        throw new NumberFormatException("Marks threshold cannot be empty.");
                    }
                    int threshold = Integer.parseInt(thresholdStr);
                    reportData = markDAO.getStudentsAboveMarks(threshold);
                    reportTitle = "Students with Marks Above " + threshold;
                    break;

                case "by_subject":
                    String subject = request.getParameter("subject");
                    if (subject == null || subject.trim().isEmpty()) {
                        throw new IllegalArgumentException("Subject name cannot be empty.");
                    }
                    reportData = markDAO.getStudentsBySubject(subject);
                    reportTitle = "Students Who Scored in " + subject;
                    break;

                case "top_students":
                    String limitStr = request.getParameter("limit");
                    if (limitStr == null || limitStr.trim().isEmpty()) {
                        throw new NumberFormatException("Number of top students cannot be empty.");
                    }
                    int limit = Integer.parseInt(limitStr);
                    reportData = markDAO.getTopStudents(limit);
                    reportTitle = "Top " + limit + " Students";
                    break;

                default:
                    request.setAttribute("message", "Invalid report type selected. Please choose a valid report option.");
                    request.setAttribute("messageType", "error"); // Set message type for error
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
            }

            // Removed statistics calculation
            // int maxMarks = 0;
            // String topStudent = "N/A";
            // if (reportData != null && !reportData.isEmpty()) {
            //     StudentMark maxMarkStudent = Collections.max(reportData, Comparator.comparingInt(StudentMark::getMarks));
            //     maxMarks = maxMarkStudent.getMarks();
            //     topStudent = maxMarkStudent.getStudentName();
            //     totalStudents = reportData.size();
            // }

            // Removed storing report data and statistics in session for PDF generation
            // HttpSession session = request.getSession();
            // session.setAttribute("reportData", reportData);
            // session.setAttribute("reportTitle", reportTitle);
            // session.setAttribute("maxMarks", maxMarks);
            // session.setAttribute("topStudent", topStudent);
            // session.setAttribute("totalStudents", totalStudents);

            // Set attributes for the JSP to display the report results on the web page
            request.setAttribute("reportData", reportData);
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("message", "Report generated successfully!"); // Success feedback
            request.setAttribute("messageType", "success"); // Set message type for success

            // Removed setting statistics attributes if they are not displayed
            // request.setAttribute("maxMarks", maxMarks);
            // request.setAttribute("topStudent", topStudent);
            // request.setAttribute("totalStudents", totalStudents);

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid numeric input for threshold or limit. Please enter a valid number.");
            request.setAttribute("messageType", "error");
            System.err.println("NumberFormatException in ReportServlet doPost: " + e.getMessage());
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            request.setAttribute("message", e.getMessage());
            request.setAttribute("messageType", "error");
            System.err.println("IllegalArgumentException in ReportServlet doPost: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("message", "Error generating report: " + e.getMessage());
            request.setAttribute("messageType", "error");
            System.err.println("Error in ReportServlet doPost: " + e.getMessage());
            e.printStackTrace();
        }

        // Always forward to report_result.jsp to display the generated report or error
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }

    // Removed the entire generatePdfReport method and helper methods (addTableHeader, addTableCell)
    // private void generatePdfReport(...) {...}
    // private void addTableHeader(...) {...}
    // private void addTableCell(...) {...}
}