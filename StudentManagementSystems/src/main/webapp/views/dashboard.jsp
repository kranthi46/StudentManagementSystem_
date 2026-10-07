<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>

<%
    int totalStudents = 0;
    int maleStudents = 0;
    int femaleStudents = 0;

    Object totalObj =
            request.getAttribute("totalStudents");

    Object maleObj =
            request.getAttribute("maleStudents");

    Object femaleObj =
            request.getAttribute("femaleStudents");

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
            totalStudents -
            maleStudents -
            femaleStudents;

    if (otherStudents < 0) {
        otherStudents = 0;
    }

    double malePercentage =
            totalStudents > 0
            ? maleStudents * 100.0 / totalStudents
            : 0;

    double femalePercentage =
            totalStudents > 0
            ? femaleStudents * 100.0 / totalStudents
            : 0;

    double otherPercentage =
            totalStudents > 0
            ? otherStudents * 100.0 / totalStudents
            : 0;

    String pieStyle =
            "conic-gradient("
            + "#2563eb 0% "
            + malePercentage
            + "%, "

            + "#ec4899 "
            + malePercentage
            + "% "
            + (malePercentage + femalePercentage)
            + "%, "

            + "#94a3b8 "
            + (malePercentage + femalePercentage)
            + "% 100%)";


    /*
     * Department data.
     */
    Map<String, Integer> departmentCounts =
            new LinkedHashMap<>();

    Object departmentObj =
            request.getAttribute("departmentCounts");

    if (departmentObj instanceof Map<?, ?>) {

        Map<?, ?> tempMap =
                (Map<?, ?>) departmentObj;

        for (Map.Entry<?, ?> entry :
                tempMap.entrySet()) {

            if (entry.getKey() != null &&
                    entry.getValue() instanceof Integer) {

                departmentCounts.put(
                        String.valueOf(entry.getKey()),
                        (Integer) entry.getValue()
                );
            }
        }
    }


    /*
     * Find largest department count.
     * Used to calculate bar width.
     */
    int maxDepartmentCount = 0;

    for (Integer count :
            departmentCounts.values()) {

        if (count != null &&
                count > maxDepartmentCount) {

            maxDepartmentCount = count;
        }
    }

    if (maxDepartmentCount == 0) {
        maxDepartmentCount = 1;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Dashboard - Student Management System
    </title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172033;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 80px;
            background: #162235;
            color: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 32px;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.10);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .brand-icon {
            width: 45px;
            height: 45px;

            background: #2864e6;
            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-weight: bold;
            font-size: 17px;
        }

        .brand h2 {
            margin: 0;
            font-size: 20px;
        }

        .brand span {
            display: block;
            margin-top: 3px;

            font-size: 12px;
            color: #b9c4d6;
        }

        .navbar nav {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .navbar nav a {
            color: white;
            text-decoration: none;

            padding: 11px 16px;
            border-radius: 8px;

            font-size: 14px;
        }

        .navbar nav a:hover {
            background: #26364d;
        }

        .navbar nav a.active {
            background: #2864e6;
        }

        .navbar nav a.logout-link {
            color: #ffb4b4;
        }


        /* ================= CONTAINER ================= */

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 25px 60px;
        }


        /* ================= WELCOME ================= */

        .welcome-section {
            display: flex;
            align-items: center;
            justify-content: space-between;

            margin-bottom: 30px;
        }

        .welcome-small {
            margin: 0 0 6px;

            color: #52719f;

            font-size: 13px;
            font-weight: bold;

            letter-spacing: 1.2px;
        }

        .welcome-section h1 {
            margin: 0 0 8px;

            font-size: 34px;
        }

        .welcome-section p {
            margin: 0;

            color: #718096;
        }

        .dashboard-date {
            background: white;

            padding: 14px 20px;

            border-radius: 12px;

            box-shadow:
                0 5px 20px
                rgba(20, 40, 80, 0.06);

            text-align: right;
        }

        .dashboard-date span {
            display: block;

            color: #7a8799;
            font-size: 12px;

            margin-bottom: 5px;
        }

        .dashboard-date strong {
            color: #16a34a;
            font-size: 14px;
        }


		        /* ================= STATISTICS ================= */
		
		.stats-grid {
		    display: grid;
		
		    grid-template-columns:
		        repeat(4, 1fr);
		
		    gap: 18px;
		
		    margin-bottom: 25px;
		}
		
		.stat-card {
		    background: white;
		
		    border-radius: 15px;
		
		    padding: 22px;
		
		    display: flex;
		    align-items: center;
		
		    gap: 16px;
		
		    box-shadow:
		        0 6px 25px
		        rgba(20, 40, 80, 0.07);
		
		    border: 1px solid #edf1f6;
		
		    /* Hover animation */
		    transition:
		        transform 0.25s ease,
		        box-shadow 0.25s ease,
		        border-color 0.25s ease;
		
		    cursor: pointer;
		}
		
		/* Card hover effect */
		.stat-card:hover {
		    transform: translateY(-6px);
		
		    box-shadow:
		        0 12px 30px
		        rgba(20, 40, 80, 0.14);
		
		    border-color: #d6e2ff;
		}
		
		
		/* ================= STAT ICON ================= */
		
		.stat-icon {
		    width: 52px;
		    height: 52px;
		
		    border-radius: 13px;
		
		    display: flex;
		    align-items: center;
		    justify-content: center;
		
		    font-size: 23px;
		
		    flex-shrink: 0;
		
		    transition:
		        transform 0.25s ease,
		        box-shadow 0.25s ease;
		}
		
		
		/* Icon hover effect */
		.stat-card:hover .stat-icon {
		    transform: scale(1.12) rotate(3deg);
		
		    box-shadow:
		        0 5px 15px
		        rgba(37, 99, 235, 0.15);
		}
		
		
		/* ================= ICON COLORS ================= */
		
		.total-card .stat-icon {
		    background: #eaf1ff;
		}
		
		.male-card .stat-icon {
		    background: #eaf1ff;
		}
		
		.female-card .stat-icon {
		    background: #fdeaf4;
		}
		
		.other-card .stat-icon {
		    background: #eef2f6;
		}
		
		
		/* ================= STAT TEXT ================= */
		
		.stat-content p {
		    margin: 0 0 5px;
		
		    color: #64748b;
		
		    font-size: 13px;
		
		    transition:
		        color 0.25s ease;
		}
		
		.stat-content h2 {
		    margin: 0 0 4px;
		
		    font-size: 28px;
		
		    transition:
		        transform 0.25s ease,
		        color 0.25s ease;
		}
		
		.stat-content span {
		    color: #94a3b8;
		
		    font-size: 11px;
		}


