<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.uniclubs.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp?msg=please_login");
        return;
    }
    // IMPORTANT: This line makes ${user.profilePic} work!
    pageContext.setAttribute("user", user);
    
    String role = user.getRole();
    boolean isStudent = "student".equalsIgnoreCase(role);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile | UniClubs</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f4f2; margin: 0; padding: 100px; }
        .profile-container { max-width: 900px; margin: 0 auto; background: #ffffff; padding: 40px; border-radius: 12px; border: 8px solid #9fa38d; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .alert-box { display: none; padding: 15px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 8px; margin-bottom: 20px; text-align: center; font-weight: bold; }
        h2 { border-bottom: 1px solid #eee; padding-bottom: 10px; color: #444; }
        .section-header { font-weight: bold; font-size: 18px; color: #555; margin: 30px 0 15px 0; }
        .profile-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px 40px; }
        .input-group { display: flex; flex-direction: column; margin-bottom: 10px; }
        .input-group label { font-size: 14px; font-weight: 600; margin-bottom: 8px; }
        .input-group input { padding: 12px; border: 1px solid #ddd; border-radius: 6px; background-color: #fcfcfc; }
        .readonly-field { background-color: #f0f0f0 !important; color: #888; border: 1px solid #eee; }
        .save-container { display: flex; justify-content: flex-end; margin-top: 30px; }
        .save-btn { background-color: #9fa38d; color: white; border: none; padding: 12px 45px; border-radius: 5px; font-weight: bold; cursor: pointer; }

.content {
    margin-left: 220px;       /* Space for the sidebar when open */
    transition: margin-left 0.3s ease; /* Smooth sliding effect */
    padding: 100px 20px;      /* Your original 100px padding for top/bottom */
    min-height: 100vh;
}

/* 2. Logic when sidebar is closed */
    /* 3. Logic when sidebar is closed */
    body.sidebar-closed .content {
        margin-left: 0 !important; /* Forces content to full width */
    }

    /* Slide the actual sidebar container off-screen */
    body.sidebar-closed #sidebar-container {
        transform: translateX(-220px);
        transition: transform 0.3s ease;
    }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />
    
    <div class="content">
<div class="profile-container">
    <div id="successAlert" class="alert-box">Profile changes saved successfully!</div>

    <form action="UserServlet" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action" value="updateProfile">
        <input type="hidden" name="user_id" value="<%= user.getUserId() %>">

        <h2>Edit Profile</h2>

        <div class="section-header">Profile Picture</div>
        <div style="display: flex; align-items: center; gap: 20px;">
            <img src="${pageContext.request.contextPath}/getImage?name=${user.profilePic}" 
                 class="profile-pic" 
                 alt="Profile"
                 style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 2px solid #9fa38d;"
                 onerror="this.src='${pageContext.request.contextPath}/images/profile.png';">
                 
            <input type="file" name="profilePic" accept="image/*" onchange="previewImage(this)">
        </div>

        <div class="section-header">Personal Details</div>
        <div class="profile-grid">
            <div class="input-group">
                <label>Full Name</label>
                <input type="text" name="name" value="<%= user.getName() %>" required>
            </div>
            <div class="input-group">
                <label><%= isStudent ? "Student ID" : "Staff ID" %></label>
                <input type="text" value="<%= user.getUserId() %>" class="readonly-field" readonly>
            </div>
        </div>

        <div class="section-header">Contact Details</div>
        <div class="profile-grid">
            <div class="input-group">
                <label>Email Address</label>
                <input type="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            <div class="input-group">
                <label>Mobile Phone Number</label>
                <input type="text" name="phone" value="<%= (user.getPhone() != null) ? user.getPhone() : "" %>">
            </div>
        </div>

        <div class="save-container">
            <button type="submit" class="save-btn">Save Changes</button>
        </div>
    </form>
</div>

<script>
    // Handles the real-time image preview
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('.profile-pic').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    // Handles the success message
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('status') === 'success') {
        const alertBox = document.getElementById('successAlert');
        alertBox.style.display = 'block';
        setTimeout(() => { alertBox.style.display = 'none'; }, 4000);
    }
</script>

</div>
</body>
</html>