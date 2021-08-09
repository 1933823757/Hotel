package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.Room;

import java.util.List;
import java.util.Map;

public interface RoomManagermentService {
    boolean addFloor(Floor floor);

    Map<String,Object> getFloorAll(Floor floor, Integer pageNo1, Integer pageSize1);

    Floor getFloorById(String id);

    boolean updateFloor(Floor floor);

    Boolean deleteFloorAndRoom(String[] id);

    List<Floor> getFloorId();

    boolean addRoom(Room room);
}
