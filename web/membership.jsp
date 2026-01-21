<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.uniclubs.model.User" %>
<%@ page import="com.uniclubs.model.Membership" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Registered Clubs</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">


    <style>
        body {
            margin: 0;
            padding: 30px;
            font-family: 'Poppins', sans-serif;
            background-color: #ffff;
        }

        .content { margin-top: 10px; }

        h1 {
            font-size: 22px;
            letter-spacing: 1px;
            margin-bottom: 25px;
            color: #000;
        }

        .clubs-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .club-card {
            background-color: #e8d8c1;
            border-radius: 20px;
            padding: 25px 20px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease;
        }

        .club-card:hover { transform: translateY(-5px); }

        .club-card h2 {
            font-size: 16px;
            margin-bottom: 20px;
            font-weight: bold;
            color: #000;
        }

        body.sidebar-closed #sidebar-container {
            width: 0 !important;
            padding: 0 !important;
            overflow: hidden;
        }

        .club-logo {
            width: 90px;
            height: 90px;
            object-fit: contain;
            margin-bottom: 20px;
        }

        .club-info {
            font-size: 14px;
            color: #333;
            line-height: 1.6;
        }

        .empty-msg {
            background: #fff3cd;
            border: 1px solid #ffeeba;
            padding: 12px;
            border-radius: 10px;
            color: #856404;
            max-width: 600px;
        }
        
        /* Updated button container */
        .button-container {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center; /* Center buttons */
        }

        /* Updated button styles - same size for both */
        .btn-view {
            display: inline-block;
            background-color: #3f4a1c;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            font-weight: bold;
            font-size: 14px;
            width: 120px; /* Fixed width for both buttons */
            box-sizing: border-box;
        }

        .btn-leave {
            background-color: #d9534f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            width: 120px; /* Fixed width for both buttons */
            box-sizing: border-box;
        }

        .btn-leave:hover { background-color: #c9302c; }
        .btn-view:hover { background-color: #2d3614; }
        
        /* Form styling to match button size */
        .leave-form {
            display: inline-block;
            width: 120px; /* Same width as buttons */
            margin: 0;
        }
    </style>
</head>

<body>

<div id="sidebar">
    <%@ include file="sidebar.jsp" %>
</div>

<div id="header">
    <%@ include file="header.jsp" %>
</div>

<div class="content">
    <h1>MY REGISTERED CLUBS</h1>

    <%
        java.util.List<com.uniclubs.model.Membership> membershipList =
                (java.util.List<com.uniclubs.model.Membership>) session.getAttribute("membershipList");
    %>

    <div class="clubs-container">
        <%
    if (membershipList == null || membershipList.isEmpty()) {
%>
    <div class="empty-msg">
        You have not joined any clubs yet. Go to <a href="viewAllClubs">Clubs</a> to join one.
    </div>
<%
    } else {
        for (com.uniclubs.model.Membership m : membershipList) {
%>
    <div class="club-card">
        <img src="${pageContext.request.contextPath}/getImage?name=<%= m.getLogoPath() %>" 
             class="club-logo" alt="Logo"
             onerror="this.src='images/default-logo.png';">
             
        <h2><%= m.getClubName() %></h2>
        
        <div class="club-info">
            <p><strong>Date Joined:</strong> <%= m.getJoinDate() %></p>
            <p><strong>Member Type:</strong> <%= m.getRole() %></p>
        </div>

        <div class="button-container">
            <a href="viewClubDetail?clubId=<%= m.getClubId() %>" class="btn-view">
                View Club
            </a>

            <form action="MembershipServlet" method="POST" class="leave-form" 
                  onsubmit="return confirm('Are you sure you want to leave <%= m.getClubName() %>?');">
                <input type="hidden" name="action" value="leave">
                <input type="hidden" name="clubId" value="<%= m.getClubId() %>">
                <button type="submit" class="btn-leave">Leave Club</button>
            </form>
        </div>
        </div>
<%
        } // End of For Loop
    } // End of Else
%>
    </div> </div> ```

<script>
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('status') === 'left') {
        alert("You have successfully left the club.");
    }
</script>
</body>
</html>