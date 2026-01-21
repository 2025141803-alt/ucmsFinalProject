<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Activities</title>
    <!-- Import Roboto font from Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Roboto', 'Poppins', sans-serif;
            background-color: #f6f5ef;
            padding: 20px;
            margin-top: 80px; /* Add space for fixed header */
        }
        
        .back-btn {
            background-color: transparent;
            border: none;
            color: #333;
            font-size: 18px;
            cursor: pointer;
            padding: 10px 20px;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            color: #6f7645;
        }

        /* The Darker Green Outer Box (matches activities.jsp) */
        .detail-container {
            background-color: #6f7645;
            border-radius: 25px;
            padding: 30px;
            max-width: 900px;
            margin: 0 auto;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-top: 20px; /* Additional space from top */
        }

        /* Title styling */
        .activity-title {
            color: #ffffff;
            font-size: 24px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .activity-subtitle {
            color: #e8f5e8;
            font-size: 14px;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Activity content box */
        .activity-content {
            background-color: #8b925f; /* Lighter olive green - matches activity cards */
            border-radius: 20px;
            padding: 30px;
            color: white;
        }
        
        /* Table styling */
        .activities-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .activities-table thead th {
            background-color: rgba(255, 255, 255, 0.1);
            color: #e8f5e8;
            padding: 15px;
            text-align: left;
            font-size: 14px;
            text-transform: uppercase;
            font-weight: bold;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
        }
        
        .activities-table tbody tr {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .activities-table tbody tr:last-child {
            border-bottom: none;
        }
        
        .activities-table tbody td {
            padding: 15px;
            color: white;
            font-size: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .activities-table tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }
        
        /* Status Badges */
        .status { 
            padding: 6px 15px; 
            border-radius: 20px; 
            font-size: 12px; 
            font-weight: bold;
            display: inline-block;
        }
        .status-present { 
            background: #d4edda; 
            color: #155724; 
        }
        .status-absent { 
            background: #f8d7da; 
            color: #721c24; 
        }
        .status-pending { 
            background: #fff3cd; 
            color: #856404; 
        }
        
        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #e8f5e8;
            font-size: 16px;
        }
        
        .leave-btn {
    background-color: transparent;
    color: #f8d7da;
    border: 1px solid #f8d7da;
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
}

.leave-btn:hover {
    background-color: #721c24;
    color: white;
    border-color: #721c24;
}

/* Adjust table to fit new column */
.activities-table th, .activities-table td {
    text-align: center; /* Centering often looks better with actions */
}
    </style>
</head>
<body>
    <%@ include file="sidebar.jsp" %>
    <%@ include file="header.jsp" %>
    
    <div class="detail-container">
        <div class="activity-title">My Activity Participation</div>
        <div class="activity-subtitle">Track your attendance for joined activities below.</div>
        
       <c:if test="${param.msg == 'joinSuccess'}">
        <div style="background: rgba(212, 237, 218, 0.9); 
                    color: #155724; 
                    padding: 15px; 
                    border-radius: 15px; 
                    margin-bottom: 25px; 
                    text-align: center; 
                    font-weight: bold; 
                    border: 1px solid #c3e6cb;">
            Successfully joined! Your activity has been added to the list below.
        </div>
    </c:if>
        
        <c:if test="${param.msg == 'leaveSuccess'}">
    <div style="background: rgba(248, 215, 218, 0.9); color: #721c24; padding: 15px; border-radius: 15px; margin-bottom: 25px; text-align: center; font-weight: bold; border: 1px solid #f5c6cb;">
        You have successfully left the activity.
    </div>
</c:if>
        <div class="activity-content">
            <table class="activities-table">
    <thead>
        <tr>
            <th>Activity Name</th>
            <th>Date</th>
            <th>Attendance Status</th>
            <th>Action</th> </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${joinedList}">
            <tr>
                <td><strong>${item.activityName}</strong></td> 
                <td>${item.joinDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${item.role == 'PRESENT'}">
                            <span class="status status-present">PRESENT</span>
                        </c:when>
                        <c:when test="${item.role == 'ABSENT'}">
                            <span class="status status-absent">ABSENT</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status status-pending">PENDING</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
    <form action="LeaveActivityServlet" method="POST" onsubmit="return confirm('Remove this activity?');">
        <input type="hidden" name="activityId" value="${item.activityId}">
        <button type="submit" class="leave-btn">Leave</button>
    </form>
</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
        </div>
    </div>

</body>
</html>