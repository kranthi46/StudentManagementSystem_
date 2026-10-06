<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Student Management System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        html,
        body {
            margin: 0;
            padding: 0;
            width: 100%;
            min-height: 100%;
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #eef4ff 0%,
                    #f8fafc 50%,
                    #eaf1ff 100%
                );

            padding: 30px 15px;
        }

        .login-wrapper {
            width: 100%;
            max-width: 430px;
        }

        .login-card {
            width: 100%;

            background: #ffffff;

            border-radius: 20px;

            padding: 42px 42px 32px;

            box-shadow:
                0 20px 50px rgba(30, 50, 80, 0.12);
        }

        .logo-wrapper {
            display: flex;
            justify-content: center;

            margin-bottom: 20px;
        }

        .logo {
            width: 68px;
            height: 68px;

            display: flex;
            align-items: center;
            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            border-radius: 17px;

            font-size: 31px;

            box-shadow:
                0 10px 25px rgba(37, 99, 235, 0.25);
        }

        .login-title {
            text-align: center;

            margin: 0;

            color: #172033;

            font-size: 27px;
        }

        .login-subtitle {
            text-align: center;

            margin: 8px 0 30px;

            color: #7b8797;

            font-size: 13px;
        }

        .error-message {
            background: #fff1f2;

            border: 1px solid #fecdd3;

            color: #be123c;

            padding: 11px 13px;

            border-radius: 8px;

            font-size: 12px;

            margin-bottom: 20px;

            text-align: center;
        }

        .success-message {
            background: #ecfdf3;

            border: 1px solid #bbf7d0;

            color: #15803d;

            padding: 11px 13px;

            border-radius: 8px;

            font-size: 12px;

            margin-bottom: 20px;

            text-align: center;
        }

        .login-form {
            width: 100%;
        }

        .form-group {
            width: 100%;

            margin-bottom: 19px;
        }

        .form-group label {
            display: block;

            width: 100%;

            margin: 0 0 8px;

            color: #344054;

            font-size: 13px;

            font-weight: 600;
        }

        .input-wrapper {
            position: relative;

            width: 100%;
        }

        .input-icon {
            position: absolute;

            left: 14px;

            top: 50%;

            transform: translateY(-50%);

            font-size: 15px;

            pointer-events: none;
        }

        .form-input {
            display: block;

            width: 100%;

            height: 48px;

            padding: 0 14px 0 43px;

            border: 1px solid #d9dee8;

            border-radius: 9px;

            background: #ffffff;

            color: #172033;

            font-size: 14px;

            outline: none;
        }

        .form-input:focus {
            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37, 99, 235, 0.10);
        }

        .password-wrapper .form-input {
            padding-right: 45px;
        }

        .password-toggle {
            position: absolute;

            right: 13px;

            top: 50%;

            transform: translateY(-50%);

            border: none;

            background: transparent;

            cursor: pointer;

            font-size: 15px;

            color: #98a2b3;
        }

        .login-button {
            display: flex;

            align-items: center;
            justify-content: center;

            width: 100%;

            height: 48px;

            margin-top: 8px;

            border: none;

            border-radius: 9px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            color: white;

            font-size: 14px;

            font-weight: 700;

            cursor: pointer;

            box-shadow:
                0 8px 18px rgba(37, 99, 235, 0.20);
        }

        .login-button:hover {
            background:
                linear-gradient(
                    135deg,
                    #1d4ed8,
                    #2563eb
                );
        }

        /* SIGN UP */

        .signup-section {
            text-align: center;

            margin-top: 23px;

            padding-top: 21px;

            border-top: 1px solid #edf0f4;
        }

        .signup-section p {
            margin: 0 0 8px;

            color: #7b8797;

            font-size: 12px;
        }

        .signup-link {
            color: #2563eb;

            text-decoration: none;

            font-size: 13px;

            font-weight: 700;
        }

        .signup-link:hover {
            text-decoration: underline;
        }

        .login-footer {
            text-align: center;

            margin-top: 22px;

            color: #98a2b3;

            font-size: 11px;

            line-height: 1.6;
        }

        @media (max-width: 500px) {

            body {
                padding: 15px;
            }

            .login-card {
                padding: 32px 25px 25px;
            }

            .login-title {
                font-size: 23px;
            }

        }

    </style>

</head>

<body>

<div class="login-wrapper">

    <div class="login-card">

        <div class="logo-wrapper">

            <div class="logo">
                🎓
            </div>

        </div>


        <h1 class="login-title">
            Student Management
        </h1>

        <p class="login-subtitle">
            Administrator Portal
        </p>


        <%
            String error =
                    (String) request.getAttribute("error");

            if (error != null) {
        %>

            <div class="error-message">
                <%= error %>
            </div>

        <%
            }

            String success =
                    request.getParameter("success");

            if ("registered".equals(success)) {
        %>

            <div class="success-message">
                Account created successfully.
                You can now login.
            </div>

        <%
            }
        %>


        <form class="login-form"
              action="<%= request.getContextPath() %>/login"
              method="post">


            <div class="form-group">

                <label for="username">
                    Username
                </label>

                <div class="input-wrapper">

                    <span class="input-icon">
                        👤
                    </span>

                    <input
                        id="username"
                        class="form-input"
                        type="text"
                        name="username"
                        placeholder="Enter your username"
                        autocomplete="username"
                        required>

                </div>

            </div>


            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <div class="input-wrapper password-wrapper">

                    <span class="input-icon">
                        🔒
                    </span>

                    <input
                        id="password"
                        class="form-input"
                        type="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword()"
                        id="passwordToggle">

                        👁

                    </button>

                </div>

            </div>


            <button
                type="submit"
                class="login-button">

                Sign In

            </button>

        </form>


        <!-- SIGN UP -->

        <div class="signup-section">

            <p>
                Don't have an account?
            </p>

            <a class="signup-link"
               href="<%= request.getContextPath() %>/views/signup.jsp">

                Create an Account →

            </a>

        </div>


        <div class="login-footer">

            Student Management System
            <br>

            Administration Portal

        </div>

    </div>

</div>


<script>

    function togglePassword() {

        const password =
            document.getElementById("password");

        const toggle =
            document.getElementById("passwordToggle");

        if (password.type === "password") {

            password.type = "text";

            toggle.textContent = "🙈";

        } else {

            password.type = "password";

            toggle.textContent = "👁";

        }

    }

</script>

</body>

</html>