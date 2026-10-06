package com.sms.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.model.Student;
import com.sms.service.StudentService;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether user is logged in
        HttpSession session =
                request.getSession(false);

        if (session == null ||
                !Boolean.TRUE.equals(
                        session.getAttribute("loggedIn"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        // Get search keyword from URL
        String search =
                request.getParameter("search");

        List<Student> students;

        // No search text -> show all students
        if (search == null ||
                search.trim().isEmpty()) {

            search = "";

            students =
                    studentService.getAllStudents();

        } else {

            // Remove unnecessary spaces
            search = search.trim();

            // Search students
            students =
                    studentService.searchStudents(search);
        }

        // Send student list to JSP
        request.setAttribute(
                "students",
                students
        );

        // Send search text to JSP
        request.setAttribute(
                "search",
                search
        );

        // Open Students page
        request.getRequestDispatcher(
                "/views/students.jsp"
        ).forward(request, response);
    }
}