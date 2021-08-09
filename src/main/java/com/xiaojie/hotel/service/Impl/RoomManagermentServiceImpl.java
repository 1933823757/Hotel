package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.FloorDao;
import com.xiaojie.hotel.dao.RoomDao;
import com.xiaojie.hotel.domian.Floor;
import com.xiaojie.hotel.domian.Room;
import com.xiaojie.hotel.service.RoomManagermentService;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.vo.RoomImgPath;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

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
        boolean flan = false;
        //判断是否存在数据
        Floor num1 = floorDao.getFloor(floor);
        if (num1 != null) {
            flan = false;
        } else {
            int num = floorDao.insertFloor(floor);
            if (num == 1) {
                flan = true;
            }
        }
        return flan;
    }

    @Transactional
    @Override
    public Map<String, Object> getFloorAll(Floor floor, Integer pageNo1, Integer pageSize1) {
        //分页
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(pageNo1, pageSize1);
        List<Floor> list = floorDao.selectFloorAll(floor);
        PageInfo pageInfo = new PageInfo(list);
        List<Floor> floorList = pageInfo.getList();
        for (Floor f : floorList) {
            Integer countRoom = roomDao.getCountRoom(f.getId());
            f.setRoomCount(String.valueOf(countRoom));
        }

        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("floorList", floorList);
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
        if (num == 1) {
            return true;
        }
        return false;
    }

    @Override
    @Transactional
    public Boolean deleteFloorAndRoom(String[] id) {
        boolean flan = true;
        //查询需要删除的房间数
        int roomCount = roomDao.getDeleteCount(id);
        //实际删除的个数
        int deleteRoom = roomDao.deleteRoom(id);
        if (roomCount == deleteRoom) {
            flan = true;
        }

        //实际删除的个数
        int deleteCoutn = floorDao.deleteFloor(id);
        //判断是否删除成功
        if (id.length == deleteCoutn) {
            flan = true;
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
    public  Map<String, Object> addRoom(Room room) {
        Map<String,Object> map = new HashMap<>();
        //实体类里面还缺少房间类型，则需向楼层表里面取房间类型
        Floor floor = floorDao.selectFloorById(room.getFloorId());
        room.setRoomType(floor.getRoomType());
        //判断表里面有没有房间号，如果有则添加失败，如果没有则添加数据
        String roomId = room.getRoomId();
        String floorId = room.getFloorId();
        int count  = roomDao.getRoomByRoomId(roomId,floorId);
        if (count >0) {
            map.put("success",false);
            map.put("title",""+floor.getFloorId()+"楼，"+roomId+"房间已存在，请换个房间号");
        }else{
            //所有数据拿到后添加房间
            int num = roomDao.addRoom(room);
            if (num == 1){
                map.put("success",true);
                map.put("title",""+floor.getFloorId()+"楼，"+roomId+"房间添加成功");
            }
        }
            return map;
    }


    //房间的分页查询
    @Override
    public Map<String, Object> RoomPageList(Room room, Integer pageNo1, Integer pageSize1) {
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(pageNo1, pageSize1);
        List<Floor> list = roomDao.selectRoomAll(room);
        PageInfo pageInfo = new PageInfo(list);
        //拿到所有对象的list集合
        List<Room> roomList = pageInfo.getList();
        //最终需要返回的volist
        List<RoomImgPath> volist = new ArrayList<>();
        //遍历集合，取出图片
        Iterator it = roomList.iterator();
        while (it.hasNext()) {
            Room room1 = (Room) it.next();
            String path = room1.getRoomImgPath();
            //创建集合储存图片路径
            List<String> imgList = new ArrayList<>();
            //获取图片路径，并且分割
            String[] imgArray = path.split(";");
            //循环数组，把分割好的图片存到vo里面
            for (int i = 0; i < imgArray.length; i++) {
                if (!imgArray[i].equals("null")) {
                    imgList.add(imgArray[i]);
                }

            }
            RoomImgPath roomImgPath = new RoomImgPath(room1, imgList);
            volist.add(roomImgPath);
        }

        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("roomList", volist);
        return map;
    }

    //获取房间类型
    @Override
    public void getFloorType(HttpServletRequest request) {
        List<Floor> list = floorDao.getFloorId();
        request.getSession().setAttribute("floor", list);

    }

    //房间修改按钮事件
    @Override
    public Room getRoomById(String id) {
        Room room = roomDao.getRoomById(id);
        return room;
    }

    //更新房间事件
    @Transactional
    @Override
    public Map<String, Object> updateRoom(Room room) {
        Map<String, Object> map = new HashMap<>();
        //拿到楼层的id
        String floorId = room.getFloorId();
        Floor floor = floorDao.selectFloorById(floorId);
        //拿到房间的房间号
        String roomId = room.getRoomId();
        //判断当前的房间号跟之前的房间号是否一样，是的话则允许更改，如果不一样的话则需判断
        String id = room.getId();
        Room room1 = roomDao.getRoomById(id);
        //拿到以前的图片路径
        String path = room1.getRoomImgPath();
        if (room1.getRoomId().equals(room.getRoomId())) {
            //判断传过来的图片是否为空，为空的话就不要删除以前的照片，如果不为空则需要删除以前的照片
            room.setRoomType(floor.getRoomType());
            int num = roomDao.updateRoom(room);
            if (num == 1) {
                if (room.getRoomImgPath() != null) {
                    //删除文件
                    DeleteFile.deleteFile(path);
                }
                map.put("title", "" + floor.getFloorId() + "楼，" + roomId + "房间修改成功");
                map.put("success", true);
            } else {
                if(room.getRoomImgPath() !=null){
                    //修改失败也得删除文件
                  DeleteFile.deleteFile(room.getRoomImgPath());
                }
                map.put("title", "" + floor.getFloorId() + "楼，" + roomId + "房间修改失败");
                map.put("success", false);
            }

        } else {
            //判断房间号是否存在，如果存在，则返回false并提示给前台
            int count = roomDao.isRoomId(floorId, roomId);
            if (count > 0) {
                if(room.getRoomImgPath() !=null){
                    //修改失败也得删除文件
                    DeleteFile.deleteFile(room.getRoomImgPath());
                }
                //说明存在相同房间名，则直接返回
                map.put("success", false);
                map.put("title", "" + floor.getFloorId() + "楼，" + roomId + "房间已存在");
            } else {
                room.setRoomType(floor.getRoomType());
                int num = roomDao.updateRoom(room);
                if (num == 1) {
                    if (room.getRoomImgPath() != null) {
                        //删除文件
                        DeleteFile.deleteFile(path);
                    }
                    map.put("title", "" + floor.getFloorId() + "楼，" + roomId + "房间添加成功");
                    map.put("success", true);
                } else {
                    if(room.getRoomImgPath() !=null){
                        //修改失败也得删除文件
                        DeleteFile.deleteFile(room.getRoomImgPath());
                    }
                    map.put("title", "" + floor.getFloorId() + "楼，" + roomId + "房间添加失败");
                    map.put("success", false);
                }
            }
        }
        return map;
    }

    @Override
    public Boolean deleteRoom(String[] id) {
        StringBuilder sb = new StringBuilder();
        for(int i=0;i<id.length;i++){
            //通过id拿到房间所有信息
            Room room = roomDao.getRoomById(id[i]);
            //拿到图片的地址
            String path = room.getRoomImgPath();
            sb.append(path);
            if (i<id.length-1){
                sb.append(";");
            }
        }
        System.out.println("==============================所有的图片路径:"+sb);
        int num = roomDao.deleteRoomById(id);
        if (num == id.length){
            //说明删除成功
            //删除图片
            DeleteFile.deleteFile(sb.toString());
            return true;
        }
        return false;
    }


}
