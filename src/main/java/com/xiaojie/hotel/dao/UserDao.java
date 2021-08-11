package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.User;

import java.util.List;

public interface UserDao {

    User selectUser(User user);

    int addUser(User user);

    List<User> selectAll();

    int addUserAll(User user);

    List<User> getuserList(User user);

    int selectUserByUserName(String username);

    User getUserById(String id);

    int updateUser(User user);

    int updateUserAndImg(User user);

    int deleteUser(String[] id);
}
