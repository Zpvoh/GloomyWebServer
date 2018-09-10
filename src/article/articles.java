package article;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.util.Scanner;

@WebServlet(name = "articles")
public class articles extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置网页响应类型
        response.setContentType("text/html;charset=utf-8");
        //实现具体操作
        PrintWriter out = response.getWriter();
        //out.println("This is a new servlet page "+request.getQueryString());
        String name=request.getParameter("name");
        if(!name.equals("Zpvoh") && !name.equals("zpvoh")){
            out.println("invalid");
            return;
        }

        String ip="";
        String username="";
        String pass="";
        String path="";

        try {
            File file=new File("/info");
            path=file.getAbsolutePath();
            out.println(path);

            FileInputStream fileStream=new FileInputStream(file);
            Scanner input= new Scanner(fileStream);
            ip=input.nextLine();
            username=input.nextLine();
            pass=input.nextLine();
            fileStream.close();
        } catch (FileNotFoundException e) {
            out.println("no info file");
        } catch (IOException e) {
            out.println("IO problem");
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://"+ip+":3306/articles", username, pass);
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery("SELECT * FROM articles");

            JsonArray json=new JsonArray();
            while(rs.next()){
                JsonObject data=new JsonObject();
                data.addProperty("id", rs.getString("id"));
                data.addProperty("title", rs.getString("title"));
                data.addProperty("theme", rs.getString("theme"));
                data.addProperty("description", rs.getString("description"));
                data.addProperty("cover_img", rs.getString("cover_img"));
                data.addProperty("time", rs.getDate("time").toString());
                data.addProperty("content", rs.getString("content"));
                json.add(data);
            }
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
