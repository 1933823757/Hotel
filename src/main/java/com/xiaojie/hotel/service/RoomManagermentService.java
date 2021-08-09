package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.Room;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface RoomManagermentService {
    boolean addFloor(Floor floor);

    Map<String,Object> getFloorAll(Floor floor, Integer pageNo1, Integer pageSize1);

    Floor getFloorById(String id);

    boolean updateFloor(Floor floor);

    Boolean deleteFloorAndRoom(String[] id);

    List<Floor> getFloorId();

    Map<String, Object> addRoom(Room room);

    Map<String, Object> RoomPageList(Room room, Integer pageNo1, Integer pageSize1);


    void getFloorType(HttpServletRequest request);

    Room getRoomById(String id);

    Map<String,Object> updateRoom(Room room);

    Boolean deleteRoom(String[] id);
}
