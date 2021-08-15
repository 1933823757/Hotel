package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Comment;
import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface FrontEndService {
    Map<String, Object> getRooms();

    Map<String, Object> getRoomFenYe(Integer valueOf, Integer valueOf1);

    Map<String, Object> getRoomOrder(String id);

    Map<String, Object> addComment(Comment comment);

    Map<String, Object> getCommentById(String id);

    Map<String, Object> getDeluxe(Integer pageNo,Integer pageSize);

    Map<String,Object> updateUser(User user);

    Map<String,Object> updateUserNotPath(User user);

    List<OrderInformAtion> getOrderUser(String id);

    Map<String, Object> deleteOrder(String id);
}
