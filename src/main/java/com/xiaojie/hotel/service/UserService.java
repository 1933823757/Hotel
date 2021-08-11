package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    User getUser(User user);

    boolean register(User user);
    List<User> findAll();

    Map<String, Object> addUser(User user);

    Map<String, Object> getUserList(User user,Integer pageNo,Integer pageSize);

    User getUserById(String id);

    Map<String, Object> updateUser(User user);

    Map<String, Object> deleteUser(String[] id);
}
