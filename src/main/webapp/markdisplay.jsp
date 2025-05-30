<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentMark" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Student Marks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1000px;
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
        .search-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="number"] {
            width: 200px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .view-all-btn {
            background-color: #28a745;
        }
        .view-all-btn:hover {
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .student-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            border: 1px solid #dee2e6;
            margin-bottom: 20px;
        }
        .no-data {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Display Student Marks</h1>
        </div>
        
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <!-- Search Section -->
        <div class="search-section">
            <h3>Search Options</h3>
            <form action="DisplayMarksServlet" method="get" style="display: inline-block;">
                <input type="hidden" name="action" value="search">
                <div class="form-group">
                    <label for="studentID">Search by Student ID:</label>
                    <input type="number" id="studentID" name="studentID" placeholder="Enter Student ID">
                </div>
                <input type="submit" value="Search">
            </form>
            
            <form action="DisplayMarksServlet" method="get" style="display: inline-block; margin-left: 20px;">
                <input type="submit" value="View All Students" class="view-all-btn">
            </form>
        </div>
        
        <!-- Search Result (Single Student) -->
        <% 
            Boolean searchResult = (Boolean) request.getAttribute("searchResult");
            StudentMark studentMark = (StudentMark) request.getAttribute("studentMark");
            if (searchResult != null && searchResult && studentMark != null) { 
        %>
        <h3>Search Result</h3>
        <div class="student-card">
            <h4>Student Information</h4>
            <p><strong>Student ID:</strong> <%= studentMark.getStudentID() %></p>
            <p><strong>Student Name:</strong> <%= studentMark.getStudentName() %></p>
            <p><strong>Subject:</strong> <%= studentMark.getSubject() %></p>
            <p><strong>Marks:</strong> <%= studentMark.getMarks() %></p>
            <p><strong>Exam Date:</strong> <%= studentMark.getExamDate() %></p>
        </div>
        <% } %>
        
        <!-- All Students Table -->
        <% 
            @SuppressWarnings("unchecked")
            List<StudentMark> allMarks = (List<StudentMark>) request.getAttribute("allMarks");
            if (allMarks != null) { 
        %>
        <h3>All Student Marks</h3>
        <% if (allMarks.isEmpty()) { %>
            <div class="no-data">
                No student records found.
            </div>
        <% } else { %>
        <table>
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
                <% for (StudentMark mark : allMarks) { %>
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
        <% } %>
        <% } %>
        
        <a href="index.jsp" class="back-link">← Back to Main Menu</a>
    </div>
</body>
</html>