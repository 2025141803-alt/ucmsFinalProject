<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Activity Detail</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #f6f5ef;
            padding: 20px;
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

        /* Activity content box */
        .activity-content {
            background-color: #8b925f; /* Lighter olive green - matches activity cards */
            border-radius: 20px;
            padding: 30px;
            color: white;
        }

        /* Information items styling - UPDATED FOR SIDE-BY-SIDE */
        .info-section {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .info-label {
            font-weight: bold;
            color: #e8f5e8;
            font-size: 14px;
            text-transform: uppercase;
            width: 100px; /* Fixed width for labels */
        }

        .info-value {
            font-size: 18px;
            color: white;
            flex: 1; /* Takes remaining space */
        }

        hr.divider {
            border: 0;
            height: 1px;
            background-color: rgba(255,255,255,0.3);
            margin: 30px 0;
        }

        /* Button container */
        .button-container {
            margin-top: 30px;
            text-align: center; /* Center the buttons */
        }

        /* Add space between buttons */
        .staff-button {
            margin-bottom: 15px;
        }
        
        .join-form {
            margin-bottom: 15px;
        }

        /* Alert message styling */
        .alert-message {
            background: rgba(255, 243, 205, 0.9);
            color: #856404;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid #ffeeba;
            text-align: center;
            font-weight: 500;
            max-width: 900px;
            margin: 0 auto 25px auto;
        }
         body.sidebar-closed .content { margin-left: 0; }
    </style>
</head>
<body>

     <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />
    
    <div class="content">
 

   
<c:if test="${isJoined}">
    <div class="alert-message">
        You are already a participant of this activity.
    </div>
</c:if>

    <div class="detail-container">
        <div class="activity-title">${activity.name}</div>
        
        <div class="activity-content">
            <div class="info-section">
                <div class="info-label">Date:</div>
                <div class="info-value">${activity.date}</div>
            </div>
            
            <div class="info-section">
                <div class="info-label">Time:</div>
                <div class="info-value">${activity.time}</div>
            </div>
            
            <div class="info-section">
                <div class="info-label">Venue:</div>
                <div class="info-value">${activity.venue}</div>
            </div>
            
            <div class="info-section">
                <div class="info-label">Club:</div>
                <div class="info-value">${activity.clubName}</div>
            </div>

            <hr class="divider">

            <%-- Button Logic --%>
          <div class="button-container">
    <c:choose>
        <%-- 1. Check the 'isJoined' attribute sent by ActivityDetailServlet --%>
        <c:when test="${isJoined == true}">
            <div style="text-align: center; margin-top: 20px;">
                <div style="background: #95a5a6; color: white; padding: 12px 25px; border-radius: 20px; font-size: 14px; font-weight: bold; display: inline-block;">
                    ALREADY A PARTICIPANT
                </div>
                <p style="color: #e8f5e8; font-size: 12px; margin-top: 10px; font-style: italic;">
                    Check your attendance status in 'My Joined Activities'
                </p>
            </div>
        </c:when>

        <%-- 2. If 'isJoined' is false, show the Join button --%>
        <c:otherwise>
            <div class="join-form" style="text-align: center; margin-top: 20px;">
                <form action="JoinActivityServlet" method="POST" style="margin: 0;">
                    <input type="hidden" name="activityId" value="${activity.id}">
                    <button type="submit" 
                            style="background: #ffffff; color: #6f7645; border: none; padding: 12px 40px; border-radius: 20px; font-size: 14px; font-weight: bold; cursor: pointer; transition: 0.3s;">
                        JOIN ACTIVITY NOW!
                    </button>
                </form>
            </div>
        </c:otherwise>
    </c:choose>
</div>
        </div>
    </div>
 </div>
</body>
</html>