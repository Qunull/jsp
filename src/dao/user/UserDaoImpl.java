package dao.user;

import dao.BaseDaoImpl;
import entity.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl extends BaseDaoImpl implements UserDao {
    @Override
    public List<User> getUserList() throws SQLException {
        String sql = "select * from news_user";
        List<User> userList = new ArrayList<>(); //创建用户集合
        ResultSet rs = executeSelect(sql); //执行SQL 获得结果集

        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUserName(rs.getString("userName"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setUserType(rs.getInt("userType"));
            //user 添加到集合
            userList.add(user);
        }
        //执行关闭资源
        closeResource();
        return userList;
    }

    @Override
    public int addUser(User user) {
        String sql = "insert into news_user(userName,password,email,userType) values(?,?,?,?)";
        int count = executeModify(sql, user.getUserName(), user.getPassword(), user.getEmail(), user.getUserType());
        return count;
    }

    @Override
    public int updateUser(User user) {
        String sql = "update news_user set userName=?,password=?,email=?,userType=? where id=?";
        int count = executeModify(sql, user.getUserName(), user.getPassword(),
                user.getEmail(), user.getUserType(), user.getId());
        return count;
    }

    @Override
    public int deleteUser(Integer id) {
        String sql = "delete from news_user where id=?";
        int count = executeModify(sql, id);
        return count;
    }

    @Override
    public User getUserByName(String name) {
        User user = null;
        try {
            String sql = "select * from news_user where userName like CONCAT('%',?,'%')";
            rs = this.executeSelect(sql, name);
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("userName"));
                user.setUserType(rs.getInt("userType"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return user;
    }

    @Override
    public User getEmail(String email) {
        User user = null;
        try {
            String sql = "select * from news_user where email like CONCAT('%',?,'%')";
            rs = this.executeSelect(sql, email);
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("userName"));
                user.setUserType(rs.getInt("userType"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return user;
    }

}
