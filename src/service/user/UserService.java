package service.user;

import entity.User;

import java.sql.SQLException;
import java.util.List;

//用户 相关的业务
public interface UserService {
    List<User> getUserList() throws SQLException;
    /**
     * 根据用户名 查询用户信息
     * @param name
     * @return
     */
    User getUserByName(String name);

    User getEmail(String email);
}
