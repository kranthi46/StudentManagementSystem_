<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.sms.model.Student" %>

<%
    Student student =
            (Student) request.getAttribute("student");

    String error =
            (String) request.getAttribute("error");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Student - Student Management System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        .form-header {
            margin-bottom: 25px;
        }

        .form-header h1 {
            margin: 0;

            font-size: 28px;
        }

        .form-header p {
            color: #7b8797;

            font-size: 13px;
        }

        .form-card {
            background: white;

            padding: 30px;

            border-radius: 12px;

            box-shadow:
                0 3px 15px rgba(20,35,60,0.06);
        }

        .form-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 18px 22px;
        }

        .form-group {
            display: flex;

            flex-direction: column;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            margin-top: 0;

            font-size: 12px;

            color: #475569;

            margin-bottom: 7px;
        }

        .form-group input,
        .form-group select {
            height: 44px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .readonly-input {
            background: #f5f7fa;

            color: #667085;

            cursor: not-allowed;
        }

        .form-footer {
            margin-top: 25px;

            padding-top: 20px;

            border-top: 1px solid #edf0f4;

            display: flex;

            gap: 10px;
        }

        .submit-button {
            border: none;

            background: #2563eb;

            color: white;

            padding: 12px 20px;

            border-radius: 7px;

            cursor: pointer;

            font-weight: bold;
        }

        .submit-button:hover {
            background: #1d4ed8;
        }

        .cancel-button {
            display: flex;

            align-items: center;

            padding: 0 20px;

            border-radius: 7px;

            background: #f1f4f8;

            color: #475569;

            text-decoration: none;

            font-size: 13px;
        }

        @media (max-width: 700px) {

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
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


    <div class="form-header">

        <p class="welcome-small">
            STUDENT MANAGEMENT
        </p>

        <h1>
            Edit Student
        </h1>

        <p>
            Update the student's information below.
        </p>

    </div>


    <%
        if (error != null) {
    %>

        <div class="error">
            <%= error %>
        </div>

    <%
        }
    %>


    <div class="form-card">

        <form action="<%= request.getContextPath() %>/edit-student"
              method="post">


            <div class="form-grid">


                <div class="form-group">

                    <label>
                        Student ID
                    </label>

                    <input class="readonly-input"
                           type="text"
                           name="studentId"
                           value="<%= student.getStudentId() %>"
                           readonly>

                </div>


                <div class="form-group">

                    <label>
                        Full Name
                    </label>

                    <input type="text"
                           name="name"
                           value="<%= student.getName() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           value="<%= student.getEmail() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Phone
                    </label>

                    <input type="tel"
                           name="phone"
                           value="<%= student.getPhone() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Gender
                    </label>

                    <select name="gender" required>

                        <option value="Male"
                            <%= "Male".equals(student.getGender())
                                ? "selected" : "" %>>

                            Male

                        </option>

                        <option value="Female"
                            <%= "Female".equals(student.getGender())
                                ? "selected" : "" %>>

                            Female

                        </option>

                        <option value="Other"
                            <%= "Other".equals(student.getGender())
                                ? "selected" : "" %>>

                            Other

                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label>
                        Date of Birth
                    </label>

                    <input type="date"
                           name="dob"
                           value="<%= student.getDob() %>">

                </div>


                <div class="form-group">

                    <label>
                        Course
                    </label>

                    <input type="text"
                           name="course"
                           value="<%= student.getCourse() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Department
                    </label>

                    <input type="text"
                           name="department"
                           value="<%= student.getDepartment() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Year
                    </label>

                    <select name="year" required>

                        <option value="1"
                            <%= "1".equals(student.getYear())
                                ? "selected" : "" %>>

                            1st Year

                        </option>

                        <option value="2"
                            <%= "2".equals(student.getYear())
                                ? "selected" : "" %>>

                            2nd Year

                        </option>

                        <option value="3"
                            <%= "3".equals(student.getYear())
                                ? "selected" : "" %>>

                            3rd Year

                        </option>

                        <option value="4"
                            <%= "4".equals(student.getYear())
                                ? "selected" : "" %>>

                            4th Year

                        </option>

                    </select>

                </div>


                <div class="form-group full">

                    <label>
                        Address
                    </label>

                    <textarea name="address"
                              rows="4"><%= student.getAddress() %></textarea>

                </div>


            </div>


            <div class="form-footer">

                <button class="submit-button"
                        type="submit">

                    Save Changes

                </button>


                <a class="cancel-button"
                   href="<%= request.getContextPath() %>/students">

                    Cancel

                </a>

            </div>

        </form>

    </div>

</main>

</body>

</html>