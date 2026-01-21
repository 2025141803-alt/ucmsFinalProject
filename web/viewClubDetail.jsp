<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Club Details | ${club.clubName}</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #3f4a1c; /* Your requested color */
            margin: 0; 
            padding: 40px; 
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .back-btn { 
            align-self: flex-start;
            background: rgba(255, 255, 255, 0.2); 
            padding: 10px 20px; 
            text-decoration: none; 
            color: white; 
            border-radius: 5px; 
            font-weight: bold; 
            transition: 0.3s;
            margin-bottom: 20px;
        }
        .back-btn:hover { background: rgba(255, 255, 255, 0.3); }

        .detail-card { 
            background: white; 
            width: 100%;
            max-width: 700px; 
            border-radius: 20px; 
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3); 
        }

        .card-header {
            background: #f8f9fa;
            padding: 40px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        .club-logo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }

        .club-name { margin: 0; color: #333; font-size: 28px; }
        .club-tagline { color: #777; font-style: italic; font-size: 18px; margin-top: 5px; }

        .card-body { padding: 30px; }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-item { margin-bottom: 15px; }
        .info-label { 
            display: block; 
            font-size: 12px; 
            text-transform: uppercase; 
            color: #3f4a1c; 
            font-weight: bold; 
            margin-bottom: 3px;
        }
        .info-value { font-size: 16px; color: #444; }
        
        .full-width { grid-column: span 2; border-top: 1px solid #eee; pt: 15px; }
        .club-logo {
    width: 120px;   /* Fixed width */
    height: 120px;  /* Fixed height */
    border-radius: 50%; /* Makes it a circle */
    object-fit: cover;  /* Prevents the image from stretching */
    border: 4px solid white;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    margin-bottom: 15px;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
.btn-join {
    grid-column: span 2; /* Makes it wide */
    background-color: #3f4a1c;
    color: white;
    border: none;
    padding: 15px;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    font-size: 16px;
    margin-top: 20px;
    transition: 0.3s;
}

.btn-join:hover {
    background-color: #2d3614;
    transform: translateY(-2px);
}

.btn-joined {
    grid-column: span 2;
    background-color: #6c757d; /* Gray color */
    color: #e9ecef;
    border: none;
    padding: 15px;
    border-radius: 8px;
    font-weight: bold;
    cursor: not-allowed;
    font-size: 16px;
    margin-top: 20px;
    width: 100%;
}
    </style>
</head>
<body>

    <c:if test="${param.error == 'already_member'}">
    <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px; width: 100%; max-width: 700px; text-align: center;">
        You are already a member of this club!
    </div>
</c:if>
    
   <a href="${pageContext.request.contextPath}/viewAllClubs" class="back-btn">&larr; Back to List</a>

    <div class="detail-card">
     <div class="card-header">
    <%-- Corrected: All attributes inside ONE tag, only ONE alt attribute --%>
    <img src="${pageContext.request.contextPath}/getImage?name=${club.logoPath}" 
         class="club-logo" 
         alt="Club Logo" 
         style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 5px solid white;" 
         onerror="this.src='${pageContext.request.contextPath}/images/default-logo.png';">

    <h1 class="club-name">${club.clubName}</h1>
    <p class="club-tagline">"${club.tagline}"</p>
</div>
        <div class="card-body">
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Club Type</span>
                    <span class="info-value">${club.type}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Date Registered</span>
                    <span class="info-value">${club.dateRegistered}</span>
                </div>

                <div class="info-item">
                    <span class="info-label">Contact Number</span>
                    <span class="info-value">${club.contactNumber}</span>
                </div>

                <div class="info-item">
                    <span class="info-label">Email Address</span>
                    <span class="info-value">${club.email}</span>
                </div>

               <div class="info-item full-width">
    <%
        // If you are not using JSTL, use this Java check:
        Boolean isMember = (Boolean) request.getAttribute("isMember");
        if (isMember != null && isMember) {
    %>
        <button class="btn-joined" disabled style="background-color: #888; cursor: not-allowed;">
            Already a Member
        </button>
    <% } else { %>
        <form action="MembershipServlet" method="POST" onsubmit="return confirm('Do you want to join this club?');">
            <input type="hidden" name="action" value="join">
            <input type="hidden" name="clubId" value="${club.clubId}">
            <button type="submit" class="btn-join">Confirm to Join Membership</button>
        </form>
    <% } %>
</div>
        </div>
    </div>
<%-- JavaScript to catch the error from the URL --%>
<script>
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        
        if (urlParams.get('error') === 'already_member') {
            alert("You are already a member of this club!");
        }
        
        if (urlParams.get('status') === 'joined') {
            alert("Successfully joined the club!");
        }
    };
</script>
</body>
</html>