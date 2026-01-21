<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // SESSION PROTECTION
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>UCMS Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        
        body { margin:0; font-family:'Poppins'; background:#f4f2ee; }
        .content { margin-left: 220px; margin-top: 10px; padding: 20px; }
        .banner { 
            background: linear-gradient(rgba(0,0,0,0.25), rgba(0,0,0,0.25)), url("images/Backgroundhijau.png");
            background-size: cover; background-position: center; padding: 35px 40px; border-radius: 14px; 
            display: flex; justify-content: space-between; align-items: center;
        }
        .banner h2 { font-family: "Brush Script MT", cursive; font-size: 34px; margin: 0; color: #2f341c; }
        .main-layout { display: grid; grid-template-columns: 3fr 1.2fr; gap: 25px; margin-top: 30px; }
        .section-title { font-weight: bold; margin-bottom: 15px; }
        .clubs { display: flex; flex-wrap: wrap; gap: 20px; }
        .club { background: #e8d8c1; border-radius: 14px; padding: 18px; width: 30%; box-sizing: border-box; }
        .club img { width: 80px; height: 80px; object-fit: contain; display: block; margin: 10px auto; }
        .club h4 { font-size: 14px; text-align: center; margin: 10px 0; height: 32px; overflow: hidden; }
        .club .info { text-align: center; font-size: 13px; color: #555; margin-bottom: 12px; }
        .upcoming { background: #3f4a1c; border-radius: 14px; padding: 18px; color: white; min-height: 360px; }
        .upcoming h4 { margin-top: 0; font-size: 14px; border-bottom: 1px solid rgba(255,255,255,.3); padding-bottom: 8px; }
        .cards { display: flex; gap: 20px; }
        .card { background: #e8d8c1; border-radius: 12px; padding: 20px 24px; flex: 1; box-shadow: 0 4px 10px rgba(0,0,0,0.08); }
        .card-title { color: #555; font-size: 14px; font-weight: 600; }
        .card h3 { font-size: 42px; margin: 10px 0; }
        .stat-link { color: #3f4a1c; font-size: 14px; text-decoration: none; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />

    <div class="content">
        <div class="banner">
            <h2>Shape Your Future with<br>Active Club Participation</h2>
        </div>

        <div class="cards" style="margin-top: 20px;">
            <div class="card">
                <p class="card-title">Join Club Now!</p>
                <h3>${totalClubs}</h3>
                <a href="viewAllClubs" class="stat-link">View Clubs</a>
            </div>
            <div class="card">
                <p class="card-title">Registered Club</p>
                <h3>${registeredClubs}</h3>
                <a href="MembershipServlet" class="stat-link">View My Memberships</a>
            </div>
        </div>

        <div class="main-layout">
            <div>
                <div class="section-title">MY REGISTERED CLUBS</div>
                <div class="clubs">
                    <c:choose>
                        <c:when test="${not empty registeredClubsList}">
                            <c:forEach var="club" items="${registeredClubsList}">
                                <div class="club">
                                    <h4>${club.clubName}</h4>
                                   <img src="getImage?name=${club.logoPath}" alt="${club.clubName}" style="width:80px; height:80px; object-fit:contain;">
                                    <div class="info">
                                        ${club.membershipCount} Students<br>
                                        Active Member
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p>You haven't joined any clubs yet.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="upcoming">
    <h4>UPCOMING ACTIVITIES</h4>
    <ul style="padding-left: 20px; margin-top: 10px;">
        <c:choose>
            <c:when test="${not empty activitiesList}">
                <c:forEach var="activity" items="${activitiesList}">
                    <li style="margin-bottom: 12px; list-style-type: disc;">
                        <strong style="font-size: 14px;">${activity.name}</strong><br>
                        <span style="font-size: 12px; opacity: 0.9;">
                            ${activity.date} | ${activity.clubName}
                        </span>
                    </li>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <li style="list-style-type: none; margin-left: -20px;">
                    No upcoming activities found.
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>
        </div>
    </div>
</body>
</html>