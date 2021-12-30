package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public interface BaseDao {
    /**
     * JDBC获取 连接对象；打开连接
     * @return
     */
    Connection createConnection();

    /**
     * JNDI方式 获取连接对象
     * @return
     */
    Connection createJNDIConnection();

    /**
     * 关闭 资源
     * @param
     * @param
     * @param
     */
    void closeResource();

    /**
     * 查询操作
     * @param sql
     * @param params
     * @return
     */
    ResultSet executeSelect(String sql,Object... params);

    /**
     * 增删改 操作
     * @param sql
     * @param params
     * @return
     */
    int executeModify(String sql,Object... params);
}
