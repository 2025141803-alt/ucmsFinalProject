<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Get the "from" parameter or default to index.jsp
    String from = request.getParameter("from");
    if (from == null) from = "index.jsp"; 

    String confirm = request.getParameter("confirm");
    
    if ("true".equals(confirm)) {
        session.invalidate(); 
        response.sendRedirect("index.jsp"); 
        return;
    } else if ("false".equals(confirm)) {
        // USE THE 'from' VARIABLE HERE
        // This will redirect to 'staffDashboard' or 'home' depending on the sidebar link
        response.sendRedirect(from);
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Logout - UniClubs</title>
<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .logout-card {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        text-align: center;
    }
    
    body.sidebar-closed #sidebar-container {
            width: 0 !important;
            padding: 0 !important;
            overflow: hidden;
        }
    .btn {
        padding: 10px 20px;
        margin: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
    }
    .btn-danger { background-color: #d9534f; color: white; }
    .btn-secondary { background-color: #9fa38d; color: white; }
</style>
</head>
<body>
    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />

    <div class="logout-card">
        <h2>Confirm Logout</h2>
        <p>Are you sure you want to log out of UniClubs?</p>
        
        <a href="logout.jsp?confirm=true"><button class="btn btn-danger">Yes, Log out</button></a>
        <a href="logout.jsp?confirm=false&from=<%= from %>">
        <button class="btn btn-secondary">Cancel</button>
    </a>
    </div>

</body>
</html>