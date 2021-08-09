package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.Room;

import java.util.List;

public interface RoomDao {


    Integer getDeleteCount(String[] id);

    int deleteRoom(String[] id);

    Integer getCountRoom(String id);

    int addRoom(Room room);

    Room getRoomByRoomId(String roomId);
}
