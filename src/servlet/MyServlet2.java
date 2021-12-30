package servlet;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;

public class MyServlet2 extends GenericServlet {
    //核心操作
    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {
        //1.接收请求 并决定 调用哪一个JavaBean


        //2.接收数据在之后 决定 使用哪一个 视图（jsp）进行显示
    }
}
