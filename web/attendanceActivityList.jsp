<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Activity for Attendance</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #556B2F; padding: 120px 20px; font-family: sans-serif; }
        .container { background: white; border-radius: 15px; padding: 30px; max-width: 900px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #eee; text-align: left; }
        .btn-manage { 
            background: #3D441E; 
            color: white; 
            padding: 8px 15px; 
            text-decoration: none; 
            border-radius: 5px; 
            font-size: 13px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Select Activity to Mark Attendance</h2>
    <table>
        <thead>
            <tr>
                <th>Activity Name</th>
                <th>Date</th>
                <th>Venue</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="act" items="${activities}">
                <tr>
                    <td><strong>${act.name}</strong></td>
                    <td>${act.date}</td>
                    <td>${act.venue}</td>
                    <td>
                        <a href="manageAttendance?activityId=${act.id}" class="btn-manage">Manage Attendees</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>