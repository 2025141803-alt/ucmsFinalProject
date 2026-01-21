<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Change "clubList" to "studentClub" here to match your Servlet
    java.util.List<com.uniclubs.model.Club> clubs =
            (java.util.List<com.uniclubs.model.Club>) request.getAttribute("studentClub");

    if (clubs != null && !clubs.isEmpty()) {
        for (com.uniclubs.model.Club c : clubs) {
%>
<%
        }
    } else {
%>
    <p>No clubs found.</p>
<%
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Clubs</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">


    <style>
        body {
            margin: 0;
            font-family: 'Poppins';
            background: #f3f3f3;
        }

        .content {
            margin-left: 220px;
            margin-top: 20px;
            padding: 20px;
            transition: margin-left .3s ease;
        }

        body.sidebar-closed #sidebar-container {
            width: 0 !important;
            padding: 0 !important;
            overflow: hidden;
        }

        body.sidebar-closed .content {
            margin-left: 0 !important;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding: 8px 35px 8px 12px;
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
        }

        .search-box span {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .clubs-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .club-card {
            background: #e8d8c1;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .club-logo {
            width: 100%;
            height: 120px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .club-logo img {
            max-width: 90%;
            max-height: 90%;
        }

        .club-card h3 {
            font-size: 14px;
            margin: 5px 0 10px;
        }

        .club-info {
            font-size: 13px;
            color: #555;
            margin-bottom: 10px;
        }

        .club-info div {
            margin-bottom: 5px;
        }

        .icon {
            width: 25px;
            height: 25px;
            margin-right: 6px;
            vertical-align: middle;
        }

        .search-icon {
            width: 16px;
            height: 16px;
        }

        button {
            background: #4c502d;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            align-self: flex-end;
            font-size: 12px;
        }
    </style>
</head>

<body>

<!-- Include sidebar n header using JSP include -->
<div id="sidebar">
    <%@ include file="sidebar.jsp" %>
</div>

<div id="header">
    <%@ include file="header.jsp" %>
</div>

<div class="content">

    <div class="top-bar">
        <h2>All Clubs</h2>

        <div class="search-box">
            <input type="text" placeholder="Search Club">
            <span>
                <img src="images/search.png" class="search-icon" alt="search">
            </span>
        </div>
    </div>

<div class="clubs-container">
    <%
        java.util.List<com.uniclubs.model.Club> studentClubsList = 
                (java.util.List<com.uniclubs.model.Club>) request.getAttribute("studentClub");

        if (studentClubsList != null && !studentClubsList.isEmpty()) {
            for (com.uniclubs.model.Club c : studentClubsList) {
    %>
        <div class="club-card">
            <div class="club-logo">
                <img src="getImage?name=<%= c.getLogoPath() %>" 
                     alt="club logo" 
                     onerror="this.src='images/kelab1.png';">
            </div>

            <h3><%= c.getClubName() %></h3>

            <div class="club-info">
                <div>
                    <img src="images/student.png" class="icon" alt="students">
                    <%= c.getMembershipCount() %> Students
                </div>
                <div>
                    <img src="images/calendar.png" class="icon" alt="calendar">
                    Upcoming Activities
                </div>
            </div>

            <button onclick="window.location.href='viewClubDetail?clubId=<%= c.getClubId() %>'">
    VIEW
</button>
        </div>
    <%
            }
        } else {
    %>
        <p>No clubs found.</p>
    <%
        }
    %>
</div>

</body>
</html>
