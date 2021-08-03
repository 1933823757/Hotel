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
    public void text() {
        User user = new User();
        user.setId("1234578");
        user.setIdcard("asdfasfdasdfasfdf");
        user.setPassword("asdfasdfasfasf");
       int num = userDao.add(user);
        if (num == 1){
            System.out.println("添加成功");
        }else{
            System.out.println("添加失败");
        }
    }
}
