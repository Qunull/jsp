package dao.user;

import entity.User;

import java.sql.SQLException;
import java.util.List;

// 对用户表的 所有操作
public interface UserDao {
    /**
     * 查询全部的用户信息列表
     * @return
     */
    List<User> getUserList() throws SQLException;

    /**
     * 添加用户
     * @param user
     * @return
     */
    int addUser(User user);

    /**
     * 修改用户
     * @param user
     * @return
     */
    int updateUser(User user);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteUser(Integer id);

    /**
     * 根据用户名 查询用户信息
     * @param name
     * @return
     */
    User getUserByName(String name);

    /**
     * 根据邮箱查询
     * @param email
     * @return
     */
    User getEmail(String email);
}
