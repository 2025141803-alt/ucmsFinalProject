<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', 'Poppins', sans-serif;
            background: #f4f7f6;
            margin: 0;
            padding: 20px;
        }

        /* Dashboard Layout */
        .dashboard-content {
            margin-left: 260px; /* Adjust based on your sidebar width */
            margin-top: 80px;  /* Adjust based on your header height */
            padding: 20px;
        }

        /* Welcome Text */
        .welcome-header {
            margin-bottom: 30px;
        }
        .welcome-header h1 {
            font-size: 24px;
            color: #2c3e50;
            margin: 0;
        }
        .date-display {
            color: #7f8c8d;
            font-size: 14px;
        }

        /* Stat Boxes Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border-left: 5px solid #0a6ed1;
        }
        .stat-card.clubs { border-color: #3498db; }
        .stat-card.activities { border-color: #2ecc71; }
        .stat-card.notifications { border-color: #9b59b6; }

        .stat-label {
            color: #95a5a6;
            font-size: 13px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .stat-value {
            display: block;
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
            margin-top: 10px;
        }

        /* Membership Table Section */
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
        .table-container h2 {
            font-size: 18px;
            margin-bottom: 20px;
            color: #34495e;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            text-align: left;
            background: #f8f9fa;
            padding: 12px;
            color: #7f8c8d;
            font-size: 14px;
            border-bottom: 2px solid #edf2f7;
        }
        td {
            padding: 15px 12px;
            border-bottom: 1px solid #edf2f7;
            font-size: 14px;
            color: #2c3e50;
        }

        /* Action Buttons */
        .btn-view {
            background: #2ecc71;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            margin-right: 5px;
        }
        .btn-delete {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-view:hover {
    background: #27ae60;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.btn-delete:hover {
    background: #c0392b;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* Optional: Make the table rows highlight on hover */
tbody tr:hover {
    background-color: #fcfcfc;
}

 

        /* Sidebar Toggle Logic */
        body.sidebar-closed .dashboard-content { margin-left: 20px; }
    </style>
</head>
<body>

<jsp:include page="sidebar.jsp" />
<jsp:include page="header.jsp" />

<div class="dashboard-content">
    <div class="welcome-header">
        <h1>Welcome, ${sessionScope.user.name}!</h1>
        <span class="date-display">Date: <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></span>
    </div>

    <div class="stats-grid">
        <div class="stat-card clubs">
            <span class="stat-label">Total Clubs</span>
            <span class="stat-value">${totalClubs != null ? totalClubs : 0}</span>
        </div>
        <div class="stat-card activities">
            <span class="stat-label">Total Activities</span>
            <span class="stat-value">${totalActivities != null ? totalActivities : 0}</span>
        </div>
        <div class="stat-card notifications">
            <span class="stat-label">Total Notifications</span>
            <span class="stat-value">${totalNotifications != null ? totalNotifications : 0}</span>
        </div>
    </div>

    <div class="table-container">
        <h2>Student Membership List (Clubs)</h2>
        
        
        
        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Club Name</th>
                    <th>Join Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${membershipList}">
                    <tr>
                        <td>${m.studentName}</td>
                        <td>${m.clubName}</td>
                        <td>${m.joinDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${m.studentId % 2 == 0}">
                                    <span style="background: #e8f5e9; color: #2e7d32; padding: 5px 12px; border-radius: 15px; font-weight: bold; font-size: 12px; display: inline-block; min-width: 90px; text-align: center;">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="background: #ffebee; color: #c62828; padding: 5px 12px; border-radius: 15px; font-weight: bold; font-size: 12px; display: inline-block; min-width: 90px; text-align: center;">Non-Active</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="viewMember?id=${m.studentId}" class="btn-view">View</a>
                            
                            <form action="staffDashboard" method="POST" style="display:inline;" onsubmit="return confirm('Remove student from membership?');">
                                <input type="hidden" name="action" value="deleteByStaff">
                                <input type="hidden" name="membershipId" value="${m.membershipId}">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty membershipList}">
                    <tr><td colspan="5" style="text-align:center;">No student memberships found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="table-container" style="margin-top: 30px;">
        <h2>Manage Activity Attendance</h2>
        <table>
            <thead>
                <tr>
                    <th>Activity Name</th>
                    <th>Date</th>
                    <th>Venue</th>
                    <th>Mark Attendance</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="act" items="${activityList}">
    <tr>
        <td>${act.name}</td>
        <td>${act.date}</td>
        <td>${act.venue}</td>
        <td>
            <form action="updateAttendance" method="POST" style="display: flex; gap: 5px;">
    <input type="hidden" name="activityId" value="${act.id}">

    <select name="studentId" required style="padding: 4px; border-radius: 4px;">
        <option value="">-- Select Student --</option>
        <c:forEach var="signup" items="${activitySignupList}">
            <c:if test="${signup.activityId == act.id}">
                <option value="${signup.studentId}">${signup.studentName}</option>
            </c:if>
        </c:forEach>
    </select>

    <select name="status">
        <option value="PRESENT">Present</option>
        <option value="ABSENT">Absent</option>
    </select>

    <button type="submit" class="btn-update">Update</button>
</form>
        </td>
    </tr>
</c:forEach>
                <c:if test="${empty activityList}">
                    <tr><td colspan="4" style="text-align:center;">No activities scheduled.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<script>
    // Sidebar toggle script (as per your existing logic)
    const btn = document.getElementById("toggleSidebar");
    if (btn) {
        btn.addEventListener("click", function () {
            document.body.classList.toggle("sidebar-closed");
        });
    }
</script>

</body>
</html>