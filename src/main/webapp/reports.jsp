<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Student Reports</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 600px; margin: 30px auto; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input[type="text"], input[type="number"], select {
            width: calc(100% - 20px); /* Adjusted to match padding and border correctly */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        button {
            background-color: #6f42c1; /* Matching the reports button on index.jsp */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 17px;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        button:hover { background-color: #563d7c; }
        .criteria-input {
            display: none; /* Hidden by default */
            margin-top: 15px;
            padding: 15px;
            border: 1px dashed #a0d9b4;
            border-radius: 8px;
            background-color: #e6f7ee;
        }
        .message { color: #dc3545; text-align: center; margin-bottom: 15px; font-weight: bold; } /* For errors from ReportServlet */
        .back-link { display: block; text-align: center; margin-top: 20px; color: #007bff; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Generate Student Reports</h2>

        <%-- Display error message if any, from ReportServlet --%>
        <%-- Note: The ReportServlet now sends "message" and "messageType" attributes.
             If you want to display success messages too, you'll need a similar structure
             to report_result.jsp to check messageType. For now, matching your existing errorMessage logic. --%>
        <% String message = (String) request.getAttribute("message"); // Changed from "errorMessage" to "message" based on ReportServlet %>
        <% if (message != null && !message.isEmpty()) { %>
            <p class="message error-message"><%= message %></p>
        <% } %>

        <form action="ReportServlet" method="post"> <%-- Use POST for report form submission --%>
            <div class="form-group">
                <label for="reportType">Select Report Type:</label>
                <select id="reportType" name="reportType" onchange="showCriteriaInput()">
                    <option value="">-- Select a Report --</option>
                    <option value="above_marks">Students with Marks Above Threshold</option>
                    <option value="by_subject">Students Marks in a Specific Subject</option>
                    <option value="top_students">Top N Students by Marks</option>
                </select>
            </div>

            <%-- Input fields for each report type, initially hidden --%>
            <div id="above_marks_input" class="criteria-input">
                <label for="threshold">Minimum Marks Threshold:</label>
                <input type="number" id="threshold" name="threshold" placeholder="e.g., 75" min="0" max="100">
            </div>

            <div id="by_subject_input" class="criteria-input">
                <label for="subject">Subject Name:</label>
                <%-- MODIFICATION STARTS HERE: Replaced input type="text" with select dropdown --%>
                <select id="subject" name="subject">
                    <option value="" disabled selected>Select a subject</option>
                    <option value="Cloud Computing">Cloud Computing</option>
                    <option value="Advance Java">Advance Java</option>
                    <option value="Machine Learning">Machine Learning</option>
                    <option value="Renewable Energy">Renewable Energy</option>
                    <option value="Indian Knowledge System">Indian Knowledge System</option>
                    <option value="React">React</option>
                </select>
                <%-- MODIFICATION ENDS HERE --%>
            </div>

            <div id="top_students_input" class="criteria-input">
                <label for="limit">Number of Top Students (N):</label>
                <input type="number" id="limit" name="limit" placeholder="e.g., 5" min="1">
            </div>

            <div class="form-group">
                <button type="submit">Generate Report</button>
            </div>
        </form>
        <a href="index.jsp" class="back-link">Back to Home</a>
    </div>

    <script>
        // JavaScript to show/hide criteria input fields based on report type selection
        function showCriteriaInput() {
            // Hide all criteria inputs first and clear their values
            document.querySelectorAll('.criteria-input').forEach(function(el) {
                el.style.display = 'none';
                // Clear input values
                el.querySelectorAll('input').forEach(input => input.value = '');
                // For select elements, reset them to the first option
                el.querySelectorAll('select').forEach(select => {
                    select.selectedIndex = 0; // Resets to the "-- Select a subject --" or "-- Select a Report --" option
                });
            });

            const reportType = document.getElementById('reportType').value;

            // Show the relevant input based on selected report type
            if (reportType === 'above_marks') {
                document.getElementById('above_marks_input').style.display = 'block';
            } else if (reportType === 'by_subject') {
                document.getElementById('by_subject_input').style.display = 'block';
            } else if (reportType === 'top_students') {
                document.getElementById('top_students_input').style.display = 'block';
            }
        }

        // Call on page load to set initial state
        document.addEventListener('DOMContentLoaded', showCriteriaInput);
    </script>
</body>
</html>