<%@ page contentType="text/html;charset=UTF-8" %>

<%
    int totalStudents = 0;
    int maleStudents = 0;
    int femaleStudents = 0;

    Object totalObj = request.getAttribute("totalStudents");
    Object maleObj = request.getAttribute("maleStudents");
    Object femaleObj = request.getAttribute("femaleStudents");

    if (totalObj != null) {
        totalStudents = (Integer) totalObj;
    }

    if (maleObj != null) {
        maleStudents = (Integer) maleObj;
    }

    if (femaleObj != null) {
        femaleStudents = (Integer) femaleObj;
    }

    int otherStudents =
            totalStudents - maleStudents - femaleStudents;

    if (otherStudents < 0) {
        otherStudents = 0;
    }

    double malePercentage =
            totalStudents > 0
            ? (maleStudents * 100.0 / totalStudents)
            : 0;

    double femalePercentage =
            totalStudents > 0
            ? (femaleStudents * 100.0 / totalStudents)
            : 0;

    double otherPercentage =
            totalStudents > 0
            ? (otherStudents * 100.0 / totalStudents)
            : 0;

    String pieStyle =
            "conic-gradient("
            + "#2563eb 0% " + malePercentage + "%, "
            + "#ec4899 " + malePercentage + "% "
            + (malePercentage + femalePercentage) + "%, "
            + "#94a3b8 " + (malePercentage + femalePercentage)
            + "% 100%)";
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Dashboard - Student Management System</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<header class="navbar">

    <div class="brand">

        <div class="brand-icon">
            🎓
        </div>

        <div>
            <h2>Student Management</h2>
            <span>Administration Portal</span>
        </div>

    </div>

    <nav>

        <a class="active"
           href="<%= request.getContextPath() %>/dashboard">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/students">
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


<!-- ================= MAIN ================= -->

