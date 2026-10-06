package com.sms.servlet;

import java.io.IOException;

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

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                !Boolean.TRUE.equals(
                        session.getAttribute("loggedIn"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        request.setAttribute(
                "totalStudents",
                studentService.getTotalStudents()
        );

        request.setAttribute(
                "maleStudents",
                studentService.getMaleStudents()
        );

        request.setAttribute(
                "femaleStudents",
                studentService.getFemaleStudents()
        );

        request.getRequestDispatcher(
                "/views/dashboard.jsp"
        ).forward(request, response);
    }
}