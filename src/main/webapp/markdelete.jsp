<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student Marks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"], button { /* Added button for flexibility, though submit is used */
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        .search-btn {
            background-color: #28a745;
            color: white;
        }
        .search-btn:hover {
            background-color: #1e7e34;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
            width: auto; /* Allow delete button to size naturally */
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center; /* Center the message text */
            font-weight: bold; /* Make messages bold */
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .search-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .student-info {
            background-color: #e6f7ee; /* Lighter green for student info, consistent with reports criteria input */
            padding: 20px;
            border-radius: 5px;
            border: 1px dashed #a0d9b4; /* Dashed border for consistency */
            margin-bottom: 20px;
        }
        .student-info p {
            margin: 5px 0;
            font-size: 1.05em;
            color: #333;
        }
        .student-info p strong {
            color: #007bff; /* Highlight info */
        }
        /* Removed .warning CSS */
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Delete Student Marks</h1>
        </div>

        <%-- Message Display --%>
        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && !message.isEmpty()) {
        %>
            <div class="message <%= (messageType != null && (messageType.equals("success") || messageType.equals("error"))) ? messageType : "" %>">
                <%= message %>
            </div>
        <% } %>

        <div class="search-section">
            <h3>Search Student to Delete</h3>
            <form action="DeleteMarkServlet" method="get">
                <input type="hidden" name="action" value="search">
                <div class="form-group">
                    <label for="searchStudentID">Enter Student ID:</label>
                    <input type="number" id="searchStudentID" name="studentID" required placeholder="e.g., 101" value="<%= request.getParameter("studentID") != null ? request.getParameter("studentID") : "" %>">
                </div>
                <input type="submit" value="Search" class="search-btn">
            </form>
        </div>

        <%
            Boolean found = (Boolean) request.getAttribute("found");
            StudentMark studentMark = (StudentMark) request.getAttribute("studentMark");

            // Only display student info and delete button if found is true and studentMark exists
            if (found != null && found && studentMark != null) {
        %>
            <div class="student-info">
                <h3>Student Details Found:</h3>
                <p><strong>Student ID:</strong> <%= studentMark.getStudentID() %></p>
                <p><strong>Student Name:</strong> <%= studentMark.getStudentName() %></p>
                <p><strong>Subject:</strong> <%= studentMark.getSubject() %></p>
                <p><strong>Marks:</strong> <%= studentMark.getMarks() %></p>
                <p><strong>Exam Date:</strong> <%= studentMark.getExamDate() %></p>
            </div>

            <form action="DeleteMarkServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this record for Student ID <%= studentMark.getStudentID() %>? This action cannot be undone.');">
                <input type="hidden" name="studentID" value="<%= studentMark.getStudentID() %>">
                <input type="submit" value="Delete Record" class="delete-btn">
            </form>
        <% } %>

        <a href="index.jsp" class="back-link">← Back to Main Menu</a>
    </div>
</body>
</html>