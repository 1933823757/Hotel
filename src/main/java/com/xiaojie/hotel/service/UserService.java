package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.User;

import java.util.List;

public interface UserService {

    User getUser(User user);

    boolean register(User user);
    List<User> findAll();
}
