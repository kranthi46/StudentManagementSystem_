<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Student" %>

<%
    // Get search value sent by StudentServlet
    String search = (String) request.getAttribute("search");

    if (search == null) {
        search = "";
    }

    // Get students sent by StudentServlet
    List<Student> students =
            (List<Student>) request.getAttribute("students");

    if (students == null) {
        students = new java.util.ArrayList<Student>();
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Students - Student Management System</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family:
                Arial,
                Helvetica,
                sans-serif;

            background: #f4f7fb;
            color: #172033;
            min-height: 100vh;
        }


        /* =========================
           HEADER
           ========================= */

        .navbar {
            height: 80px;

            background: #172235;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 32px;

            box-shadow:
                0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 14px;

            color: white;
        }

        .brand-icon {
            width: 44px;
            height: 44px;

            border-radius: 11px;

            background: #2864e8;

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;

            font-size: 20px;
            font-weight: bold;
        }

        .brand-title {
            font-size: 20px;
            font-weight: 700;
        }

        .brand-subtitle {
            font-size: 12px;
            color: #b8c4d8;
            margin-top: 3px;
        }


        .nav-links {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-links a {
            color: #e7edf7;
            text-decoration: none;

            padding: 11px 16px;

            border-radius: 8px;

            font-size: 14px;

            transition: 0.2s;
        }

        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.08);
        }

        .nav-links a.active {
            background: #2864e8;
            color: white;
        }

        .nav-links a.logout {
            color: #ffb1b1;
        }


        /* =========================
           PAGE
           ========================= */

        .page-container {
            max-width: 1200px;

            margin: 0 auto;

            padding: 42px 25px 60px;
        }


        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;

            margin-bottom: 28px;
        }

        .page-label {
            color: #71809a;

            font-size: 13px;

            font-weight: 600;

            letter-spacing: 1px;

            text-transform: uppercase;

            margin-bottom: 6px;
        }

        .page-title {
            font-size: 30px;

            color: #111827;

            margin-bottom: 7px;
        }

        .page-description {
            color: #71809a;

            font-size: 14px;
        }


        /* =========================
           ADD BUTTON
           ========================= */

        .add-button {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 7px;

            background: #2864e8;

            color: white;

            text-decoration: none;

            border: none;

            border-radius: 8px;

            padding: 12px 18px;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            transition: 0.2s;

            box-shadow:
                0 4px 10px rgba(40, 100, 232, 0.18);
        }

        .add-button:hover {
            background: #1f55ca;

            transform: translateY(-1px);
        }


        /* =========================
           MAIN CARD
           ========================= */

        .content-card {
            background: white;

            border-radius: 14px;

            padding: 25px;

            box-shadow:
                0 5px 20px rgba(30, 50, 80, 0.07);

            border: 1px solid #edf0f5;
        }


        /* =========================
           SEARCH
           ========================= */

        .student-search {
            display: flex;

            align-items: center;

            gap: 10px;

            width: 100%;

            margin-bottom: 20px;
        }

        .student-search-input {
            flex: 1;

            height: 44px;

            padding: 0 15px;

            border: 1px solid #d8dee9;

            border-radius: 9px;

            background: white;

            color: #172033;

            font-size: 14px;

            outline: none;

            transition: 0.2s;
        }

        .student-search-input::placeholder {
            color: #94a0b4;
        }

        .student-search-input:focus {
            border-color: #2864e8;

            box-shadow:
                0 0 0 3px rgba(40, 100, 232, 0.10);
        }


        .student-search-btn {
            height: 44px;

            padding: 0 20px;

            border: none;

            border-radius: 9px;

            background: #2864e8;

            color: white;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 9px;

            transition: 0.2s;
        }

        .student-search-btn:hover {
            background: #1f55ca;
        }


        /* CSS search icon */
        .search-icon {
            width: 14px;
            height: 14px;

            border: 2px solid white;

            border-radius: 50%;

            display: inline-block;

            position: relative;
        }

        .search-icon::after {
            content: "";

            position: absolute;

            width: 6px;
            height: 2px;

            background: white;

            right: -5px;
            bottom: -2px;

            transform: rotate(45deg);

            border-radius: 2px;
        }


        .student-clear-btn {
            height: 44px;

            padding: 0 18px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 9px;

            background: #f1f4f8;

            color: #536176;

            text-decoration: none;

            font-size: 14px;

            font-weight: 500;

            transition: 0.2s;
        }

        .student-clear-btn:hover {
            background: #e6eaf0;
        }


        /* =========================
           COUNT
           ========================= */

        .student-count {
            font-size: 13px;

            color: #71809a;

            margin-bottom: 18px;
        }

        .student-count strong {
            color: #334155;
        }


        /* =========================
           TABLE
           ========================= */

        .table-container {
            width: 100%;

            overflow-x: auto;

            border: 1px solid #e9edf3;

            border-radius: 10px;
        }

        .student-table {
            width: 100%;

            border-collapse: collapse;

            min-width: 850px;
        }

        .student-table th {
            background: #f7f9fc;

            color: #526078;

            text-align: left;

            font-size: 12px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.4px;

            padding: 14px 15px;

            border-bottom: 1px solid #e6eaf0;
        }

        .student-table td {
            padding: 15px;

            border-bottom: 1px solid #edf0f4;

            font-size: 14px;

            color: #374151;

            vertical-align: middle;
        }

        .student-table tr:last-child td {
            border-bottom: none;
        }

        .student-table tbody tr {
            transition: 0.15s;
        }

        .student-table tbody tr:hover {
            background: #fafcff;
        }


        .student-id {
            color: #2864e8;

            font-weight: 700;
        }

        .student-name {
            color: #172033;

            font-weight: 600;
        }

        .student-email {
            color: #66748a;
        }


        /* =========================
           GENDER BADGES
           ========================= */

        .gender-badge {
            display: inline-block;

            padding: 5px 10px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 600;
        }

        .gender-male {
            background: #e8f0ff;

            color: #2563eb;
        }

        .gender-female {
            background: #fcecf4;

            color: #c02670;
        }


        /* =========================
           ACTION BUTTONS
           ========================= */

        .actions {
            display: flex;

            align-items: center;

            gap: 6px;
        }

        .action-button {
            display: inline-flex;

            align-items: center;

            justify-content: center;

            padding: 7px 10px;

            border-radius: 6px;

            text-decoration: none;

            font-size: 12px;

            font-weight: 600;

            transition: 0.2s;
        }

        .view-button {
            background: #eef4ff;

            color: #2864e8;
        }

        .view-button:hover {
            background: #dce8ff;
        }

        .edit-button {
            background: #eef9f2;

            color: #16803c;
        }

        .edit-button:hover {
            background: #dff3e6;
        }

        .delete-button {
            background: #fff0f0;

            color: #d12d2d;

            border: none;

            cursor: pointer;
        }

        .delete-button:hover {
            background: #ffe0e0;
        }


        /* =========================
           EMPTY STATE
           ========================= */

        .empty-state {
            text-align: center;

            padding: 65px 20px;
        }

        .empty-icon {
            width: 62px;

            height: 62px;

            margin: 0 auto 18px;

            border-radius: 50%;

            background: #eef4ff;

            display: flex;

            align-items: center;

            justify-content: center;

            color: #2864e8;

            font-size: 25px;

            font-weight: bold;
        }

        .empty-title {
            font-size: 18px;

            font-weight: 700;

            color: #526078;

            margin-bottom: 8px;
        }

        .empty-description {
            font-size: 14px;

            color: #8793a7;

            margin-bottom: 22px;
        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 800px) {

            .navbar {
                height: auto;

                padding: 16px 20px;

                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }

            .nav-links {
                width: 100%;

                overflow-x: auto;
            }

            .page-header {
                flex-direction: column;

                gap: 20px;
            }

            .add-button {
                width: 100%;
            }

            .student-search {
                flex-direction: column;

                align-items: stretch;
            }

            .student-search-input,
            .student-search-btn,
            .student-clear-btn {
                width: 100%;
            }

            .content-card {
                padding: 18px;
            }
        }

    </style>

