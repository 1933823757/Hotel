package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.User;

public interface UserDao {

    User selectUser(User user);

    int addUser(User user);
}
