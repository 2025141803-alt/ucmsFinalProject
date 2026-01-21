<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Points History</title>
    <link rel="stylesheet" href="css/style.css"> <style>
        .points-container { padding: 40px; max-width: 900px; margin: auto; }
        .points-card { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; padding: 30px; border-radius: 15px; margin-bottom: 30px;
            text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .points-value { font-size: 48px; font-weight: bold; }
        .status-absent { color: #e74c3c; font-weight: bold; }
        .status-present { color: #2ecc71; font-weight: bold; }
        body.sidebar-closed .content { margin-left: 0; }
    </style>
</head>
<body>
    
    <jsp:include page="sidebar.jsp" />
    <jsp:include page="header.jsp" />

    <div class="content">
    <div class="points-container">
        
        
        <div class="points-card">
            <h2>Total Accumulated Points</h2>
            <div class="points-value">${totalPoints} pts</div>
            <p>Points are awarded (+5.00) for every activity marked as ABSENT.</p>
        </div>

        <h3>Detailed History</h3>
        <table border="1" style="width:100%; border-collapse: collapse; background: white;">
            <thead style="background: #f8f9fa;">
                <tr>
                    <th style="padding:15px;">Activity Name</th>
                    <th>Attendance Status</th>
                    <th>Points Earned</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${pointHistory}">
                    <tr style="text-align:center; border-bottom: 1px solid #eee;">
                        <td style="padding:15px;">${item.name}</td>
                        <td>
                            <span class="${item.status == 'ABSENT' ? 'status-absent' : 'status-present'}">
                                ${item.status}
                            </span>
                        </td>
                        <td>+${item.points}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty pointHistory}">
                    <tr>
                        <td colspan="3" style="padding:20px; text-align:center;">No point history found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
             </div>
</body>
</html>