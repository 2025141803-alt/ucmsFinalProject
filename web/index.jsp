<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body {
            background-color: #3e442b;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 900px;
            height: 550px;
            background: #fff;
            border-radius: 15px;
            display: flex;
            overflow: hidden;
        }
.left {
    width: 50%;
    padding: 60px;
    position: relative;   
}

        .left h1 { font-size: 48px; margin-bottom: 40px; }
        .input-box { width: 100%; margin-bottom: 25px; position: relative; }
        .input-box input {
            width: 100%;
            padding: 15px;
            border-radius: 8px;
            border: none;
            background: #e6e6e6;
            font-size: 16px;
        }
        .show-pass {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 14px;
            color: #333;
        }
        .options {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            margin-bottom: 25px;
        }
        .login-btn {
            width: 100%;
            padding: 15px;
            background: #000;
            border: none;
            border-radius: 30px;
            color: #fff;
            font-size: 18px;
            cursor: pointer;
        }
.signup-container {
    position: relative;
    background: white;
    border-radius: 20px;
    padding: 40px;
}


.signup-logo {
    position: absolute;
    width: 100px;       /* adjust size */
    height: auto;      /* keep proportions */
      top: -10px;            /* move up/down */
    right: -15px;  /* space below logo */
}
        .register { text-align: center; margin-top: 15px; font-size: 14px; }
        .right { width: 50%; background: url('images/login.png') center/cover no-repeat; }
    </style>
</head>
<body>
    <%
    String error = request.getParameter("error");
    if (error != null) {
%>
    <script>
        alert("<%= error %>");
    </script>
<%
    }
%>
    <div class="container">
        <div class="left">
            <img src="images/logoUCMS.png" alt="Logo" class="signup-logo">
            <h1>Login</h1>

       
            <form action="IndexServlet" method="post">
               
    <input type="hidden" name="action" value="index">

                <div class="input-box">
                    <input type="text" id="username" name="user_id" placeholder="Student/Staff ID" />
                </div>
                <div class="input-box">
                    <input type="password" id="password" name="password" placeholder="Password" />
                    <span class="show-pass" onclick="togglePassword()">Show</span>
                </div>
                <div class="options">
    <label>
        <input type="radio" name="role" value="student" required> Student
    </label>
    <label>
        <input type="radio" name="role" value="staff"> Staff
    </label>
</div>

                <button class="login-btn" type="submit">Login</button>
            </form>
         

            <div class="register">Don't have an account? <a href="signup.jsp">Register</a></div>
        </div>
        <div class="right"></div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById("password");
            const showPass = document.querySelector(".show-pass");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                showPass.textContent = "Hide";
            } else {
                passwordInput.type = "password";
                showPass.textContent = "Show";
            }
        }
    </script>
    <script>
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get("msg");

    if (msg === "signup_success") {
        alert("Registration successful! Please login.");
    }
</script>

</body>
</html>
