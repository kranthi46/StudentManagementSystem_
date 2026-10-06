package com.sms.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.util.UserStorage;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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


        if (username != null) {
            username = username.trim();
        }


        if (username == null
                || username.isEmpty()
                || password == null
                || password.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Username and password are required."
            );

            request.getRequestDispatcher(
                    "/views/login.jsp"
            ).forward(
                    request,
                    response
            );

            return;
        }


        /*
         * UserStorage verifies the password
         * against the PBKDF2 hash.
         */
        if (UserStorage.validateUser(
                username,
                password)) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "loggedIn",
                    true
            );

            session.setAttribute(
                    "username",
                    username
            );


            response.sendRedirect(
                    request.getContextPath()
                            + "/dashboard"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Invalid username or password."
            );

            request.getRequestDispatcher(
                    "/views/login.jsp"
            ).forward(
                    request,
                    response
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
                        + "/views/login.jsp"
        );
    }
}