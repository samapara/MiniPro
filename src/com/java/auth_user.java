package com.java;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class auth_user extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String mis_id = req.getParameter("txt_id");
        String pass = req.getParameter("txt_pass");
        PreparedStatement preparedStatement;
        myDB db = new myDB();
        Connection con = db.getCon();
        if (con != null) {
            try {
                HttpSession session = req.getSession();

                preparedStatement = con.prepareStatement("select mis_id,password from teacher_login where mis_id=? and password=?");
                preparedStatement.setString(1, mis_id);
                preparedStatement.setString(2, pass);
                ResultSet resultSet = preparedStatement.executeQuery();
                if (resultSet.next()) {
                    session.setAttribute("user_name", mis_id);
                    resp.sendRedirect("/booking.jsp");
                } else {
                    session.setAttribute("errorMessage","Invalid");
                    session.setAttribute("user_name", null);
                    req.getRequestDispatcher("/index.jsp").forward(req,resp);
                }
            } catch (SQLException e) {
                e.printStackTrace();


            }

        } else {
            PrintWriter o = resp.getWriter();
            o.print("Connection Failed!");
        }

    }


}