<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up Page</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
.form-box {
    display: none;  
    margin-top: 15px;
}
.role-selection {
    margin-bottom: 20px;
}

.role-selection label {
    margin-right: 30px;   
    font-size: 16px;
    cursor: pointer;
}

.role-selection input {
    margin-right: 6px;   
}

        body {
            background-color: #3e442b;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 900px;
            background: #fff;
            border-radius: 15px;
            display: flex;
            overflow: hidden;
        }

        .left {
            width: 50%;
            padding: 40px 60px;
             position: relative; 
              background: white;
    border-radius: 20px;
    padding: 40px;
        }

        .left h1 {
            font-size: 48px;
            margin-bottom: 30px;
            
        }

        .input-box {
            margin-bottom: 15px;
        }

        .input-box label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .input-box input,
        .input-box select {
            width: 100%;
            padding: 15px;
            border-radius: 8px;
            border: none;
            background: #e6e6e6;
            font-size: 16px;
        }

        .tnc {
            display: flex;
            align-items: center;
            font-size: 14px;
            margin-top: 10px;
        }

        .tnc input {
            margin-right: 10px;
        }

        .signup-btn {
            width: 100%;
            padding: 15px;
            background: #000;
            border: none;
            border-radius: 30px;
            color: #fff;
            font-size: 18px;
            cursor: pointer;
            margin-top: 15px;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .login-link a {
            text-decoration: none;
            color: #000;
            font-weight: bold;
        }

        .right {
            width: 50%;
            background: url('images/login.png') center/cover no-repeat;
        }
        .signup-container {
    position: relative;   /* IMPORTANT */
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


    </style>
     <script>
function showForm(role) {
    const studentForm = document.getElementById("studentForm");
    const staffForm = document.getElementById("staffForm");

    // Hide both forms
    studentForm.style.display = "none";
    staffForm.style.display = "none";

    // Disable all required fields
    studentForm.querySelectorAll("input, select").forEach(el => el.required = false);
    staffForm.querySelectorAll("input, select").forEach(el => el.required = false);

    // Show selected form & enable required fields
    if (role === "student") {
        studentForm.style.display = "block";
        studentForm.querySelectorAll("input, select").forEach(el => el.required = true);
    } else if (role === "staff") {
        staffForm.style.display = "block";
        staffForm.querySelectorAll("input, select").forEach(el => el.required = true);
    }
}
</script>

</head>

<body>

<div class="container">
    <div class="left">
        
 <img src="images/logoUCMS.png" alt="Logo" class="signup-logo">
        <h1>Sign Up</h1>

       
        

<form action="UserServlet" method="post" onsubmit="return validateForm()">

    <input type="hidden" name="action" value="signup">

    <div class="role-selection">

        <label>
            <input type="radio" name="role" value="student"
                   onclick="showForm('student')" required>
            Student
        </label>

        <label style="margin-left: 20px;">
            <input type="radio" name="role" value="staff"
                   onclick="showForm('staff')">
            Staff
        </label>
    </div>

     



<!-- STUDENT FORM -->
<div id="studentForm" class="form-box">
  

    <div class="input-box">
        <label>Student ID</label>
        <input type="text" name="student_id" maxlength="10" placeholder="ex: 2025678910">

    </div>

    <div class="input-box">
        <label>Full Name</label>
        <input type="text" name="student_name" placeholder="Ali Bin Abu">
    </div>

    <div class="input-box">
        <label>Student Email</label>
        <input type="email" name="student_email" placeholder="ali123@gmail.com">
    </div>

    <div class="input-box">
        <label>Contact Number</label>
        <input type="text" name="student_phone" placeholder="0123145678">
    </div>

    <div class="input-box">
        <label>Password</label>
        <input type="password" name="student_password" >
     
    </div>

    <div class="input-box">
        <label>Faculty</label>
        <select name="student_faculty">
            <option value="">Select Faculty</option>
            <option value="Science">Science</option>
            <option value="Engineering">Engineering</option>
            <option value="Business">Business</option>
        </select>
    </div>
</div>

<!-- STAFF FORM -->
<div id="staffForm" class="form-box">
  

    <div class="input-box">
        <label>Staff ID</label>
        <input type="text" name="staff_id" maxlength="10" placeholder="A12345">

    </div>

    <div class="input-box">
        <label>Full Name</label>
        <input type="text" name="staff_name" placeholder="Ali Bin Abu">
    </div>

    <div class="input-box">
        <label>Staff Email</label>
        <input type="email" name="staff_email" placeholder="ali@gmail.com">
    </div>

    <div class="input-box">
        <label>Password</label>
        <input type="password" name="staff_password" >
    </div>

</div>



           
           
            <button type="submit" class="signup-btn">Sign Up</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="index.jsp">Login</a>
        </div>
    </div>

    <div class="right"></div>
</div>
 <script>
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get("msg");

    if (msg === "name_error") {
        alert("Registration failed: Name is required.");
    } 
    else if (msg === "name_format_error") {
        alert("Registration failed: Name must contain letters only.");
    } 
    else if (msg === "email_error") {
        alert("Registration failed: Email is required.");
    } 
    else if (msg === "password_error") {
        alert("Registration failed: Password must be at least 6 characters.");
    } 
    else if (msg === "id_error") {
        alert("Registration failed: ID must be exactly 10 digits.");
    } 
    else if (msg === "duplicate") {
        alert("Registration failed: User ID or Email already exists.");
    }
</script>


<script>
function validateForm() {

    const role = document.querySelector('input[name="role"]:checked');
    if (!role) {
        alert("Please select a role.");
        return false;
    }

    if (role.value === "student") {
        const id = document.querySelector('input[name="student_id"]').value.trim();
        const name = document.querySelector('input[name="student_name"]').value.trim();
        const phone = document.querySelector('input[name="student_phone"]').value.trim();
        
        if (!/^\d{10}$/.test(id)) {
            alert("Student ID must be valid.");
            return false;
        }

        if (!/^[A-Za-z ]+$/.test(name)) {
            alert("Name must contain letters only.");
            return false;
        }
         if (!/^\d+$/.test(phone)) {
        alert("Phone number must contain numbers only.");
        return false;
    }
     if (!/^\d{10,11}$/.test(phone)) {
        alert("Phone number must be valid.");
        return false;
    }
    }

    if (role.value === "staff") {
        const id = document.querySelector('input[name="staff_id"]').value.trim();
        const name = document.querySelector('input[name="staff_name"]').value.trim();

        if (!/^\d{10}$/.test(id)) {
            alert("Staff ID must be valid.");
            return false;
        }

       if (name === "") {
    alert("Name is required.");
    return false;
}

if (!/^[A-Za-z ]+$/.test(name)) {
    alert("Name must contain letters only.");
    return false;
}

    }

    return true; // allow form to submit
}
</script>

</body>
</html>
