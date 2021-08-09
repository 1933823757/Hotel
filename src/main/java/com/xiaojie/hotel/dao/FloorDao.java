package com.xiaojie.hotel.dao;

import com.xiaojie.hotel.domian.Floor;

import java.util.List;

public interface FloorDao {
    int insertFloor(Floor floor);

    List<Floor> selectFloorAll(Floor floor);

    Floor selectFloorById(String id);

    int updateFloorAll(Floor floor);

    int deleteFloor(String[] id);

    Floor getFloor(Floor floor);

    List<Floor> getFloorId();
}
