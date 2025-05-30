<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Reports - Student Marks Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .report-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .report-section h3 {
            color: #555;
            margin-top: 0;
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back-link:hover {
            background-color: #545b62;
        }
        .description {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Generate Reports</h1>
        
        <!-- Report 1: Students with marks above threshold -->
        <div class="report-section">
            <h3>1. Students with Marks Above Threshold</h3>
            <p class="description">Find all students who scored above a specific marks threshold.</p>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="above_threshold">
                <div class="form-group">
                    <label for="threshold">Minimum Marks:</label>
                    <input type="number" id="threshold" name="threshold" min="0" max="100" required 
                           placeholder="Enter minimum marks (e.g., 80)">
                </div>
                <input type="submit" value="Generate Report">
            </form>
        </div>
        
        <!-- Report 2: Students by subject -->
        <div class="report-section">
            <h3>2. Students by Subject</h3>
            <p class="description">View all students who appeared for a specific subject examination.</p>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="by_subject">
                <div class="form-group">
                    <label for="subject">Subject:</label>
                    <select id="subject" name="subject" required>
                        <option value="">Select Subject</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Physics">Physics</option>
                        <option value="Chemistry">Chemistry</option>
                        <option value="Biology">Biology</option>
                        <option value="English">English</option>
                        <option value="History">History</option>
                        <option value="Geography">Geography</option>
                        <option value="Computer Science">Computer Science</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="custom_subject">Or Enter Custom Subject:</label>
                    <input type="text" id="custom_subject" name="custom_subject" 
                           placeholder="Enter subject name if not in dropdown">
                </div>
                <input type="submit" value="Generate Report">
            </form>
        </div>
        
        <!-- Report 3: Top N students -->
        <div class="report-section">
            <h3>3. Top Performers</h3>
            <p class="description">Get the top N students based on their marks (highest to lowest).</p>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="top_students">
                <div class="form-group">
                    <label for="topN">Number of Top Students:</label>
                    <input type="number" id="topN" name="topN" min="1" max="100" required 
                           placeholder="Enter number (e.g., 10)" value="10">
                </div>
                <div class="form-group">
                    <label for="filter_subject">Filter by Subject (Optional):</label>
                    <select id="filter_subject" name="filter_subject">
                        <option value="">All Subjects</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Physics">Physics</option>
                        <option value="Chemistry">Chemistry</option>
                        <option value="Biology">Biology</option>
                        <option value="English">English</option>
                        <option value="History">History</option>
                        <option value="Geography">Geography</option>
                        <option value="Computer Science">Computer Science</option>
                    </select>
                </div>
                <input type="submit" value="Generate Report">
            </form>
        </div>
        
        <!-- Report 4: Statistical Summary -->
        <div class="report-section">
            <h3>4. Statistical Summary</h3>
            <p class="description">Get statistical information about marks (average, highest, lowest, etc.).</p>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="statistics">
                <div class="form-group">
                    <label for="stats_subject">Subject (Optional):</label>
                    <select id="stats_subject" name="stats_subject">
                        <option value="">All Subjects</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Physics">Physics</option>
                        <option value="Chemistry">Chemistry</option>
                        <option value="Biology">Biology</option>
                        <option value="English">English</option>
                        <option value="History">History</option>
                        <option value="Geography">Geography</option>
                        <option value="Computer Science">Computer Science</option>
                    </select>
                </div>
                <input type="submit" value="Generate Report">
            </form>
        </div>
        
        <a href="index.jsp" class="back-link">← Back to Main Menu</a>
    </div>
    
    <script>
        // Auto-fill custom subject when selected from dropdown
        document.getElementById('subject').addEventListener('change', function() {
            if (this.value) {
                document.getElementById('custom_subject').value = '';
            }
        });
        
        document.getElementById('custom_subject').addEventListener('input', function() {
            if (this.value) {
                document.getElementById('subject').value = '';
            }
        });
    </script>
</body>
</html>