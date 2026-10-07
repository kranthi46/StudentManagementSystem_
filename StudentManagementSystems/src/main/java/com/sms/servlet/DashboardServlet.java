package com.sms.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.service.StudentService;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Prevent browser from caching the dashboard.
         *
         * This is important because after logout,
         * the browser should not display the old dashboard
         * when the user clicks the Back button.
         */
        response.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate"
        );

        response.setHeader(
                "Pragma",
                "no-cache"
        );

        response.setDateHeader(
                "Expires",
                0
        );

        /*
         * Check login.
         */
        HttpSession session =
                request.getSession(false);

        if (session == null ||
                !Boolean.TRUE.equals(
                        session.getAttribute("loggedIn"))) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }

        /*
         * Total students.
         */
        request.setAttribute(
                "totalStudents",
                studentService.getTotalStudents()
        );

        /*
         * Male students.
         */
        request.setAttribute(
                "maleStudents",
                studentService.getMaleStudents()
        );

        /*
         * Female students.
         */
        request.setAttribute(
                "femaleStudents",
                studentService.getFemaleStudents()
        );

        /*
         * Department-wise student count.
         */
        Map<String, Integer> departmentCounts =
                studentService.getDepartmentCounts();

        request.setAttribute(
                "departmentCounts",
                departmentCounts
        );

        /*
         * Open dashboard.
         */
        request.getRequestDispatcher(
                "/views/dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}