<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>My Notifications</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
    /* 1. Main Content Wrapper */
    .content {
        margin-left: 220px;       /* Starts at sidebar width */
        padding: 20px;
        padding-top: 100px;       /* Gap for the top header */
        transition: margin-left 0.3s ease; 
        min-height: 100vh;
        background-color: white;
    }

    /* 2. Notification Cards */
    .notification-card {
        background-color: #e8d8c1;
        border-radius: 12px;
        padding: 20px;
        display: flex;
        align-items: flex-start;
        gap: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        border: 1px solid #eee;
        margin-bottom: 15px;
    }

    /* 3. Logic when sidebar is closed */
    body.sidebar-closed .content {
        margin-left: 0 !important; /* Forces content to full width */
    }

    /* Slide the actual sidebar container off-screen */
    body.sidebar-closed #sidebar-container {
        transform: translateX(-220px);
        transition: transform 0.3s ease;
    }

    /* 4. Text and Icons */
    .notif-icon { width: 32px; height: 32px; object-fit: contain; }
    .notif-header { font-weight: 700; font-size: 17px; color: #000; }
    .notif-time { font-size: 13px; color: #595959; font-weight: bold; }
</style>
</head>
<body style="background-color: white; margin: 0; padding: 0;">

    <%@ include file="sidebar.jsp" %>
    <%@ include file="header.jsp" %>

    <div class="content">
        <div class="container" style="padding: 40px; max-width: 900px; margin: 0 auto;">
            <h1 style="color: #3D441E; margin-bottom: 25px;">Notifications</h1>

        <c:choose>
            <%-- Use 'notifications' to match the attribute name set in your Servlet --%>
            <c:when test="${not empty notifications}">
                <c:forEach var="n" items="${notifications}">
                    <div class="notification-card">
                        <div class="notif-icon-wrapper">
                            <img src="images/calendar.png" class="notif-icon" alt="icon">
                        </div>
                        <div class="notif-content">
                            <div class="notif-header">
                                ${n.type == 'activity' ? 'New Event Added' : 'Club Update'}
                            </div>
                            <div class="notif-body" style="color: #333; margin: 5px 0;">${n.message}</div>
                            <div class="notif-time">
                                <fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="text-align: center; color: white;">No new notifications.</p>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>