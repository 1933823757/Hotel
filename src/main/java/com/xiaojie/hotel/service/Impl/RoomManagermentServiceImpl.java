package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.FloorDao;
import com.xiaojie.hotel.dao.RoomDao;
import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.RoomManagermentService;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoomManagermentServiceImpl implements RoomManagermentService {
    private FloorDao floorDao;
    private RoomDao roomDao;

    public void setFloorDao(FloorDao floorDao) {
        this.floorDao = floorDao;
    }

    public void setRoomDao(RoomDao roomDao) {
        this.roomDao = roomDao;
    }

        //添加楼层的service层
    @Transactional
    @Override
    public boolean addFloor(Floor floor) {
        boolean flan =false;
        //判断是否存在数据
        Floor num1 = floorDao.getFloor(floor);
        if (num1 != null){
            flan =false;
        }else {
            int num = floorDao.insertFloor(floor);
            if (num == 1) {
                flan = true;
            }
        }
        return flan;
    }

   @Transactional
    @Override
    public Map<String,Object> getFloorAll(Floor floor, Integer pageNo1, Integer pageSize1) {
        //分页
        Map<String,Object> map = new HashMap<>();
        PageHelper.startPage(pageNo1,pageSize1);
        List<Floor> list = floorDao.selectFloorAll(floor);


        PageInfo pageInfo = new PageInfo(list);
        List<Floor> floorList = pageInfo.getList();
        for (Floor f:floorList){
            Integer countRoom = roomDao.getCountRoom( f.getId());
           f.setRoomCount(String.valueOf(countRoom));
        }

        map.put("total",pageInfo.getTotal());
        map.put("pages",pageInfo.getPages());
        map.put("floorList",floorList);
        return map;
    }


    @Override
    public Floor getFloorById(String id) {
        Floor floor = floorDao.selectFloorById(id);
        return floor;
    }

    @Override
    public boolean updateFloor(Floor floor) {
        int num = floorDao.updateFloorAll(floor);
        if (num == 1){
            return true;
        }
        return false;
    }

    @Override
    @Transactional
    public Boolean deleteFloorAndRoom(String[] id) {
        boolean flan=true;
        //查询需要删除的房间数
        int roomCount = roomDao.getDeleteCount(id);
        //实际删除的个数
        int deleteRoom = roomDao.deleteRoom(id);
        if (roomCount == deleteRoom){
            flan =true;
        }

        //实际删除的个数
        int deleteCoutn =floorDao.deleteFloor(id);
        //判断是否删除成功
        if(id.length==deleteCoutn){
           flan=true;
        }

        return flan;
    }

    //创建房间获取楼层的方法
    @Override
    public List<Floor> getFloorId() {
        List<Floor> list = floorDao.getFloorId();
        return list;
    }

    //添加房间的方法
    @Transactional
    @Override
    public boolean addRoom(Room room) {
        //实体类里面还缺少房间类型，则需向楼层表里面取房间类型
        Floor floor = floorDao.selectFloorById(room.getFloorId());
        room.setRoomType(floor.getRoomType());
        //判断表里面有没有房间号，如果有则添加失败，如果没有则添加数据
        Room isRoom = roomDao.getRoomByRoomId(room.getRoomId());
        if (isRoom ==null){
            //所有数据拿到后添加房间
            int num = roomDao.addRoom(room);
            if (num == 1){
                return  true;
            }else {
                return false;
            }
        }else {
            return false;
        }

    }
}
