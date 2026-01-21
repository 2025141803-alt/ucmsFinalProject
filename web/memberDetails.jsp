<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile | ${student.name}</title>
    <style>
        /* General Setup */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: #f4f7f6; 
            display: flex; 
            justify-content: center; 
            align-items: flex-start;
            padding: 50px 20px; 
            margin: 0; 
        }

        /* Card Container */
        .profile-card { 
            background: white; 
            width: 420px; 
            border-radius: 20px; 
            box-shadow: 0 15px 35px rgba(0,0,0,0.1); 
            overflow: hidden; 
            text-align: center; 
            display: flex; 
            flex-direction: column; 
            padding-bottom: 30px;
        }

        /* Top Header Visual */
        .header-bg { background: #4e73df; height: 120px; width: 100%; }

        /* Profile Image Overlap */
        .profile-img { 
            width: 140px; 
            height: 140px; 
            border-radius: 50%; 
            border: 6px solid white; 
            margin: -70px auto 15px auto; 
            object-fit: cover; 
            background: #fff;
            display: block;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        /* Info Section Styling */
        .info-section { padding: 0 35px; text-align: left; }
        
        .info-item { 
            margin-bottom: 12px; 
            border-bottom: 1px solid #f0f0f0; 
            padding-bottom: 8px; 
        }
        
        .label { 
            color: #aaa; 
            font-size: 10px; 
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 1.2px; 
        }
        
        .value { 
            color: #2c3e50; 
            font-size: 15px; 
            margin-top: 4px; 
            font-weight: 500;
        }

        /* Button Styling */
        .button-group {
            padding: 20px 35px 0 35px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .btn {
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: block;
            text-align: center;
        }

        .btn-print { background: #1cc88a; color: white; }
        .btn-print:hover { background: #17a673; transform: translateY(-1px); }

        .btn-back { background: #4e73df; color: white; }
        .btn-back:hover { background: #2e59d9; transform: translateY(-1px); }

        /* Print Media Queries */
        @media print {
            body { background: white; padding: 0; }
            .btn, .header-bg { display: none !important; }
            .profile-card { 
                box-shadow: none; 
                border: 1px solid #ddd; 
                margin: 0 auto;
                width: 100%;
            }
            .profile-img { border: 2px solid #ddd; margin-top: 20px; }
        }
        body { 
    padding: 120px 20px 50px 20px; /* 120px pushes the card much lower */
}
    </style>
</head>

<body>
<div class="profile-card">
    <div class="header-bg"></div>
    
    <c:choose>
        <c:when test="${not empty student.profilePic}">
            <img src="getImage?name=${student.profilePic}" 
                 onerror="this.src='https://ui-avatars.com/api/?name=${student.name}&background=random'" 
                 class="profile-img">
        </c:when>
        <c:otherwise>
            <img src="https://ui-avatars.com/api/?name=${student.name}&background=random" 
                 class="profile-img">
        </c:otherwise>
    </c:choose>

    <h2 style="margin: 10px 0 2px 0; color: #333;">${student.name}</h2>
    <p style="color: #888; margin: 0 0 25px 0; font-size: 14px;">${student.faculty}</p>

    <div class="info-section">
        <div class="info-item">
            <div class="label">Email Address</div>
            <div class="value">${student.email}</div>
        </div>

        <div class="info-item">
            <div class="label">Student ID</div>
            <div class="value">#${student.userId}</div>
        </div>

        <div class="info-item">
            <div class="label">Contact Number</div>
            <div class="value">${not empty student.phone ? student.phone : 'Not Provided'}</div>
        </div>

        <div class="info-item">
            <div class="label">Member Status</div>
            <div class="value" style="color: #27ae60; font-weight: bold;">ACTIVE</div>
        </div>

        <div class="info-item">
            <div class="label">Date Joined</div>
            <div class="value">${student.joinDate}</div>
        </div>
    </div>

    <div class="button-group">
    <a href="editMember?id=${student.userId}" class="btn" style="background: #f6c23e; color: white;">Edit Profile</a>
    
    <button onclick="window.print()" class="btn btn-print">Print Details</button>
    <a href="staffDashboard" class="btn btn-back">Return to Dashboard</a>
</div>
</div>

</body>
</html>