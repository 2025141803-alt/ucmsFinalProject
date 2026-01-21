<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Club Detail</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #5d6d4e; margin: 0; padding: 20px; }
        .back-btn { background: white; padding: 10px 20px; text-decoration: none; color: black; border-radius: 5px; font-weight: bold; }
        .container { background: white; max-width: 600px; margin: 30px auto; padding: 30px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        h1 { margin-top: 0; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; color: #333; }
        input[type="text"], input[type="email"], input[type="date"], select {
            width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 8px; box-sizing: border-box; font-size: 16px;
        }
        .update-btn {
            width: 100%; background-color: #6347f9; color: white; padding: 15px; border: none; 
            border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; margin-top: 10px;
        }
        .update-btn:hover { background-color: #5239d1; }
        .current-logo { margin-bottom: 10px; border-radius: 8px; border: 1px solid #ddd; padding: 5px; }
    </style>
</head>
<body>

    <a href="manageClub" class="back-btn">&larr; Back</a>

    <div class="container">
        <h1>Club Detail</h1>

        <%-- ONLY ONE FORM TAG HERE - with the multipart enctype --%>
        <form action="${pageContext.request.contextPath}/UpdateClubServlet" method="POST" enctype="multipart/form-data">
            
            <%-- HIDDEN ID --%>
            <input type="hidden" name="clubId" value="${club.clubId}">

            <%-- LOGO SECTION --%>
            <div class="form-group">
                <label>Current Logo</label>
                <c:if test="${not empty club.logoPath}">
                    <img src="${pageContext.request.contextPath}/${club.logoPath}" width="100" class="current-logo"><br>
                </c:if>
                <label>Upload New Logo (Optional)</label>
                <input type="file" name="logo" accept="image/*">
            </div>

            <div class="form-group">
                <label>Club Name</label>
                <input type="text" name="clubName" value="${club.clubName}" required>
            </div>

            <div class="form-group">
                <label>Tagline</label>
                <input type="text" name="tagline" value="${club.tagline}">
            </div>

            <div class="form-group">
                <label>Type</label>
                <select name="type">
                    <option value="Sports" ${club.type == 'Sports' ? 'selected' : ''}>Sports</option>
                    <option value="Academic" ${club.type == 'Academic' ? 'selected' : ''}>Academic</option>
                    <option value="Cultural" ${club.type == 'Cultural' ? 'selected' : ''}>Cultural</option>
                    <option value="Religious" ${club.type == 'Religious' ? 'selected' : ''}>Religious</option>
                    <option value="Others" ${club.type == 'Others' ? 'selected' : ''}>Others</option>
                </select>
            </div>

            <div class="form-group">
                <label>Date Registered</label>
                <input type="date" name="dateRegistered" value="${club.dateRegistered}" required>
            </div>

            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" name="contactNumber" value="${club.contactNumber}">
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="${club.email}">
            </div>

            <div class="form-group">
                <label>Location</label>
                <input type="text" name="location" value="${club.location}">
            </div>

            <button type="submit" class="update-btn">Update Club</button>
        </form>
    </div>

</body>
</html>