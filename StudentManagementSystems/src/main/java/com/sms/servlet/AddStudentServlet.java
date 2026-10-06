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

@WebServlet("/add-student")
public class AddStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check login
        if (!isLoggedIn(request)) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        // Open Add Student page
        request.getRequestDispatcher(
                "/views/add-student.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check login
        if (!isLoggedIn(request)) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        request.setCharacterEncoding("UTF-8");

        // Get form values
        String studentId =
                request.getParameter("studentId");

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String gender =
                request.getParameter("gender");

        String dob =
                request.getParameter("dob");

        String course =
                request.getParameter("course");

        String department =
                request.getParameter("department");

        String year =
                request.getParameter("year");

        String address =
                request.getParameter("address");

        // Create Student object
        Student student = new Student(
                studentId,
                name,
                email,
                phone,
                gender,
                dob,
                course,
                department,
                year,
                address
        );

        // Save student
        boolean added =
                studentService.addStudent(student);

        if (added) {

            // Successfully added
            response.sendRedirect(
                    request.getContextPath()
                            + "/students?message=Student+added+successfully"
            );

        } else {

            // Student ID already exists
            request.setAttribute(
                    "error",
                    "Student ID already exists."
            );

            request.setAttribute(
                    "student",
                    student
            );

            request.getRequestDispatcher(
                    "/views/add-student.jsp"
            ).forward(request, response);
        }
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