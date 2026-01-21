<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.uniclubs.model.Activity" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Activities</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f3f3f3;
            margin: 0;
        }

        .content {
            padding: 20px;
            margin-left: 250px;
            transition: margin-left 0.3s ease;
        }

        h2 {
            margin-bottom: 20px;
        }

        .create-btn {
            padding: 10px 20px;
            background-color: #6f7645;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 20px;
        }

        /* The Main Container (Olive Green) */
        .activities-box {
            background-color: #6f7645; /* Matches your screenshot */
            padding: 30px;
            border-radius: 25px; /* Large rounded corners */
            max-width: 600px; /* Centering the look */
            margin: 0 auto;
        }

        .box-header {
            color: white;
            font-weight: bold;
            font-size: 20px;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        /* The Individual Cards (Lighter Green) */
        .activity-card {
            background-color: #8b925f; /* Lighter olive */
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            color: white;
            position: relative;
        }

        .activity-name {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 12px;
        }

        .activity-info {
            font-size: 14px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 15px;
        }

      .info-icon {
    width: 18px;  /* Adjust size as needed */
    height: 18px;
    object-fit: contain;
    vertical-align: middle;
    margin-right: 8px;
}

.info-item {
    display: flex;
    align-items: center;
    margin-bottom: 5px;
}

        /* View Details Style Buttons (White) */
        .activity-btn {
            padding: 8px 18px;
            background-color: #fff;
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

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #f3f3f3;
            margin: 10% auto;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
        }

        .modal input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .close-btn {
            float: right;
            font-size: 18px;
            cursor: pointer;
        }

        .submit-btn {
            background-color: #6f7645;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
        }
        
        

        body.sidebar-closed .content { margin-left: 0; }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />
    
    <div class="content"> 
        <h2>Manage Activities</h2>
        <button class="create-btn" id="openModal">Create Activity</button>

        <div class="activities-box">
            <div class="box-header">Upcoming Activities</div>
            
            <c:forEach var="activity" items="${activities}">
                <div class="activity-card">
                    <div class="activity-name">${activity.name}</div>
                    
                    <div class="activity-info">
                        <div class="info-item">
                            <img src="${pageContext.request.contextPath}/images/calendar.png" class="info-icon" alt="date">
        <span>${activity.date} at ${activity.time}</span>
                        </div>
                        <div class="info-item">
                            <img src="${pageContext.request.contextPath}/images/location.png" class="info-icon" alt="location">
        <span>${activity.venue}</span>
                        </div>
                        <div class="info-item" style="font-style: italic; opacity: 0.9;">
                            Club: ${activity.clubName}
                        </div>
                    </div>

                    <div style="display:flex; gap:10px;">
                        <button class="activity-btn"
                            onclick="location.href='EditActivityServlet?id=${activity.id}'">
                            Edit Details
                        </button>

                        <button class="activity-btn" style="background-color: #ffeded; color: #a30000;"
                            onclick="if(confirm('Delete this activity?'))
                            location.href='DeleteActivityServlet?id=${activity.id}'">
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty activities}">
                <p style="color: white; text-align: center;">No activities available.</p>
            </c:if>
        </div>
    </div>

    <div id="activityModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" id="closeModal">&times;</span>
            <h3>Create Activity</h3>
            <form action="${pageContext.request.contextPath}/manageActivities" method="post">            
                <input type="text" name="name" placeholder="Activity Name" required>
                <input type="date" name="date" required>
                <input type="time" name="time" required>
                <input type="text" name="venue" placeholder="Venue" required>
                <input type="text" name="clubName" placeholder="Club Name" required>
                <input type="hidden" name="createdBy" value="Staff">
                <button type="submit" class="submit-btn">Create</button>
            </form>
        </div>
    </div>

    <script>
        const modal = document.getElementById("activityModal");
        const openBtn = document.getElementById("openModal");
        const closeBtn = document.getElementById("closeModal");

        openBtn.onclick = () => modal.style.display = "block";
        closeBtn.onclick = () => modal.style.display = "none";
        window.onclick = (event) => { if(event.target === modal) modal.style.display = "none"; };

        function toggleSidebar() {
            document.body.classList.toggle("sidebar-closed");
        }
    </script>
</body>
</html>