</head>


<body>


<!-- =========================
     NAVIGATION BAR
     ========================= -->

<nav class="navbar">

    <div class="brand">

        <div class="brand-icon">
            SM
        </div>

        <div>
            <div class="brand-title">
                Student Management
            </div>

            <div class="brand-subtitle">
                Administration Portal
            </div>
        </div>

    </div>


    <div class="nav-links">

        <a href="<%= contextPath %>/dashboard">
            Dashboard
        </a>

        <a href="<%= contextPath %>/students"
           class="active">
            Students
        </a>

        <a href="<%= contextPath %>/add-student">
            Add Student
        </a>

        <a href="<%= contextPath %>/logout"
           class="logout">
            Logout
        </a>

    </div>

</nav>


<!-- =========================
     PAGE CONTENT
     ========================= -->

<main class="page-container">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <div>

            <div class="page-label">
                Student Database
            </div>

            <h1 class="page-title">
                Students
            </h1>

            <p class="page-description">
                View, search and manage student records.
            </p>

        </div>


        <a
            class="add-button"
            href="<%= contextPath %>/add-student">

            + Add Student

        </a>

    </div>


    <!-- MAIN CARD -->

    <div class="content-card">


        <!-- =========================
             SEARCH FORM
             ========================= -->

        <form
            class="student-search"
            method="get"
            action="<%= contextPath %>/students">

            <input
                class="student-search-input"
                type="text"
                name="search"
                value="<%= search %>"
                placeholder="Search by ID, name, email, course or department...">

            <button
                class="student-search-btn"
                type="submit">

                <span class="search-icon"></span>

                Search

            </button>


            <a
                class="student-clear-btn"
                href="<%= contextPath %>/students">

                Clear

            </a>

        </form>


        <!-- =========================
             STUDENT COUNT
             ========================= -->

        <div class="student-count">

            Showing
            <strong><%= students.size() %></strong>
            student record(s)

            <% if (!search.isEmpty()) { %>

                &nbsp; for
                <strong>"<%= search %>"</strong>

            <% } %>

        </div>


        <!-- =========================
             STUDENT DATA
             ========================= -->

        <% if (students.isEmpty()) { %>


            <!-- EMPTY STATE -->

            <div class="empty-state">

                <div class="empty-icon">
                    +
                </div>

                <div class="empty-title">
                    No Students Found
                </div>

                <div class="empty-description">

                    <% if (!search.isEmpty()) { %>

                        No student records match your search.

                    <% } else { %>

                        There are no student records yet.

                    <% } %>

                </div>


                <% if (!search.isEmpty()) { %>

                    <a
                        class="add-button"
                        href="<%= contextPath %>/students">

                        Clear Search

                    </a>

                <% } else { %>

                    <a
                        class="add-button"
                        href="<%= contextPath %>/add-student">

                        + Add First Student

                    </a>

                <% } %>

            </div>


        <% } else { %>


            <!-- STUDENT TABLE -->

            <div class="table-container">

                <table class="student-table">

                    <thead>

                        <tr>

                            <th>
                                Student ID
                            </th>

                            <th>
                                Name
                            </th>

                            <th>
                                Email
                            </th>

                            <th>
                                Phone
                            </th>

                            <th>
                                Gender
                            </th>

                            <th>
                                Course
                            </th>

                            <th>
                                Department
                            </th>

                            <th>
                                Year
                            </th>

                            <th>
                                Actions
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (Student student : students) { %>


                        <tr>


                            <!-- STUDENT ID -->

                            <td>

                                <span class="student-id">
                                    <%= student.getStudentId() %>
                                </span>

                            </td>


                            <!-- NAME -->

                            <td>

                                <span class="student-name">
                                    <%= student.getName() %>
                                </span>

                            </td>


                            <!-- EMAIL -->

                            <td>

                                <span class="student-email">
                                    <%= student.getEmail() %>
                                </span>

                            </td>


                            <!-- PHONE -->

                            <td>
                                <%= student.getPhone() %>
                            </td>


                            <!-- GENDER -->

                            <td>

                                <% if ("Male".equalsIgnoreCase(
                                        student.getGender())) { %>

                                    <span class="gender-badge gender-male">
                                        Male
                                    </span>

                                <% } else if ("Female".equalsIgnoreCase(
                                        student.getGender())) { %>

                                    <span class="gender-badge gender-female">
                                        Female
                                    </span>

                                <% } else { %>

                                    <span class="gender-badge">
                                        <%= student.getGender() %>
                                    </span>

                                <% } %>

                            </td>


                            <!-- COURSE -->

                            <td>
                                <%= student.getCourse() %>
                            </td>


                            <!-- DEPARTMENT -->

                            <td>
                                <%= student.getDepartment() %>
                            </td>


                            <!-- YEAR -->

                            <td>
                                <%= student.getYear() %>
                            </td>


                            <!-- ACTIONS -->

                            <td>

                                <div class="actions">


                                    <a
                                        class="action-button view-button"
                                        href="<%= contextPath %>/student-details?id=<%= student.getStudentId() %>">

                                        View

                                    </a>


                                    <a
                                        class="action-button edit-button"
                                        href="<%= contextPath %>/edit-student?id=<%= student.getStudentId() %>">

                                        Edit

                                    </a>


                                    <a
                                        class="action-button delete-button"
                                        href="<%= contextPath %>/delete-student?id=<%= student.getStudentId() %>"
                                        onclick="return confirm('Are you sure you want to delete this student?');">

                                        Delete

                                    </a>

                                </div>

                            </td>


                        </tr>


                    <% } %>


                    </tbody>

                </table>

            </div>


        <% } %>


    </div>

</main>


</body>

</html>