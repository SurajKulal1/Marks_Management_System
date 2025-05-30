<%@ page import="java.util.List" %>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 900px; margin: 30px auto; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .report-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .report-table th, .report-table td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .report-table th { background-color: #f2f2f2; font-weight: bold; }
        .report-table tbody tr:nth-child(even) { background-color: #f9f9f9; }
        .report-table tbody tr:hover { background-color: #e9e9e9; }
        .no-results { text-align: center; color: #666; margin-top: 20px; padding: 15px; border: 1px dashed #ccc; background-color: #fcfcfc; border-radius: 5px;}

        /* Message Styling (consistent with other JSPs) */
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            font-size: 0.95rem;
        }
        .message i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        .success {
            background-color: rgba(76, 201, 240, 0.1);
            color: #0e7490;
            border-left: 4px solid #4cc9f0;
        }
        .error {
            background-color: rgba(247, 37, 133, 0.1);
            color: #be123c;
            border-left: 4px solid #f72585;
        }

        .back-link { display: block; text-align: center; margin-top: 25px; color: #007bff; text-decoration: none; font-size: 1.1em; }
        .back-link:hover { text-decoration: underline; }
        .action-links { display: flex; justify-content: space-around; margin-top: 20px; }
        /* Removed .statistics and .download-btn CSS as they are no longer needed */
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <%
            // Retrieve attributes set by ReportServlet
            String reportTitle = (String) request.getAttribute("reportTitle");
            List<StudentMark> reportData = (List<StudentMark>) request.getAttribute("reportData");
            String message = (String) request.getAttribute("message"); // General message from ReportServlet
            String messageType = (String) request.getAttribute("messageType"); // "success" or "error"

            // Removed retrieval of maxMarks, topStudent, totalStudents as they are no longer displayed
            // Integer maxMarks = (Integer) request.getAttribute("maxMarks");
            // String topStudent = (String) request.getAttribute("topStudent");
            // Integer totalStudents = (Integer) request.getAttribute("totalStudents");

            // Provide default values if attributes are null (e.g., if direct access without report generation)
            if (reportTitle == null) reportTitle = "Student Report Results";
            if (reportData == null) reportData = java.util.Collections.emptyList();
        %>

        <%-- Display messages (success or error) --%>
        <% if (message != null && !message.isEmpty()) { %>
            <div class="message <%= (messageType != null && messageType.equals("success")) ? "success" : "error" %>">
                <i class="fas <%= (messageType != null && messageType.equals("success")) ? "fa-check-circle" : "fa-exclamation-circle" %>"></i>
                <%= message %>
            </div>
        <% } %>

        <h2><%= reportTitle %></h2>

        <% if (!reportData.isEmpty()) { %>
            <%-- Removed the statistics div --%>

            <table class="report-table">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Subject</th>
                        <th>Marks</th>
                        <th>Exam Date</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (StudentMark mark : reportData) { %>
                        <tr>
                            <td><%= mark.getStudentID() %></td>
                            <td><%= mark.getStudentName() %></td>
                            <td><%= mark.getSubject() %></td>
                            <td><%= mark.getMarks() %></td>
                            <td><%= mark.getExamDate() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <%-- Removed the PDF download button --%>
        <% } else { %>
            <p class="no-results">No data found for the selected report criteria.</p>
        <% } %>

        <div class="action-links">
            <a href="reports.jsp" class="back-link"><i class="fas fa-chart-bar"></i> Generate Another Report</a>
            <a href="index.jsp" class="back-link"><i class="fas fa-home"></i> Back to Home</a>
        </div>
    </div>
</body>
</html>