<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile | ${student.name}</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f7f6; display: flex; justify-content: center; padding: 120px 20px; }
        .profile-card { background: white; width: 420px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; }
        .header-bg { background: #f6c23e; height: 100px; } /* Yellow header for Edit mode */
        .profile-img { width: 120px; height: 120px; border-radius: 50%; border: 6px solid white; margin: -60px auto 15px auto; display: block; background: #fff; }
        .info-section { padding: 0 35px; text-align: left; }
        .info-item { margin-bottom: 15px; }
        .label { color: #aaa; font-size: 10px; font-weight: 700; text-transform: uppercase; }
        
        /* Style for the input boxes */
        .edit-input { 
            width: 100%; 
            padding: 10px; 
            margin-top: 5px; 
            border: 1px solid #ddd; 
            border-radius: 8px; 
            font-size: 14px; 
            box-sizing: border-box; 
        }
        .btn-save { background: #1cc88a; color: white; width: 100%; padding: 12px; border: none; border-radius: 10px; font-weight: 600; cursor: pointer; margin-top: 20px; }
    </style>
</head>
<body>

<div class="profile-card">
    <div class="header-bg"></div>
    <img src="https://ui-avatars.com/api/?name=${student.name}&background=random" class="profile-img">
    
    <h2 style="text-align:center;">Edit Mode</h2>

    <form action="updateMember" method="POST" class="info-section">
        <input type="hidden" name="userId" value="${student.userId}">

        <div class="info-item">
            <div class="label">Full Name</div>
            <input type="text" name="name" value="${student.name}" class="edit-input" readonly style="background:#f9f9f9;">
        </div>

        <div class="info-item">
            <div class="label">Email Address</div>
            <input type="email" name="email" value="${student.email}" class="edit-input" required>
        </div>

        <div class="info-item">
            <div class="label">Faculty</div>
            <input type="text" name="faculty" value="${student.faculty}" class="edit-input">
        </div>

        <div class="info-item">
            <div class="label">Contact Number</div>
            <input type="text" name="phone" value="${student.phone}" class="edit-input">
        </div>

        <button type="submit" class="btn-save">Save Changes</button>
        <a href="viewMember?id=${student.userId}" style="display:block; text-align:center; margin-top:15px; color:#888; text-decoration:none; font-size:13px;">Cancel</a>
    </form>
</div>

</body>
</html>