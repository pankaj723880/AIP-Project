package com.quizapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/submit-quiz")
public class SubmitQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int score = 0;
        int total = Integer.parseInt(request.getParameter("total"));

        for (int i = 1; i <= total; i++) {
            String selected = request.getParameter("q" + i);
            String correct = request.getParameter("correct" + i);
            if (selected != null && selected.equals(correct)) {
                score++;
            }
        }

        request.setAttribute("score", score);
        request.setAttribute("total", total);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
