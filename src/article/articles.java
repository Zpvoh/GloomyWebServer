package article;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import static java.lang.System.out;

@WebServlet(name = "articles")
public class articles extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置网页响应类型
        response.setContentType("text/html");
        //实现具体操作
        PrintWriter out = response.getWriter();
        out.println("This is a new servlet page "+request.getQueryString());

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/articles", "root", "82870808qyy");
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery("SELECT content FROM articleNames");

            while(rs.next()){
                out.println(rs.getString("content"));
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
