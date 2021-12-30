package service.user.imlp;

import dao.user.UserDao;
import dao.user.UserDaoImpl;
import entity.User;
import service.user.UserService;

import java.sql.SQLException;
import java.util.List;

public class UserServiceImpl implements UserService {
    private UserDao userDao;//面向接口编程

    public UserServiceImpl() {
        userDao = new UserDaoImpl();
    }

    //调用 UserDaoImpl的查询方法
    @Override
    public List<User> getUserList() throws SQLException {

        return userDao.getUserList();
    }

    @Override
    public User getUserByName(String name) {
        return userDao.getUserByName(name);
    }

    @Override
    public User getEmail(String email) {
        return userDao.getEmail(email);
    }
}
