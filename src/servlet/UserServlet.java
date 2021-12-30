package servlet;

import entity.User;
import service.user.UserService;
import service.user.imlp.UserServiceImpl;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       /* //接收ajax的请求 并返回信息
        String opr = request.getParameter("opr");
        //1.通过response 获取输出流
        PrintWriter out = response.getWriter();
        if (opr.equals("userByName")){
            String name = request.getParameter("name");
            User user = userService.getUserByName(name);
            if (user != null){//数据库存在数据 已被注册 false
                //2.使用out.print() 返回数据
                out.print(false);
            }else{
                out.print(true);
            }
        }
        out.flush();
        out.close();
    }*/


        //接收ajax的请求 并返回信息
        String opr = request.getParameter("opr");
        //1.通过response 获取输出流
        PrintWriter out = response.getWriter();
        if (opr.equals("email")) {
            String email = request.getParameter("email");
            User user = userService.getEmail(email);
            if (user != null) {//数据库存在数据 已被注册 false
                //2.使用out.print() 返回数据
                out.print(false);
            } else {
                out.print(true);
            }
        }
        out.flush();
        out.close();
    }
}
