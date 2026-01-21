<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Activity Detail</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #5b6340; /* The olive green from your image */
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .back-btn {
            align-self: flex-start;
            background-color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            color: black;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .main-card {
            background-color: white;
            width: 100%;
            max-width: 900px;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            min-height: 400px;
        }

        h2 {
            font-size: 28px;
            margin-top: 0;
            margin-bottom: 30px;
        }

        .form-container {
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 25px;
            max-width: 500px;
        }

        /* Styling the inputs to look like the text in your image */
        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Important for width */
            font-size: 14px;
        }

        .update-btn {
            width: 100%;
            background-color: #5345ed; /* The purple from your "Join" button */
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: opacity 0.2s;
        }

        .update-btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>

    <a href="manageActivities" class="back-btn">← Back</a>

    <div class="main-card">
        <h2>Activities Detail</h2>

        <div class="form-container">
            <form action="UpdateActivityServlet" method="post">
                <input type="hidden" name="id" value="${activity.id}">

                <div class="form-group">
                    <label>Activity Name</label>
                    <input type="text" name="name" value="${activity.name}" required>
                </div>

                <div class="form-group">
                    <label>Date</label>
                    <input type="date" name="date" value="${activity.date}" required>
                </div>

                <div class="form-group">
                    <label>Time</label>
                    <input type="text" name="time" value="${activity.time}" placeholder="e.g. 9:00am - 11:00am" required>
                </div>

                <div class="form-group">
                    <label>Venue</label>
                    <input type="text" name="venue" value="${activity.venue}" required>
                </div>

                <div class="form-group">
                    <label>Club</label>
                    <input type="text" name="clubName" value="${activity.clubName}" required>
                </div>

                <button type="submit" class="update-btn">Update Activity</button>
            </form>
        </div>
    </div>

</body>
</html>