<main class="dashboard-container">

    <!-- Welcome -->

    <section class="welcome-section">

        <div>

            <p class="welcome-small">
                ADMINISTRATOR PANEL
            </p>

            <h1>
                Dashboard
            </h1>

            <p>
                Manage students and monitor your
                student database from one place.
            </p>

        </div>

        <div class="dashboard-date">

            <span>System Status</span>

            <strong>
                ● Online
            </strong>

        </div>

    </section>


    <!-- ================= STATISTICS ================= -->

    <section class="stats-grid">

        <!-- Total -->

        <div class="stat-card total-card">

            <div class="stat-icon">
                👨‍🎓
            </div>

            <div class="stat-content">

                <p>Total Students</p>

                <h2>
                    <%= totalStudents %>
                </h2>

                <span>
                    Currently registered
                </span>

            </div>

        </div>


        <!-- Male -->

        <div class="stat-card male-card">

            <div class="stat-icon">
                👨
            </div>

            <div class="stat-content">

                <p>Male Students</p>

                <h2>
                    <%= maleStudents %>
                </h2>

                <span>
                    <%= String.format("%.1f", malePercentage) %>%
                    of total
                </span>

            </div>

        </div>


        <!-- Female -->

        <div class="stat-card female-card">

            <div class="stat-icon">
                👩
            </div>

            <div class="stat-content">

                <p>Female Students</p>

                <h2>
                    <%= femaleStudents %>
                </h2>

                <span>
                    <%= String.format("%.1f", femalePercentage) %>%
                    of total
                </span>

            </div>

        </div>


        <!-- Other -->

        <div class="stat-card other-card">

            <div class="stat-icon">
                👤
            </div>

            <div class="stat-content">

                <p>Other</p>

                <h2>
                    <%= otherStudents %>
                </h2>

                <span>
                    <%= String.format("%.1f", otherPercentage) %>%
                    of total
                </span>

            </div>

        </div>

    </section>


    <!-- ================= CHART + QUICK ACTIONS ================= -->

    <section class="dashboard-grid">


        <!-- PIE CHART -->

        <div class="dashboard-card chart-card">

            <div class="card-header">

                <div>

                    <h2>
                        Student Distribution
                    </h2>

                    <p>
                        Gender distribution of registered students
                    </p>

                </div>

            </div>


            <div class="chart-area">

                <div class="pie-chart"
                     style="<%= pieStyle %>">

                    <div class="pie-center">

                        <strong>
                            <%= totalStudents %>
                        </strong>

                        <span>
                            Students
                        </span>

                    </div>

                </div>


                <div class="chart-legend">

                    <div class="legend-item">

                        <span class="legend-color male-color"></span>

                        <div>
                            <strong>Male</strong>
                            <small>
                                <%= maleStudents %> students
                            </small>
                        </div>

                        <b>
                            <%= String.format("%.1f", malePercentage) %>%
                        </b>

                    </div>


                    <div class="legend-item">

                        <span class="legend-color female-color"></span>

                        <div>
                            <strong>Female</strong>
                            <small>
                                <%= femaleStudents %> students
                            </small>
                        </div>

                        <b>
                            <%= String.format("%.1f", femalePercentage) %>%
                        </b>

                    </div>


                    <div class="legend-item">

                        <span class="legend-color other-color"></span>

                        <div>
                            <strong>Other</strong>
                            <small>
                                <%= otherStudents %> students
                            </small>
                        </div>

                        <b>
                            <%= String.format("%.1f", otherPercentage) %>%
                        </b>

                    </div>

                </div>

            </div>

        </div>


        <!-- QUICK ACTIONS -->

        <div class="dashboard-card quick-card">

            <div class="card-header">

                <div>

                    <h2>
                        Quick Actions
                    </h2>

                    <p>
                        Frequently used operations
                    </p>

                </div>

            </div>


            <div class="quick-actions">

                <a class="quick-action"
                   href="<%= request.getContextPath() %>/views/add-student.jsp">

                    <span class="quick-icon add-icon">
                        +
                    </span>

                    <div>

                        <strong>
                            Add Student
                        </strong>

                        <small>
                            Register a new student
                        </small>

                    </div>

                    <span class="arrow">
                        →
                    </span>

                </a>


                <a class="quick-action"
                   href="<%= request.getContextPath() %>/students">

                    <span class="quick-icon view-icon">
                        👥
                    </span>

                    <div>

                        <strong>
                            View Students
                        </strong>

                        <small>
                            Browse all students
                        </small>

                    </div>

                    <span class="arrow">
                        →
                    </span>

                </a>


                <a class="quick-action"
                   href="<%= request.getContextPath() %>/students">

                    <span class="quick-icon search-icon">
                        🔍
                    </span>

                    <div>

                        <strong>
                            Search Students
                        </strong>

                        <small>
                            Find student records
                        </small>

                    </div>

                    <span class="arrow">
                        →
                    </span>

                </a>

            </div>

        </div>

    </section>


    <!-- ================= OVERVIEW ================= -->

    <section class="dashboard-card overview-card">

        <div class="card-header">

            <div>

                <h2>
                    Student Overview
                </h2>

                <p>
                    Current student database summary
                </p>

            </div>

            <a class="view-all"
               href="<%= request.getContextPath() %>/students">

                View All →

            </a>

        </div>


        <div class="overview-content">


            <div class="overview-item">

                <div class="overview-top">

                    <span>
                        Total Students
                    </span>

                    <strong>
                        <%= totalStudents %>
                    </strong>

                </div>

                <div class="progress">

                    <div class="progress-fill total-progress"
                         style="width:100%">
                    </div>

                </div>

            </div>


            <div class="overview-item">

                <div class="overview-top">

                    <span>
                        Male Students
                    </span>

                    <strong>
                        <%= maleStudents %>
                    </strong>

                </div>

                <div class="progress">

                    <div class="progress-fill male-progress"
                         style="width:<%= malePercentage %>%">
                    </div>

                </div>

            </div>


            <div class="overview-item">

                <div class="overview-top">

                    <span>
                        Female Students
                    </span>

                    <strong>
                        <%= femaleStudents %>
                    </strong>

                </div>

                <div class="progress">

                    <div class="progress-fill female-progress"
                         style="width:<%= femalePercentage %>%">
                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- ================= BOTTOM ACTIONS ================= -->

    <section class="bottom-actions">

        <a href="<%= request.getContextPath() %>/views/add-student.jsp"
           class="primary-action">

            <span>+</span>

            Add New Student

        </a>


        <a href="<%= request.getContextPath() %>/students"
           class="secondary-action">

            <span>👥</span>

            Manage Students

        </a>

    </section>

</main>

</body>

</html>