package com.xiaojie.hotel.service.Impl;

import com.xiaojie.hotel.dao.UserDao;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.UserService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

//    登录验证方法
    @Override
    public User getUser(User user) {
        User ur = userDao.selectUser(user);
        return ur;
    }
//  注册方法
    @Override
    public boolean register(User user) {
        int num = userDao.addUser(user);
        if (num != 1){
            return  false;
        }
        return true;
    }

    @Override
    public  List<User>  findAll() {
        List<User> user = userDao.selectAll();
        return user;
    }
}
