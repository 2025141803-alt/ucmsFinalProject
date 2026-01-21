<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notifications</title>
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 20px;
    }

    .notification-container {
        max-width: 800px;
        margin: 0 auto;
        display: flex;
        flex-direction: column; /* This forces them to stack vertically */
        gap: 15px; /* Adds space between the cards */
    }

    h2 {
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 25px;
    }

    /* The individual card */
    .notification-card {
        background-color: white;
        border-radius: 12px;
        padding: 20px;
        display: flex;
        align-items: flex-start;
        gap: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        border: 1px solid #eee;
        width: 100%; /* Ensure it takes full width of container */
        box-sizing: border-box;
    }

    .notif-icon {
        width: 32px;
        height: 32px;
        object-fit: contain;
    }

    .notif-content {
        flex-grow: 1;
    }

    .notif-header {
        font-weight: 700;
        font-size: 17px;
        color: #000;
        margin-bottom: 4px;
    }

    .notif-body {
        font-size: 15px;
        color: #333;
        margin-bottom: 6px;
        line-height: 1.4;
    }

    .notif-time {
    font-size: 13px;
    color: #595959; 
    font-weight: bold;
    display: block; /* Ensures it takes up its own space */
    margin-top: 5px;
}
</style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />

  <div class="notification-container">
    <h2>Notifications</h2>

    <c:forEach var="notif" items="${notifications}">
        <div class="notification-card">
            <div class="notif-icon-wrapper">
                <c:choose>
                    <c:when test="${notif.type == 'activity'}">
                        <img src="images/calendar.png" class="notif-icon" alt="Event">
                    </c:when>
                    <c:otherwise>
                        <img src="images/calendar.png" class="notif-icon" alt="Club">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="notif-content">
    <div class="notif-header">
        <c:choose>
            <c:when test="${notif.type == 'activity'}">New Event Added</c:when>
            <c:otherwise>Club Update</c:otherwise>
        </c:choose>
    </div>
    
    <div class="notif-body">${notif.message}</div>

    <div class="notif-time">
        <fmt:formatDate value="${notif.createdAt}" pattern="dd/MM/yyyy HH:mm" />
    </div>
</div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty notifications}">
        <p style="text-align: center; color: #888; margin-top: 50px;">No new notifications.</p>
    </c:if>
</div>

</body>
</html>