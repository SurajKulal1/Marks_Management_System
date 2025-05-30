<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student Marks | Student Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a56d4;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --white: #ffffff;
            --gray: #6c757d;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            background-color: #f5f7fa;
            color: var(--dark);
            padding: 0;
            margin: 0;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .form-card {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 40px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .header p {
            color: var(--gray);
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 40px;
            color: var(--gray);
            font-size: 1rem;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
            transition: var(--transition);
            background-color: var(--light);
            appearance: none;
            -webkit-appearance: none;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus,
        select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        input[type="number"] {
            padding-right: 15px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: var(--primary);
            color: var(--white);
            padding: 14px;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            margin-top: 25px;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .back-link i {
            margin-right: 8px;
            transition: var(--transition);
        }

        .back-link:hover {
            color: var(--primary-dark);
        }

        .back-link:hover i {
            transform: translateX(-3px);
        }

        .message {
            padding: 15px;
            border-radius: var(--border-radius);
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
            border-left: 4px solid var(--success);
        }

        .error {
            background-color: rgba(247, 37, 133, 0.1);
            color: #be123c;
            border-left: 4px solid var(--danger);
        }

        /* Custom dropdown arrow */
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
            color: var(--gray);
        }

        /* Responsive adjustments */
        @media (max-width: 576px) {
            .form-card {
                padding: 30px 20px;
            }
            
            .header h1 {
                font-size: 1.7rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-card">
            <div class="header">
                <h1><i class="fas fa-plus-circle"></i> Add Student Marks</h1>
                <p>Enter new student examination records</p>
            </div>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="message <%= request.getAttribute("messageType") %>">
                    <i class="fas <%= "success".equals(request.getAttribute("messageType")) ? "fa-check-circle" : "fa-exclamation-circle" %>"></i>
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <form action="AddMarkServlet" method="post">
                <div class="form-group">
                    <label for="studentID">Student ID</label>
                    <i class="fas fa-id-card input-icon"></i>
                    <input type="number" id="studentID" name="studentID" required placeholder="Enter student ID">
                </div>
                
                <div class="form-group">
                    <label for="studentName">Student Name</label>
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" id="studentName" name="studentName" required placeholder="Enter student name">
                </div>
                
                <div class="form-group">
                    <label for="subject">Subject</label>
                    <i class="fas fa-book input-icon"></i>
                    <div class="select-wrapper">
                        <select id="subject" name="subject" required>
                            <option value="" disabled selected>Select a subject</option>
                            <option value="Cloud Computing">Cloud Computing</option>
                            <option value="Advance Java">Advance Java</option>
                            <option value="Machine Learning">Machine Learning</option>
                            <option value="Renewable Energy">Renewable Energy</option>
                            <option value="Indian Knowledge System">Indian Knowledge System</option>
                            <option value="React">React</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="marks">Marks (0-100)</label>
                    <i class="fas fa-percent input-icon"></i>
                    <input type="number" id="marks" name="marks" min="0" max="100" required placeholder="Enter marks">
                </div>
                
                <div class="form-group">
                    <label for="examDate">Exam Date</label>
                    <i class="fas fa-calendar-alt input-icon"></i>
                    <input type="date" id="examDate" name="examDate" required>
                </div>
                
                <input type="submit" value="Add Student Marks">
            </form>
            
            <a href="index.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>
</body>
</html>