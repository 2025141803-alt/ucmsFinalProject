<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Attendance - UniClubs</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <style>
            body { font-family: 'Poppins', sans-serif; margin: 20px; background-color: #f4f7f6; }
            .container { max-width: 900px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
            h2 { color: #333; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
            th { background-color: #4e73df; color: white; }
            .btn { padding: 8px 12px; border-radius: 4px; text-decoration: none; color: white; font-size: 14px; margin-right: 5px; display: inline-block; }
            .btn-present { background-color: #1cc88a; }
            .btn-absent { background-color: #e74a3b; }
            .status { font-weight: bold; padding: 4px 8px; border-radius: 4px; text-transform: uppercase; }
            .status-PENDING { background: #f6c23e; color: white; }
            .status-PRESENT { background: #1cc88a; color: white; }
            .status-ABSENT { background: #e74a3b; color: white; }
            .alert { padding: 10px; margin-bottom: 20px; border-radius: 4px; color: white; font-weight: bold; }
            .alert-success { background-color: #1cc88a; }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Manage Attendance</h2>
            <p><strong>Activity ID:</strong> ${activityId}</p>

            <%-- Success Message Notification --%>
            <c:if test="${param.statusUpdated == 'true'}">
                <div class="alert alert-success">Attendance updated successfully!</div>
            </c:if>

            <hr>

            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${attendees}">
                        <tr>
                            <%-- Ensure your User model uses 'userId' --%>
                            <td>${student.userId}</td>
                            <td>${student.name}</td>
                            <td>
                                <%-- student.role is used to store the STATUS string from the DAO --%>
                                <span class="status status-${student.role}">${student.role}</span>
                            </td>
                            <td>
                                <%-- Links to UpdateAttendanceServlet --%>
                                <a href="UpdateAttendanceServlet?activityId=${activityId}&studentId=${student.userId}&status=PRESENT" 
                                   class="btn btn-present">Mark Present</a>
                                
                                <a href="UpdateAttendanceServlet?activityId=${activityId}&studentId=${student.userId}&status=ABSENT" 
                                   class="btn btn-absent">Mark Absent</a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty attendees}">
                        <tr>
                            <td colspan="4" style="text-align:center; padding: 30px; color: #888;">
                                No students have joined this activity yet.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            
            <br>
            <a href="staffDashboard.jsp" style="color: #4e73df; text-decoration: none;">← Back to Dashboard</a>
        </div>
    </body>
</html>