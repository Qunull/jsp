package servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyServlet3 extends HttpServlet {
    //get请求
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
        this.doPost(req, resp); // 内部调用
        //1.接收请求 并决定 调用哪一个JavaBean
        //2.接收数据在之后 决定 使用哪一个 视图（jsp）进行显示
    }

    //post请求
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        System.out.println("接收请求，处理请求...");
    }
}
