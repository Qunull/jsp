package util;

import java.sql.*;

public class JDBCUtil {
    public static void main(String[] args) {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        try {
            //1.加载驱动
            Class.forName("com.mysql.cj.jdbc.Driver");//反射
            //2.创建Connection连接对象 url,username,password
            String url = "jdbc:mysql://127.0.0.1:3306/kgcnews?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai";
            String username = "root";
            String password = "123456";
            conn = DriverManager.getConnection(url,username,password);
            if (conn != null){
                System.out.println("连接成功。。。");
            }else{
                System.out.println("连接失败。。。");
            }
            //3.执行SQL语句
            String sql = "select * from news_user";
            statement = conn.createStatement();
            rs = statement.executeQuery(sql);
            //4.解析结果集sssssssdxdx
            while(rs.next()){
                //循环一次就是一整行数据
                Long id = rs.getLong("id");
                String userName = rs.getString("userName");
                System.out.println("用户ID："+id+"\t"+"用户名："+userName);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                rs.close();
                statement.close();
                conn.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
