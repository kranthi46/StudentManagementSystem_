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

@WebServlet("/edit-student")
public class EditStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Prevent browser from caching the Edit Student page.
         */
        setNoCacheHeaders(response);

        /*
         * Check login.
         */
        if (!isLoggedIn(request)) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        /*
         * Get student ID.
         */
        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/students?error=Student+ID+missing"
            );

            return;
        }

        /*
         * Get student.
         */
        Student student =
                studentService.getStudent(id);

        if (student == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/students?error=Student+not+found"
            );

            return;
        }

        /*
         * Send student to JSP.
         */
        request.setAttribute(
                "student",
                student
        );

        /*
         * Open Edit Student page.
         */
        request.getRequestDispatcher(
                "/views/edit-student.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Prevent browser from caching the response.
         */
        setNoCacheHeaders(response);

        /*
         * Check login.
         */
        if (!isLoggedIn(request)) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        request.setCharacterEncoding("UTF-8");

        /*
         * Get form values.
         */
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

        /*
         * Create Student object.
         */
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

        /*
         * Update student.
         */
        boolean updated =
                studentService.updateStudent(student);

        if (updated) {

            /*
             * Successfully updated.
             */
            response.sendRedirect(
                    request.getContextPath()
                            + "/students?message=Student+updated+successfully"
            );

        } else {

            /*
             * Update failed.
             */
            request.setAttribute(
                    "error",
                    "Unable to update student."
            );

            request.setAttribute(
                    "student",
                    student
            );

            request.getRequestDispatcher(
                    "/views/edit-student.jsp"
            ).forward(request, response);
        }
    }

    /*
     * Prevent browser from caching protected pages.
     */
    private void setNoCacheHeaders(
            HttpServletResponse response) {

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
    }

    /*
     * Check whether the user is logged in.
     */
    private boolean isLoggedIn(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        return session != null
                && Boolean.TRUE.equals(
                        session.getAttribute("loggedIn"));
    }
}