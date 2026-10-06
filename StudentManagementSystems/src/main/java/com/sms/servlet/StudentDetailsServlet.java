package com.sms.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.model.Student;
import com.sms.service.StudentService;

@WebServlet("/student-details")
public class StudentDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/students?error=Student+ID+missing"
            );

            return;
        }

        Student student =
                studentService.getStudent(id);

        if (student == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/students?error=Student+not+found"
            );

            return;
        }

        request.setAttribute(
                "student",
                student
        );

        request.getRequestDispatcher(
                "/views/student-details.jsp"
        ).forward(request, response);
    }

    private boolean isLoggedIn(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null
                && Boolean.TRUE.equals(
                        session.getAttribute("loggedIn"));
    }
}