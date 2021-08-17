package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.CommentDao;
import com.xiaojie.hotel.dao.OrderInformAtionDao;
import com.xiaojie.hotel.dao.RoomDao;
import com.xiaojie.hotel.dao.UserDao;
import com.xiaojie.hotel.domian.*;
import com.xiaojie.hotel.service.FrontEndService;
import com.xiaojie.hotel.service.PutUpService;
import com.xiaojie.hotel.util.DateTimeUtil;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FrontEndServiceImpl implements FrontEndService {
    private RoomDao roomDao;
    private CommentDao commentDao;
    @Autowired
    private PutUpService putUpService;
    private UserDao userDao;
    private OrderInformAtionDao orderInformAtionDao;

    public void setOrderInformAtionDao(OrderInformAtionDao orderInformAtionDao) {
        this.orderInformAtionDao = orderInformAtionDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public void setCommentDao(CommentDao commentDao) {
        this.commentDao = commentDao;
    }

    public void setRoomDao(RoomDao roomDao) {
        this.roomDao = roomDao;
    }

    @Transactional
    @Override
    public Map<String, Object> getRooms() {
        Map<String,Object> map =new HashMap<>();
        Integer num = 6;
        //取六条房间信息
        List<Room> oldList = roomDao.getRooms(num);
        List<Room> newList = new ArrayList<>();
        for (Room room:oldList){
            String imgpath = room.getRoomImgPath();
            String[] imgpaths = imgpath.split(";");
            //每个房间都有图片，所以这里直接取图片第一张
            String path = imgpaths[0];
            room.setRoomImgPath(path);
            newList.add(room);
        }
        //获取评论
        List<Comment> comments = commentDao.getComment();
        map.put("list",newList);
        map.put("commentlist",comments);
        return map;
    }

    @Override
    public Map<String, Object> getRoomFenYe(Integer valueOf, Integer valueOf1) {

        //分页
        List<Room> newList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        //获取空闲房间集合
        List<Room> RoomList = putUpService.getRoomIdAll();
        //因为分页原因，只能再一次的去表里面查询空闲的房间
        PageHelper.startPage(valueOf, valueOf1);
       List<Room> oldList = roomDao.getRoomFenYe(RoomList);
        PageInfo pageInfo = new PageInfo(oldList);
        List<Room> list = pageInfo.getList();
        for(Room room:list){
            String imgpath = room.getRoomImgPath();
            String[] imgpaths = imgpath.split(";");
            String path = imgpaths[0];
            room.setRoomImgPath(path);
            newList.add(room);
        }
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list",newList);
        return map;
    }


    @Override
    public Map<String, Object> getRoomOrder(String id) {
        Map<String, Object> map =new HashMap<>();
        Room room = roomDao.getRoomById(id);
        String [] imgpaths = room.getRoomImgPath().split(";");
        map.put("room",room);
        map.put("imgpaths",imgpaths);
        return map;
    }

    //添加评论
    @Override
    public Map<String, Object> addComment(Comment comment) {
        boolean flag = false;
        Map<String,Object> map = new HashMap<>();
        comment.setId(UUIDUtil.getUUID());
        comment.setStart_time(DateTimeUtil.getSysTime());
        int num = commentDao.addComment(comment);
        if (num == 1){
            flag = true;
        }
        map.put("success",flag);
        return map;
    }


    //通过id获取房间评论
    @Override
    public Map<String, Object> getCommentById(String id) {
        Map<String,Object> map = new HashMap<>();
       List<Comment> list = commentDao.getCommentByIdList(id);
       map.put("commentlist",list);
        return map;
    }

    //通过楼层号获取总统套房
    @Override
    public Map<String, Object> getDeluxe(Integer pageNo,Integer pageSize) {
        String name = "总统套房";
        List<Room> newList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        //获取所有空闲中的房间
        List<Room> RoomList = putUpService.getRoomIdAll();
        PageHelper.startPage(pageNo,pageSize);
        List<Room> oldList = roomDao.getDeluse(RoomList,name);
        PageInfo pageInfo = new PageInfo(oldList);
        List<Room> list = pageInfo.getList();
        for(Room room:list){
            String imgpath = room.getRoomImgPath();
            String[] imgpaths = imgpath.split(";");
            String path = imgpaths[0];
            room.setRoomImgPath(path);
            newList.add(room);
        }
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list",newList);
        return map;
    }

    //更改用户信息
    @Transactional
    @Override
    public Map<String,Object> updateUser(User user) {
        Map<String,Object> map = new HashMap<>();
        boolean flag = false;
        //先根据id获取以前的图片路径
        User oldUser = userDao.getUserById(user.getId());
        User newUser = new User();
        int num = userDao.updateUserNotPwd(user);
        if (num == 1){
            //说明修改成功，则需要删除旧照片
            DeleteFile.deleteFile(oldUser.getImgpath());
            //查询最新的信息
            newUser = userDao.getUserById(user.getId());
            flag = true;
        }
        map.put("success",flag);
        map.put("user",newUser);
        return map;
    }

    //没有上传图片时更新信息
    @Override
    public Map<String,Object> updateUserNotPath(User user) {
        boolean flag = false;
        Map<String,Object> map = new HashMap<>();
        User newUser = new User();
        int num = userDao.updateUserNOtImgAndPwd(user);
        if (num == 1){
            //查询最新的信息
            newUser = userDao.getUserById(user.getId());
           flag=true;
        }
        map.put("success",flag);
        map.put("user",newUser);
        return map;
    }

    //根据用户的id获取其订单信息
    @Override
    public List<OrderInformAtion> getOrderUser(String id) {
        //状态
        String state = "1";
        List<OrderInformAtion> list = orderInformAtionDao.selectByUserId(id,state);
        return list;
    }

    //用户删除订单的业务
    @Override
    public Map<String, Object> deleteOrder(String id) {
        //根据订单的id拿到user的id
        OrderInformAtion or = orderInformAtionDao.select(id);
        //此方法删除订单，当客户处于入住中时，入住表中不会删除其记入，当客户处于预定时，信息全部删除掉
        String engageId[] ={or.getUserId()};
        Map<String,Object> map = putUpService.deleteEngage(engageId);
        return map;
    }

    //更新用户身份证
    @Override
    public boolean updateUserIdCard(String idCard,String id) {
        int num = userDao.updateUserIdcard(idCard,id);
        if (num == 1){
            return true;
        }
        return false;
    }


}
