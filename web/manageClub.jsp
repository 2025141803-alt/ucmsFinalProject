<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // SESSION PROTECTION: redirect if not logged in or not staff
    String role = (String) session.getAttribute("role");
    if (role == null || !"staff".equalsIgnoreCase(role)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Clubs</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f3f3f3;
            margin: 0;
        }

        .content {
            padding: 20px;
            margin-left: 220px; /* leave space for sidebar */
            transition: margin-left 0.3s ease;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .top-bar h2 {
            margin: 0;
        }

        .create-btn {
            background: #c0392b;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
            font-size: 13px;
        }

        th {
            background: #2c2c2c;
            color: white;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 12px;
        }

        .edit-btn { background: #f39c12; color: white; }
        .delete-btn { background: #e74c3c; color: white; }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            background: white;
            width: 500px;
            margin: 80px auto;
            padding: 20px;
            border-radius: 8px;
        }

        .modal-content input,
        .modal-content textarea,
        .modal-content select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 13px;
        }

        .modal-content button {
            margin-right: 10px;
        }
        .action-btn {
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    text-align: center;
    display: inline-block; /* Added this to ensure padding works on <a> tags */
}


        body.sidebar-closed .content { margin-left: 0; }
    </style>
</head>

<body>

    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />

    <div class="content">

        <div class="top-bar">
            <h2>Manage Clubs</h2>
            <button class="create-btn" onclick="openModal()">+ Create New Club</button>
        </div>

        <table>
            <tr>
                <th>Logo</th>
                <th>Club Name</th>
                <th>Tagline</th>
                <th>Type</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Location</th>
                <th>Registered Date</th>
                <th>Action</th>
            </tr>

            <c:forEach items="${clubList}" var="club">
    <tr>
        <td>
    <c:choose>
        <c:when test="${not empty club.logoPath}">
    <img src="${pageContext.request.contextPath}/getImage?name=${club.logoPath}" 
         class="club-logo" 
         alt="Logo" 
         style="width: 50px; height: 50px; border-radius: 5px; object-fit: cover;"
         onerror="this.src='${pageContext.request.contextPath}/images/kelab1.png';">
</c:when>
        <c:otherwise>
            <span style="color: #999; font-size: 11px;">No Logo</span>
        </c:otherwise>
    </c:choose>
</td>
                
                    <td>${club.clubName}</td>
                    <td>${club.tagline}</td>
                    <td>${club.type}</td>
                    <td>${club.contactNumber}</td>
                    <td>${club.email}</td>
                    <td>${club.location}</td>
                    <td>${club.dateRegistered}</td>
                    
                    <td>
            <a href="${pageContext.request.contextPath}/EditClubServlet?id=${club.clubId}" 
               class="action-btn edit-btn" 
               style="text-decoration:none; display:inline-block;">Edit</a>
            
            <a href="${pageContext.request.contextPath}/DeleteClubServlet?id=${club.clubId}" 
               class="action-btn delete-btn" 
               style="text-decoration:none; display:inline-block;" 
               onclick="return confirm('Are you sure you want to delete ${club.clubName}?')">Delete</a>
        </td>
        
                    
                </tr>
            </c:forEach>

            <c:if test="${empty clubList}">
                <tr>
                    <td colspan="9">No clubs available.</td>
                </tr>
            </c:if>
        </table>

    </div>

    <div class="modal" id="clubModal">
        <div class="modal-content">
            <h3>Create New Club</h3>

            <form method="post" action="${pageContext.request.contextPath}/manageClub" enctype="multipart/form-data">
                
                <label>Full Club Name (CAPS)</label>
                <input type="text" name="clubName" required oninput="this.value = this.value.toUpperCase()"/>

                <label>Logo</label>
                <input type="file" name="logo" accept="image/*" required/>

                <label>Tagline</label>
                <input type="text" name="tagline" required/>

                <label>Type</label>
                <select name="type" required>
                    <option value="">Select type</option>
                    <option value="Academic">Academic</option>
                    <option value="Sports">Sports</option>
                    <option value="Cultural">Cultural</option>
                    <option value="Others">Others</option>
                </select>

                <label>Date Registered</label>
                <input type="date" name="dateRegistered" required/>

                <label>Contact Number</label>
                <input type="text" name="contactNumber" required/>

                <label>Email</label>
                <input type="email" name="email" required/>

                <label>Location</label>
                <input type="text" name="location" required/>

                <button type="submit" class="create-btn">Create</button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function openModal() { document.getElementById("clubModal").style.display = "block"; }
        function closeModal() { document.getElementById("clubModal").style.display = "none"; }
    </script>

</body>
</html>