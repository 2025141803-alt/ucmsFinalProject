<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activities</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f6f5ef;
        }

        .layout { display: flex; }

        .main-content {
            margin-left: 250px; /* Adjust based on your sidebar width */
            flex: 1;
            padding: 40px;
            margin-top: 60px; /* Adjust based on your header height */
            transition: margin-left 0.3s ease;
        }

        /* The Darker Green Outer Box */
        .activities-box {
            background-color: #6f7645;
            border-radius: 25px;
            padding: 30px;
            max-width: 900px;
            margin: 0 auto;
        }

        .activities-title {
            color: #ffffff;
            font-size: 20px;
            margin-bottom: 25px;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* The Individual Activity Cards (Matches image_6bd52a.png) */
        .activity-card {
            background-color: #8b925f; /* Lighter olive green */
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            color: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .activity-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 12px;
        }

        .activity-info {
            font-size: 14px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 15px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .icon {
            width: 18px;
            height: 18px;
            object-fit: contain;
            filter: brightness(0) invert(1); /* Makes black icons white */
        }

        /* View Details Button (White) */
        .activity-btn {
            padding: 8px 20px;
            background-color: #ffffff;
            color: #6f7645;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 13px;
            font-weight: bold;
        }

        .activity-btn:hover {
            background-color: #e0e0e0;
        }

        /* Handle Sidebar Toggle */
        body.sidebar-closed .main-content { margin-left: 0; }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>
    <%@ include file="header.jsp" %>

    <div class="layout">
        <div class="main-content">
            <div class="activities-box">
                <div class="activities-title">UPCOMING ACTIVITIES</div>

                <c:choose>
    <%-- Change activitiesList to activities to match your Servlet --%>
    <c:when test="${not empty activities}">
        <c:forEach var="a" items="${activities}">
            <div class="activity-card">
                <div class="activity-name">${a.name}</div>

                <div class="activity-info">
                    <div class="info-item">
                        <img src="images/calendar.png" class="icon" alt="date">
                        <span>${a.date}</span>
                    </div>
                    <div class="info-item">
                        <img src="images/location.png" class="icon" alt="location">
                        <span>${a.venue}</span>
                    </div>
                </div>

                <%-- Keeping your button exactly as requested --%>
                <button class="activity-btn" onclick="location.href='ActivityDetailServlet?id=${a.id}'">
                    View Details
                </button>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <p style="color: white; text-align: center;">No upcoming activities found.</p>
    </c:otherwise>
</c:choose>

            </div>
        </div>
    </div>

</body>
</html>