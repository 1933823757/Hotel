package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.User;

import java.util.List;

public interface UserDao {

    User selectUser(User user);

    int addUser(User user);

    List<User> selectAll();
}
