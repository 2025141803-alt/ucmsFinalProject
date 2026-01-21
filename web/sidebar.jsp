
<%@ page import="com.uniclubs.model.User" %>



<%
    // 1. Get the full User object from the session
    User user = (User) session.getAttribute("user");

    // 2. Security Check
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // 3. Pull data from the user object
    String name = user.getName();
    String role = user.getRole();
    int userId = user.getUserId();
    String studentFaculty = user.getFaculty();
%>

<div id="sidebar-container" class="sidebar <%= role.toLowerCase() %>">
    <div class="profile-info">
        <%-- This uses the user object we defined at the top --%>
        <%-- Corrected Sidebar Image Logic --%>
<img src="${(user.profilePic != null && !user.profilePic.isEmpty()) 
           ? pageContext.request.contextPath.concat('/getImage?name=').concat(user.profilePic) 
           : pageContext.request.contextPath.concat('/images/default-user.png')}" 
     class="profile-pic-img" 
     alt="Profile Picture"
     onerror="this.src='${pageContext.request.contextPath}/images/profile.png';">

        <p class="name"><%= name %></p>

        <% if ("student".equalsIgnoreCase(role)) { %>
            <p class="id">ID: <%= userId %></p>
            <p class="faculty"><%= studentFaculty %></p>
        <% } else { %>
            <p class="id">Staff ID: <%= userId %></p>
        <% } %>
    </div>
 


  <% if ("student".equalsIgnoreCase(role)) { %>
    <a href="home">Dashboard</a>
    <a href="viewAllClubs">Clubs</a>
    <a href="MembershipServlet">My Membership</a>
    <a href="studentActivities">Upcoming Activities</a>
    <a href="myJoinedActivities">My Joined Activities</a> 
    <a href="viewPoints">My Points History</a>

<% } else if ("staff".equalsIgnoreCase(role)) { %>
    <a href="staffDashboard">Manage Dashboard</a>
    <a href="manageClub">Manage Clubs</a>
    <a href="manageActivities">Manage Activities</a>
    <a href="manageNotifications">Manage Notifications</a>
    <a href="myProfile.jsp">My Profile</a>
<% } %>

<div class="menu-item sidebar-logout">
    <% if ("staff".equalsIgnoreCase(role)) { %>
        <a href="logout.jsp?from=staffDashboard">Log Out</a>
    <% } else { %>
        <a href="logout.jsp?from=home">Log Out</a>
    <% } %>
</div>
</div>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
.sidebar {
    width: 220px;
    background: #b7bba8;
    height: 100vh;
    padding: 20px 0;
    position: fixed; /* Keep this as fixed to stay on screen */
    top: 60px;
    left: 0;
    display: flex;          /* ADD THIS */
    flex-direction: column; /* ADD THIS */
    font-family: 'Poppins', sans-serif;
    box-sizing: border-box; /* Ensures padding doesn't break the height */
}



.profile-pic-img {
    width: 70px;         /* Size of the circle */
    height: 70px;
    border-radius: 50%;  /* Makes it circular */
    object-fit: cover;   /* Prevents the image from stretching */
    display: block;      /* Allows centering with margin */
    margin: 10px auto;   /* Centers the image horizontally */
    border: 2px solid #3D441E; /* Matches your theme color */
}

.sidebar h3 {
    color: #3D441E !important;
    font-weight: bold;
    font-size: 15px;
    text-align: center;
    margin: 5px 0 2px;
}

.sidebar h3::after {
    content: "<%= role.equalsIgnoreCase("student") ? "Student" : "Staff" %>";
    display: block;
    font-size: 13px;
    font-weight: normal;
    color: #333;
    margin-top: 2px;
}

.sidebar a {
    display: block;
    color: #000;
    background-color: transparent;
    padding: 12px 12px 12px 45px;
    margin: 6px 0;
    border-radius: 8px;
    text-decoration: none;
    font-size: 15px;

    background-repeat: no-repeat;
    background-position: 12px center;
    background-size: 26px 26px;
}

.sidebar a:hover {
    background-color: #9fa38d;
}

    
.sidebar.student a[href="home"] {
    background-image: url("images/dashboard.png");
}


/* Icon for Staff Attendance Management */
.sidebar.staff a[href="attendanceList"] {
    background-image: url("images/activities.png");
}
.sidebar.student a[href="viewAllClubs"] {
    background-image: url("images/club.png");
}

.sidebar.student a[href="studentActivities"] {
    background-image: url("images/activities.png");
}
.sidebar.student a[href="studentNotifications"] {
    background-image: url("images/notifications.png");
}

.sidebar.student a[href="myProfile.jsp"] {
    background-image: url("images/profile.png");
}

.sidebar.student a[href="MembershipServlet"] {
    background-image: url("images/membership.png");
}


/* Icon for Student Points History */
.sidebar.student a[href="viewPoints"] {
    background-image: url("images/points.png"); /* Ensure you have a points.png in your images folder */
}
.sidebar.student a[href="myJoinedActivities"] {
    background-image: url("images/joinedActivities.png"); /* You can reuse activities icon or use a custom one */
}





.sidebar.staff a[href="staffDashboard"] {
    background-image: url("images/dashboard.png");
}

.sidebar.staff a[href="manageClub"] {
    background-image: url("images/club.png");
}

.sidebar.staff a[href="manageActivities"] {
    background-image: url("images/activities.png");
}

.sidebar.staff a[href="manageNotifications"] {
    background-image: url("images/notifications.png");
}







.sidebar a[href="myProfile.jsp"] {
    background-image: url("images/profile.png");
}

.sidebar a[href="logout.jsp"] {
    background-image: url("images/logout2.png");
}

.sidebar.collapsed {
    width: 60px;
}

.sidebar.collapsed a {
    font-size: 0;
}

.sidebar.collapsed h3,
.sidebar.collapsed h3::after {
    display: none;
}
.profile-info {
    text-align: center;
    margin-bottom: 20px;
}

.profile-pic {
    width: 60px;
    height: 60px;
    margin: 10px auto;
    border-radius: 50%;
    background-size: cover;
    background-position: center;
}

.profile-info .name {
    font-weight: bold;
    font-size: 15px;
    color: #3D441E;
}

.profile-info .id,
.profile-info .faculty {
    font-size: 13px;
    color: #333;
}

.sidebar-logout {
    margin-top: auto;   /* This pushes it to the very bottom */
    margin-bottom: 70px; /* Adjust this to account for the top: 60px offset */
}

/* Target the specific link inside for the color */
.sidebar-logout a {
    color: #ff4d4d !important; /* Forces the red color */
    font-weight: bold;
}
.sidebar-logout a:hover {
    color: #c0392b;         /* Darker red when mouse is over it */
}

/* Ensure the logout icon appears */
.sidebar-logout a {
    background-image: url("images/logout2.png");
    background-repeat: no-repeat;
    background-position: 12px center;
    background-size: 26px 26px;
    display: block;
    padding: 12px 12px 12px 45px;
}

</style>