/* ================= TEXT HOVER ================= */

.stat-card:hover .stat-content p {
    color: #2563eb;
}

.stat-card:hover .stat-content h2 {
    color: #2563eb;

    transform: scale(1.05);
}
        /* ================= MAIN GRID ================= */

        .dashboard-grid {
            display: grid;

            grid-template-columns:
                1fr 1fr;

            gap: 22px;

            margin-bottom: 25px;
        }

        .dashboard-card {
            background: white;

            border-radius: 16px;

            padding: 25px;

            box-shadow:
                0 6px 25px
                rgba(20, 40, 80, 0.07);

            border: 1px solid #edf1f6;
        }

        .card-header {
            margin-bottom: 20px;
        }

        .card-header h2 {
            margin: 0 0 5px;

            font-size: 19px;
        }

        .card-header p {
            margin: 0;

            color: #718096;

            font-size: 13px;
        }


        /* ================= PIE CHART ================= */

        .chart-area {
            display: flex;

            align-items: center;
            justify-content: center;

            gap: 35px;

            min-height: 250px;
        }

        .pie-chart {
            width: 190px;
            height: 190px;

            border-radius: 50%;

            position: relative;

            display: flex;
            align-items: center;
            justify-content: center;

            flex-shrink: 0;
        }

        .pie-center {
            width: 105px;
            height: 105px;

            border-radius: 50%;

            background: white;

            display: flex;
            flex-direction: column;

            align-items: center;
            justify-content: center;

            box-shadow:
                0 3px 15px
                rgba(0, 0, 0, 0.08);
        }

        .pie-center strong {
            font-size: 26px;
        }

        .pie-center span {
            font-size: 11px;
            color: #718096;
        }

        .chart-legend {
            min-width: 150px;
        }

        .legend-item {
            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 18px;
        }

        .legend-color {
            width: 11px;
            height: 11px;

            border-radius: 50%;
        }

        .male-color {
            background: #2563eb;
        }

        .female-color {
            background: #ec4899;
        }

        .other-color {
            background: #94a3b8;
        }

        .legend-item div {
            flex: 1;
        }

        .legend-item strong {
            display: block;

            font-size: 13px;
        }

        .legend-item small {
            color: #94a3b8;
        }

        .legend-item b {
            font-size: 12px;
        }

