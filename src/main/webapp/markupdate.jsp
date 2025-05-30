<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentMark" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Student Marks</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        input[type="text"], 
        input[type="number"], 
        input[type="date"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            appearance: none;
            -webkit-appearance: none;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .search-btn {
            background-color: #28a745;
        }
        .search-btn:hover {
            background-color: #1e7e34;
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
        /* Custom dropdown styling */
        .select-wrapper {
            position: relative;
        }
        .select-wrapper::after {
            content: "\f078";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            pointer-events: none;
            color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Update Student Marks</h1>
        </div>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <!-- Search Section -->
        <div class="search-section">
            <h3>Search Student</h3>
            <form action="UpdateMarkServlet" method="get">
                <input type="hidden" name="action" value="search">
                <div class="form-group">
                    <label for="searchStudentID">Enter Student ID to Update:</label>
                    <input type="number" id="searchStudentID" name="studentID" required>
                </div>
                <input type="submit" value="Search" class="search-btn">
            </form>
        </div>
        
        <!-- Update Form -->
        <% 
            Boolean found = (Boolean) request.getAttribute("found");
            StudentMark studentMark = (StudentMark) request.getAttribute("studentMark");
            if (found != null && found && studentMark != null) { 
        %>
        <h3>Update Student Information</h3>
        <form action="UpdateMarkServlet" method="post">
            <div class="form-group">
                <label for="studentID">Student ID:</label>
                <input type="number" id="studentID" name="studentID" value="<%= studentMark.getStudentID() %>" readonly style="background-color: #e9ecef;">
            </div>
            
            <div class="form-group">
                <label for="studentName">Student Name:</label>
                <input type="text" id="studentName" name="studentName" value="<%= studentMark.getStudentName() %>" required>
            </div>
            
            <div class="form-group">
                <label for="subject">Subject:</label>
                <div class="select-wrapper">
                    <select id="subject" name="subject" required>
                        <option value="Cloud Computing" <%= studentMark.getSubject().equals("Cloud Computing") ? "selected" : "" %>>Cloud Computing</option>
                        <option value="Advance Java" <%= studentMark.getSubject().equals("Advance Java") ? "selected" : "" %>>Advance Java</option>
                        <option value="Machine Learning" <%= studentMark.getSubject().equals("Machine Learning") ? "selected" : "" %>>Machine Learning</option>
                        <option value="Renewable Energy" <%= studentMark.getSubject().equals("Renewable Energy") ? "selected" : "" %>>Renewable Energy</option>
                        <option value="Indian Knowledge System" <%= studentMark.getSubject().equals("Indian Knowledge System") ? "selected" : "" %>>Indian Knowledge System</option>
                        <option value="React" <%= studentMark.getSubject().equals("React") ? "selected" : "" %>>React</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="marks">Marks:</label>
                <input type="number" id="marks" name="marks" value="<%= studentMark.getMarks() %>" min="0" max="100" required>
            </div>
            
            <div class="form-group">
                <label for="examDate">Exam Date:</label>
                <input type="date" id="examDate" name="examDate" value="<%= studentMark.getExamDate() %>" required>
            </div>
            
            <div class="form-group">
                <input type="submit" value="Update Mark">
            </div>
        </form>
        <% } %>
        
        <a href="index.jsp" class="back-link">← Back to Main Menu</a>
    </div>
</body>
</html>