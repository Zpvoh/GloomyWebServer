package article;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import uniform.InfoReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "FetchArticle")
public class FetchArticle extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置网页响应类型
        response.setContentType("text/html;charset=utf-8");
        //实现具体操作
        PrintWriter out = response.getWriter();
        //out.println("This is a new servlet page "+request.getQueryString());
        String name = request.getParameter("name");

        if (!name.equals("Zpvoh") && !name.equals("zpvoh")) {
            out.print("invalid");
            return;
        }

        InfoReader reader=new InfoReader();
        //out.println(reader.path)

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://"+reader.getIp()+":3306/articles", reader.getUsername(), reader.getPass());
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM articles WHERE id=" + request.getParameter("id"));
            rs.next();

            JsonArray json = new JsonArray();
            JsonObject data = new JsonObject();
            data.addProperty("id", rs.getString("id"));
            data.addProperty("title", rs.getString("title"));
            data.addProperty("theme", rs.getString("theme"));
            data.addProperty("description", rs.getString("description"));
            data.addProperty("cover_img", rs.getString("cover_img"));
            data.addProperty("time", rs.getDate("time").toString());
            data.addProperty("content", rs.getString("content"));
            json.add(data);
            out.println(json.toString());

            rs.close();
            stmt.close();
            conn.close();


        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
