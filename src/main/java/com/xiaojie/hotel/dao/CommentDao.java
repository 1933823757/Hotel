package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Comment;
import com.xiaojie.hotel.domian.Room;

import java.util.List;

public interface CommentDao {
    List<Comment> getCommentList(Comment comment);

    Comment getCommentById(String id);

    int updateComment(Comment comment);

    int delete(String[] id);

    List<Comment> getComment();

    int addComment(Comment comment);

    List<Comment> getCommentByIdList(String id);

    Integer selectByRoomId(List<Room> roomList);

    int deleteByRoomId(List<Room> roomList);
}
