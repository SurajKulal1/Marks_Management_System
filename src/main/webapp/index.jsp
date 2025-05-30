<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Marks Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --info: #4895ef;
            --white: #ffffff;
            --border-radius: 8px;
            --box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Inter', sans-serif;
            /* Changed body background to a slightly lighter frost color */
            background-color: #f0f5f8; /* A subtle, cool-toned off-white */
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 700px;
            margin: 0 auto;
        }

        .header {
            background: var(--primary);
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .header h1 {
            font-size: 1.5rem;
            margin: 0;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            padding: 20px;
            /* Menu grid background remains the "frost" color */
            background: #e6ecf0; /* A light, cool-toned gray/blue for a frost effect */
            border-radius: 0 0 var(--border-radius) var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .menu-item {
            background: var(--white); /* Individual menu items still white for contrast */
            border-radius: var(--border-radius);
            padding: 30px 20px;
            text-align: center;
            box-shadow: var(--box-shadow);
            border-top: 4px solid var(--primary);
            transition: transform 0.2s ease;
            min-height: 120px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-decoration: none; /* This removes the underline */
            color: inherit; /* Ensures text color consistency */
        }

        .menu-item:hover {
            transform: translateY(-3px);
        }

        .menu-item i {
            font-size: 2.2rem;
            color: var(--primary);
            margin-bottom: 15px;
            text-decoration: none; /* Additional safeguard */
        }

        .menu-item h3 {
            font-size: 1.1rem;
            margin: 0;
            text-decoration: none; /* Additional safeguard */
        }

        .add { border-top-color: var(--success); }
        .update { border-top-color: var(--info); }
        .delete { border-top-color: var(--danger); }
        .view { border-top-color: var(--warning); }
        .report { 
            grid-column: 1 / -1; /* Spans from the first column line to the last */
            border-top-color: var(--primary);
        }

        @media (max-width: 600px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }
            .report {
                grid-column: 1 / -1;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <h1>Student Marks Management System</h1>
        </div>
        
        <div class="menu-grid">
            <a href="AddMarkServlet" class="menu-item add">
                <i class="fas fa-plus-circle"></i>
                <h3>Add Marks</h3>
            </a>
            
            <a href="UpdateMarkServlet" class="menu-item update">
                <i class="fas fa-edit"></i>
                <h3>Update Marks</h3>
            </a>
            
            <a href="DeleteMarkServlet" class="menu-item delete">
                <i class="fas fa-trash-alt"></i>
                <h3>Delete Marks</h3>
            </a>
            
            <a href="DisplayMarksServlet" class="menu-item view">
                <i class="fas fa-search"></i>
                <h3>View Marks</h3>
            </a>
            
            <a href="ReportServlet" class="menu-item report">
                <i class="fas fa-chart-bar"></i>
                <h3>Generate Reports</h3>
            </a>
        </div>
    </div>
</body>
</html>