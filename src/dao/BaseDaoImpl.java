package dao;

import util.ConfigManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class BaseDaoImpl implements BaseDao {
    protected Connection conn;
    protected PreparedStatement ps;
    protected ResultSet rs;
    @Override
    public Connection createConnection() {
        String driver = ConfigManager.getInstance().getProperties("driver");
        String url = ConfigManager.getInstance().getProperties("url");
        String username = ConfigManager.getInstance().getProperties("username");
        String password = ConfigManager.getInstance().getProperties("password");
        //1.加载驱动
        try {
            Class.forName(driver);//反射
            //2.创建Connection连接对象  url,username,password
            conn = DriverManager.getConnection(url,username,password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return conn;
    }

    @Override
    public Connection createJNDIConnection() {
        try {
            Context ctx = new InitialContext(); //web容器的 上下文对象
            DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/news");
            //利用数据源获取conn对象
            conn = ds.getConnection();
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return conn;
    }

    @Override
    public void closeResource() {
        try {
            if(rs!=null)
                rs.close();
            if(ps!=null)
                ps.close();
            if(conn!=null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ResultSet executeSelect(String sql, Object... params) {
        conn = createConnection();
        //conn = createJNDIConnection();
        ResultSet rs = null;
        if(conn!=null){
            try {
                ps = conn.prepareStatement(sql);
                for(int i=0;i<params.length;i++){
                    ps.setObject(i+1,params[i]);
                }
                rs = ps.executeQuery();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return rs;
    }

    @Override
    public int executeModify(String sql, Object... params) {
        conn = createConnection();
        //conn = createJNDIConnection();
        int count = 0;
        if(conn!=null){
            try {
                ps = conn.prepareStatement(sql);
                for(int i=0;i<params.length;i++){
                    ps.setObject(i+1,params[i]);
                }
                count = ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    public static void main(String[] args) {

    }
}
