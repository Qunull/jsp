package listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class HttpListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        //针对于 ServletContext 对象 进行 监听
        ServletContext sc = httpSessionEvent.getSession().getServletContext();
        Integer userCount = (Integer) sc.getAttribute("userCount");
        if (userCount == null) {
            sc.setAttribute("userCount", new Integer(1));
        } else {
            sc.setAttribute("userCount", ++userCount);
        }
        //重新获取一遍
        userCount = (Integer) sc.getAttribute("userCount");
        System.out.println("目前在线人数是：" + userCount);
        //httpSessionEvent.getSession().invalidate();//失效方法
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        //针对于 ServletContext 对象 进行 监听
        ServletContext sc = httpSessionEvent.getSession().getServletContext();
        Integer userCount = (Integer) sc.getAttribute("userCount");
        if (userCount == null) {
            sc.setAttribute("userCount", new Integer(0));
        } else {
            sc.setAttribute("userCount", --userCount);
        }
        //重新获取一遍
        userCount = (Integer) sc.getAttribute("userCount");
        System.out.println("目前在线人数是：" + userCount);
    }
}
