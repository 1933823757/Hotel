package com.xiaojie.hotel.service.Impl;

import com.xiaojie.hotel.dao.UserDao;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }


    @Override
    public User getUser(User user) {
        User ur = userDao.selectUser(user);
        return ur;
    }
}
