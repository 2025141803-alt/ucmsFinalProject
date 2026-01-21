
<%@ page import="com.uniclubs.model.User" %>

<%
    // Get user from session (same as sidebar)
    User headerUser = (User) session.getAttribute("user");
    String userRole = (headerUser != null) ? headerUser.getRole() : "";
%>

<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: Arial, sans-serif; }

    .topbar {
        position: fixed;
        top: 0; left: 0; right: 0;
        height: 60px;
        background: #4c502d;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 20px;
        z-index: 100;
    }

    .menu-btn {
        background: none;
        border: none;
        cursor: pointer;
    }

    .menu-btn img {
        width: 25px;
        height: 25px;
    }

    .logo img {
        height: 120px;
        object-fit: contain;
        margin-top: 15px;
    }

    .top-icons {
        display: flex;
        align-items: center;
        gap: 18px;
    }

    .icon-btn img {
        width: 26px;
        height: 26px;
        cursor: pointer;
    }

    body.sidebar-closed #sidebar-container {
        width: 0 !important;
        padding: 0 !important;
        overflow: hidden;
    }

    .content {
        margin-left: 220px;
        padding-top: 80px;
        transition: margin-left 0.3s ease;
    }

    body.sidebar-closed .content {
        margin-left: 0;
    }
</style>

<header class="topbar">
    <button id="toggleSidebar" class="menu-btn">
        <img src="${pageContext.request.contextPath}/images/LineForHeader.png" alt="Toggle Sidebar">
    </button>

    <div class="logo">
        <img src="${pageContext.request.contextPath}/images/logoUCMS.png" alt="UCMS Logo">
    </div>

    <nav class="top-icons">
    <%-- 1. Notifications Link --%>
    <a href="${pageContext.request.contextPath}/<%= "staff".equalsIgnoreCase(userRole) ? "manageNotifications" : "studentNotifications" %>" class="icon-btn">
        <img src="${pageContext.request.contextPath}/images/notificationsWhite.png">
    </a>

    <%-- 2. Profile Link (Usually same for both) --%>
    <a href="${pageContext.request.contextPath}/myProfile.jsp" class="icon-btn">
        <img src="${pageContext.request.contextPath}/images/profileWhite.png">
    </a>

    <%-- 3. Logout Link (Passes the 'from' parameter for your dynamic cancel button) --%>
    <a href="${pageContext.request.contextPath}/logout.jsp?from=<%= "staff".equalsIgnoreCase(userRole) ? "staffDashboard" : "home" %>" class="icon-btn">
        <img src="${pageContext.request.contextPath}/images/logoutWhite.png">
    </a>
</nav>
</header>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("toggleSidebar");
    if (btn) {
        btn.addEventListener("click", function () {
            document.body.classList.toggle("sidebar-closed");
        });
    }
});
</script>