/* ================= DEPARTMENT CHART ================= */

		.department-chart {
		    margin-top: 10px;
		}
		
		.department-row {
		    margin-bottom: 20px;
		}
		
		.department-info {
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    margin-bottom: 7px;
		}
		
		.department-name {
		    font-size: 13px;
		    font-weight: bold;
		    color: #334155;
		}
		
		.department-count {
		    font-size: 12px;
		    color: #64748b;
		    font-weight: bold;
		}
		
		.department-track {
		    width: 100%;
		    height: 12px;
		
		    background: #edf2f7;
		
		    border-radius: 20px;
		
		    overflow: hidden;
		
		    position: relative;
		}
		
		.department-fill {
		    height: 100%;
		
		    background: linear-gradient(
		        90deg,
		        #2563eb,
		        #4f8cff
		    );
		
		    border-radius: 20px;
		
		    min-width: 3px;
		
		    transition:
		        width 0.4s ease,
		        transform 0.2s ease,
		        box-shadow 0.2s ease,
		        filter 0.2s ease;
		
		    cursor: pointer;
		}
		
		/* Hover effect */
		.department-fill:hover {
		    transform: scaleY(1.35);
		
		    filter: brightness(1.08);
		
		    box-shadow:
		        0 3px 10px rgba(37, 99, 235, 0.35);
		}
		
		/* Hover effect for the complete department row */
		.department-row:hover .department-name {
		    color: #2563eb;
		}
		
		.department-row:hover .department-count {
		    color: #2563eb;
		}
		
		.department-row:hover .department-fill {
		    filter: brightness(1.08);
		}

        /* ================= QUICK ACTIONS ================= */

        .quick-actions {
            display: flex;

            flex-direction: column;

            gap: 12px;
        }

        .quick-action {
            display: flex;

            align-items: center;

            gap: 14px;

            padding: 16px;

            border: 1px solid #edf1f6;

            border-radius: 12px;

            text-decoration: none;

            color: #172033;

            transition:
                transform 0.2s,
                box-shadow 0.2s;
        }

        .quick-action:hover {
            transform: translateY(-2px);

            box-shadow:
                0 5px 15px
                rgba(20, 40, 80, 0.08);
        }

        .quick-icon {
            width: 42px;
            height: 42px;

            border-radius: 10px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #eaf1ff;

            color: #2563eb;

            font-size: 19px;
        }

        .quick-action strong {
            display: block;

            font-size: 14px;
        }

        .quick-action small {
            display: block;

            color: #94a3b8;

            margin-top: 4px;
        }

        .arrow {
            margin-left: auto;

            color: #2563eb;

            font-size: 20px;
        }


        /* ================= OVERVIEW ================= */

        .overview-card {
            margin-bottom: 25px;
        }

        .overview-content {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 30px;
        }

        .overview-top {
            display: flex;

            justify-content: space-between;

            margin-bottom: 9px;

            font-size: 13px;
        }

        .overview-top span {
            color: #64748b;
        }

        .progress {
            height: 8px;

            background: #edf2f7;

            border-radius: 20px;

            overflow: hidden;
        }

        .progress-fill {
            height: 100%;

            border-radius: 20px;
        }

        .total-progress {
            background: #2563eb;
        }

        .male-progress {
            background: #2563eb;
        }

        .female-progress {
            background: #ec4899;
        }


        /* ================= BOTTOM ACTIONS ================= */

        .bottom-actions {
            display: flex;

            gap: 15px;
        }

        .bottom-actions a {
            padding: 13px 20px;

            border-radius: 9px;

            text-decoration: none;

            font-weight: bold;

            font-size: 14px;
        }

        .primary-action {
            background: #2563eb;
            color: white;
        }

        .secondary-action {
            background: white;
            color: #2563eb;

            border: 1px solid #dbe3ef;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 1000px) {

            .stats-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 0 15px;
            }

            .navbar nav {
                gap: 2px;
            }

            .navbar nav a {
                padding: 8px;
                font-size: 12px;
            }

            .dashboard-container {
                padding: 25px 15px;
            }

            .welcome-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .chart-area {
                flex-direction: column;
            }

            .overview-content {
                grid-template-columns: 1fr;
            }

            .bottom-actions {
                flex-direction: column;
            }
        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<header class="navbar">

    <div class="brand">

        <div class="brand-icon">
            SM
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


    <!-- ================= WELCOME ================= -->

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

            <span>
                System Status
            </span>

            <strong>
                ● Online
            </strong>

        </div>

    </section>


    <!-- ================= STATISTICS ================= -->

    <section class="stats-grid">


        <div class="stat-card total-card">

            <div class="stat-icon">
                👨‍🎓
            </div>

            <div class="stat-content">

                <p>
                    Total Students
                </p>

                <h2>
                    <%= totalStudents %>
                </h2>

                <span>
                    Currently registered
                </span>

            </div>

        </div>


        <div class="stat-card male-card">

            <div class="stat-icon">
                👨
            </div>

            <div class="stat-content">

                <p>
                    Male Students
                </p>

                <h2>
                    <%= maleStudents %>
                </h2>

                <span>
                    <%= String.format("%.1f", malePercentage) %>%
                    of total
                </span>

            </div>

        </div>


        <div class="stat-card female-card">

            <div class="stat-icon">
                👩
            </div>

            <div class="stat-content">

                <p>
                    Female Students
                </p>

                <h2>
                    <%= femaleStudents %>
                </h2>

                <span>
                    <%= String.format("%.1f", femalePercentage) %>%
                    of total
                </span>

            </div>

        </div>


        <div class="stat-card other-card">

            <div class="stat-icon">
                👤
            </div>

            <div class="stat-content">

                <p>
                    Other
                </p>

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


    <!-- ================= CHARTS ================= -->

    <section class="dashboard-grid">


        <!-- GENDER PIE CHART -->

        <div class="dashboard-card">

            <div class="card-header">

                <h2>
                    Student Distribution
                </h2>

                <p>
                    Gender distribution of registered students
                </p>

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

                            <strong>
                                Male
                            </strong>

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

                            <strong>
                                Female
                            </strong>

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

                            <strong>
                                Other
                            </strong>

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


        <!-- DEPARTMENT BAR CHART -->

        <div class="dashboard-card">

            <div class="card-header">

                <h2>
                    Department Distribution
                </h2>

                <p>
                    Students grouped by department
                </p>

            </div>


            <div class="department-chart">


                <%
                    if (departmentCounts.isEmpty()) {
                %>

                    <div class="no-departments">

                        No department data available.

                    </div>

                <%
                    } else {

                        for (Map.Entry<String, Integer> entry :
                                departmentCounts.entrySet()) {

                            String department =
                                    entry.getKey();

                            int count =
                                    entry.getValue();

                            double barWidth =
                                    count * 100.0
                                    / maxDepartmentCount;
                %>


                    <div class="department-row">


                        <div class="department-info">

                            <span class="department-name">
                                <%= department %>
                            </span>

                            <span class="department-count">
                                <%= count %>
                                <%= count == 1
                                    ? "student"
                                    : "students" %>
                            </span>

                        </div>


                        <div class="department-track">

                            <div class="department-fill"
                                 style="width:<%= barWidth %>%;">
                            </div>

                        </div>


                    </div>


                <%
                        }
                    }
                %>


            </div>

        </div>


    </section>


    <!-- ================= QUICK ACTIONS ================= -->

    <section class="dashboard-card"
             style="margin-bottom:25px;">

        <div class="card-header">

            <h2>
                Quick Actions
            </h2>

            <p>
                Frequently used operations
            </p>

        </div>


        <div class="quick-actions">


            <a class="quick-action"
               href="<%= request.getContextPath() %>/views/add-student.jsp">

                <span class="quick-icon">
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

                <span class="quick-icon">
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

                <span class="quick-icon">
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

    </section>


    <!-- ================= OVERVIEW ================= -->

    <section class="dashboard-card overview-card">


        <div class="card-header">

            <h2>
                Student Overview
            </h2>

            <p>
                Current student database summary
            </p>

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
                         style="width:100%;">
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
                         style="width:<%= malePercentage %>%;">
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
                         style="width:<%= femalePercentage %>%;">
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