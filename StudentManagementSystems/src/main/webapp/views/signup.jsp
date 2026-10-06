<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Account | Student Management System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            min-height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

            font-family: Arial, Helvetica, sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #eef4ff,
                    #f8fafc,
                    #eaf1ff
                );

            padding: 25px;
        }

        .signup-card {
            width: 100%;

            max-width: 450px;

            background: white;

            padding: 38px 40px;

            border-radius: 20px;

            box-shadow:
                0 20px 50px rgba(30,50,80,0.12);
        }

        .logo {
            width: 60px;

            height: 60px;

            margin: 0 auto 18px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 15px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            font-size: 28px;
        }

        h1 {
            margin: 0;

            text-align: center;

            font-size: 25px;

            color: #172033;
        }

        .subtitle {
            text-align: center;

            color: #7b8797;

            font-size: 13px;

            margin: 8px 0 27px;
        }

        .error {
            background: #fff1f2;

            border: 1px solid #fecdd3;

            color: #be123c;

            padding: 10px;

            border-radius: 8px;

            text-align: center;

            font-size: 12px;

            margin-bottom: 18px;
        }

        .form-group {
            margin-bottom: 17px;
        }

        label {
            display: block;

            margin-bottom: 7px;

            font-size: 13px;

            font-weight: 600;

            color: #344054;
        }

        input {
            width: 100%;

            height: 47px;

            padding: 0 13px;

            border: 1px solid #d9dee8;

            border-radius: 9px;

            font-size: 14px;

            outline: none;
        }

        input:focus {
            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37,99,235,0.10);
        }

        .signup-button {
            width: 100%;

            height: 48px;

            margin-top: 5px;

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

            font-weight: bold;

            cursor: pointer;
        }

        .signup-button:hover {
            background:
                linear-gradient(
                    135deg,
                    #1d4ed8,
                    #2563eb
                );
        }

        .login-link {
            text-align: center;

            margin-top: 22px;

            padding-top: 20px;

            border-top: 1px solid #edf0f4;

            font-size: 12px;

            color: #7b8797;
        }

        .login-link a {
            color: #2563eb;

            font-weight: bold;

            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .footer {
            text-align: center;

            margin-top: 20px;

            color: #98a2b3;

            font-size: 11px;
        }

    </style>

</head>

<body>


<div class="signup-card">


    <div class="logo">
        🎓
    </div>


    <h1>
        Create Account
    </h1>


    <p class="subtitle">
        Create an administrator account
    </p>


    <%
        String error =
                (String) request.getAttribute("error");

        if (error != null) {
    %>

        <div class="error">
            <%= error %>
        </div>

    <%
        }
    %>


    <form action="<%= request.getContextPath() %>/signup"
          method="post">


        <div class="form-group">

            <label for="username">
                Username
            </label>

            <input
                id="username"
                type="text"
                name="username"
                placeholder="Choose a username"
                required>

        </div>


        <div class="form-group">

            <label for="password">
                Password
            </label>

            <input
                id="password"
                type="password"
                name="password"
                placeholder="Create a password"
                required>

        </div>


        <div class="form-group">

            <label for="confirmPassword">
                Confirm Password
            </label>

            <input
                id="confirmPassword"
                type="password"
                name="confirmPassword"
                placeholder="Confirm your password"
                required>

        </div>


        <button
            type="submit"
            class="signup-button">

            Create Account

        </button>

    </form>


    <div class="login-link">

        Already have an account?

        <a href="<%= request.getContextPath() %>/views/login.jsp">
            Sign In
        </a>

    </div>


    <div class="footer">

        Student Management System

    </div>

</div>

</body>

</html>