package com.sms.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sms.util.UserStorage;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");


        if (username != null) {
            username = username.trim();
        }


        if (username == null
                || username.isEmpty()) {

            showError(
                    request,
                    response,
                    "Username is required."
            );

            return;
        }


        if (password == null
                || password.isEmpty()) {

            showError(
                    request,
                    response,
                    "Password is required."
            );

            return;
        }


        if (password.length() < 6) {

            showError(
                    request,
                    response,
                    "Password must contain at least 6 characters."
            );

            return;
        }


        if (!password.equals(confirmPassword)) {

            showError(
                    request,
                    response,
                    "Passwords do not match."
            );

            return;
        }


        if (UserStorage.userExists(username)) {

            showError(
                    request,
                    response,
                    "Username already exists."
            );

            return;
        }


        boolean registered =
                UserStorage.registerUser(
                        username,
                        password
                );


        if (registered) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login?success=registered"
            );

        } else {

            showError(
                    request,
                    response,
                    "Unable to create account."
            );
        }
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                        + "/views/signup.jsp"
        );
    }


    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws ServletException, IOException {

        request.setAttribute(
                "error",
                message
        );

        request.getRequestDispatcher(
                "/views/signup.jsp"
        ).forward(
                request,
                response
        );
    }
}