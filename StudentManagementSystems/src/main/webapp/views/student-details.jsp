<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sms.model.Student" %>

<%
    Student student =
            (Student) request.getAttribute("student");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Details - Student Management System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        .details-header {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 25px;
        }

        .details-title h1 {
            margin: 0;

            font-size: 28px;
        }

        .details-title p {
            margin-top: 7px;

            color: #7b8797;

            font-size: 13px;
        }

        .details-actions {
            display: flex;

            gap: 9px;
        }

        .edit-button {
            background: #2563eb;

            color: white;

            text-decoration: none;

            padding: 10px 17px;

            border-radius: 7px;

            font-size: 13px;

            font-weight: bold;
        }

        .back-button {
            background: white;

            border: 1px solid #dce2ea;

            color: #475569;

            text-decoration: none;

            padding: 10px 17px;

            border-radius: 7px;

            font-size: 13px;
        }

        .profile-card {
            background: white;

            border-radius: 12px;

            padding: 30px;

            box-shadow:
                0 3px 15px rgba(20,35,60,0.06);

            margin-bottom: 22px;
        }

        .profile-top {
            display: flex;

            align-items: center;

            gap: 20px;

            padding-bottom: 25px;

            border-bottom: 1px solid #edf0f4;

            margin-bottom: 25px;
        }

        .profile-avatar {
            width: 75px;

            height: 75px;

            border-radius: 50%;

            background: #e8f0ff;

            color: #2563eb;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 30px;

            font-weight: bold;
        }

        .profile-name h2 {
            margin: 0;

            font-size: 23px;
        }

        .profile-name p {
            margin: 6px 0 0;

            color: #7b8797;

            font-size: 13px;
        }

        .student-id-badge {
            display: inline-block;

            margin-top: 8px;

            padding: 5px 9px;

            border-radius: 5px;

            background: #eef4ff;

            color: #2563eb;

            font-size: 11px;

            font-weight: bold;
        }

        .details-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 20px;
        }

        .detail-item {
            padding: 17px;

            background: #f8fafc;

            border-radius: 8px;
        }

        .detail-label {
            display: block;

            color: #8993a3;

            font-size: 11px;

            margin-bottom: 7px;

            text-transform: uppercase;

            letter-spacing: 0.5px;
        }

        .detail-value {
            color: #172033;

            font-size: 14px;

            font-weight: bold;
        }

        .address-item {
            grid-column: 1 / -1;
        }

        @media (max-width: 700px) {

            .details-header {
                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .address-item {
                grid-column: auto;
            }

        }

    </style>

</head>

<body>


<header class="navbar">

    <div class="brand">

        <div class="brand-icon">
            🎓
        </div>

        <div>

            <h2>
                Student Management
            </h2>

            <span>
                Administration Portal
            </span>

        </div>

    </div>


    <nav>

        <a href="<%= request.getContextPath() %>/dashboard">
            Dashboard
        </a>

        <a class="active"
           href="<%= request.getContextPath() %>/students">
            Students
        </a>

        <a href="<%= request.getContextPath() %>/views/add-student.jsp">
            Add Student
        </a>

        <a class="logout-link"
           href="<%= request.getContextPath() %>/logout">
            Logout
        </a>

    </nav>

</header>


<main class="dashboard-container">


    <div class="details-header">

        <div class="details-title">

            <p class="welcome-small">
                STUDENT PROFILE
            </p>

            <h1>
                Student Details
            </h1>

            <p>
                View complete information about this student.
            </p>

        </div>


        <div class="details-actions">

            <a class="back-button"
               href="<%= request.getContextPath() %>/students">

                ← Back

            </a>


            <a class="edit-button"
               href="<%= request.getContextPath() %>/edit-student?id=<%= student.getStudentId() %>">

                Edit Student

            </a>

        </div>

    </div>


    <div class="profile-card">


        <!-- PROFILE HEADER -->

        <div class="profile-top">

            <div class="profile-avatar">

                <%= student.getName()
                        .substring(0, 1)
                        .toUpperCase() %>

            </div>


            <div class="profile-name">

                <h2>
                    <%= student.getName() %>
                </h2>

                <p>
                    <%= student.getCourse() %>
                </p>

                <span class="student-id-badge">

                    ID:
                    <%= student.getStudentId() %>

                </span>

            </div>

        </div>


        <!-- DETAILS -->

        <div class="details-grid">


            <div class="detail-item">

                <span class="detail-label">
                    Email
                </span>

                <span class="detail-value">
                    <%= student.getEmail() %>
                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Phone
                </span>

                <span class="detail-value">
                    <%= student.getPhone() %>
                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Gender
                </span>

                <span class="detail-value">
                    <%= student.getGender() %>
                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Date of Birth
                </span>

                <span class="detail-value">
                    <%= student.getDob() %>
                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Course
                </span>

                <span class="detail-value">
                    <%= student.getCourse() %>
                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Department
                </span>

                <span class="detail-value">
                    <%= student.getDepartment() %>
                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Academic Year
                </span>

                <span class="detail-value">

                    Year
                    <%= student.getYear() %>

                </span>

            </div>


            <div class="detail-item">

                <span class="detail-label">
                    Student ID
                </span>

                <span class="detail-value">
                    <%= student.getStudentId() %>
                </span>

            </div>


            <div class="detail-item address-item">

                <span class="detail-label">
                    Address
                </span>

                <span class="detail-value">

                    <%= student.getAddress() != null &&
                        !student.getAddress().trim().isEmpty()
                        ? student.getAddress()
                        : "Address not provided" %>

                </span>

            </div>

        </div>

    </div>


    <!-- BOTTOM ACTION -->

    <div class="bottom-actions">

        <a class="secondary-action"
           href="<%= request.getContextPath() %>/students">

            ← Back to Students

        </a>


        <a class="primary-action"
           href="<%= request.getContextPath() %>/edit-student?id=<%= student.getStudentId() %>">

            ✎ Edit Student

        </a>

    </div>

</main>

</body>

</html>