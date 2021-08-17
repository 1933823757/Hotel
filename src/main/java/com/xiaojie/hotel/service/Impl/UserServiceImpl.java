package com.xiaojie.hotel.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.*;
import com.xiaojie.hotel.domian.*;
import com.xiaojie.hotel.service.UserService;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.util.MD5Util;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    private UserDao userDao;
    private CommentDao commentDao;
    private EngageDao engageDao;
    private MoveRoomDao moveRoomDao;
    private OrderInformAtionDao orderInformAtionDao;
    private CustomerDao customerDao;

    public void setEngageDao(EngageDao engageDao) {
        this.engageDao = engageDao;
    }

    public void setMoveRoomDao(MoveRoomDao moveRoomDao) {
        this.moveRoomDao = moveRoomDao;
    }

    public void setOrderInformAtionDao(OrderInformAtionDao orderInformAtionDao) {
        this.orderInformAtionDao = orderInformAtionDao;
    }

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

    public void setCommentDao(CommentDao commentDao) {
        this.commentDao = commentDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

//    登录验证方法
    @Override
    public User getUser(User user) {
        User ur = userDao.selectUser(user);
        return ur;
    }
//  注册方法
    @Override
    public boolean register(User user) {
        int num = userDao.addUser(user);
        if (num != 1){
            return  false;
        }
        return true;
    }

    @Override
    public  List<User>  findAll() {
        List<User> user = userDao.selectAll();
        return user;
    }

    //添加用户
    @Override
    public Map<String, Object> addUser(User user) {
        Map<String, Object> map = new HashMap<>();
        int count = userDao.selectUserByUserName(user.getUsername());
        if (count>0){
            map.put("success",false);
            map.put("title",user.getUsername()+"用户添加失败，用户名已存在");
            return map;
        }else{
            int num = userDao.addUserAll(user);
            if (num == 1){
                map.put("success",true);
                map.put("title","用户添加成功");
            }
            return map;
        }
    }

    //分页查询
    @Override
    public Map<String, Object> getUserList(User user,Integer pageNo,Integer pageSize) {
        //分页
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(pageNo, pageSize);
        List<User> list = userDao.getuserList(user);
        PageInfo pageInfo = new PageInfo(list);
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list", pageInfo.getList());
        return map;
    }

    //修改业务
    @Override
    public User getUserById(String id) {
        User user = userDao.getUserById(id);
        return user;
    }


    //修改用户信息
    @Override
    public Map<String, Object> updateUser(User user) {
        boolean flag =false;
        int count=0;
        Map<String, Object> map = new HashMap<>();
        //先通过id拿到以前图片的路径
        User newUser = userDao.getUserById(user.getId());
        String newUsername = user.getUsername();
        if (!newUsername.equals(newUser.getUsername())){
            //判断是否新修改的用户名跟以前的是否重复
            count = userDao.selectUserByUserName(user.getUsername());
        }
        if(count >0){
            map.put("success",flag);
            map.put("title",user.getUsername()+"用户名已存在");
            //用户修改失败得要删除新照片
            DeleteFile.deleteFile(user.getImgpath());
            return map;
        }else{
            //判断图片是否为空
            if (user.getImgpath() == null){
                //是空的话直接更改信息
                user.setPassword(MD5Util.getMD5(user.getPassword()));
                int num = userDao.updateUser(user);
                if (num == 1){
                    flag =true;
                }
            }else{
                //说明上传了图片,则需更新图片
                user.setPassword(MD5Util.getMD5(user.getPassword()));
                int num2 = userDao.updateUserAndImg(user);
                if (num2 == 1){
                    flag =true;
                    //修改成功后得要删除旧照片
                    DeleteFile.deleteFile(newUser.getImgpath());
                }else{
                    //用户修改失败得要删除新照片
                    DeleteFile.deleteFile(user.getImgpath());
                }
            }
            if (flag){
                map.put("success",flag);
                map.put("title",user.getUsername()+"用户修改成功，密码请妥善保管");
                //修改成功后，得要吧预定信息，入住信息，订单信息，客户信息都得修改
                Engage engage = engageDao.getEngageByCname(newUser.getUsername());
                if (engage != null){
                    int num3 = engageDao.updateEngageByCname(user,user.getUsername());
                }
                MoveRoom moveRoom = moveRoomDao.selectMove(newUser.getUsername());
                if (moveRoom != null){
                    int num4 = moveRoomDao.updateMoveByUser(user,user.getUsername());
                }
                List<OrderInformAtion> list = orderInformAtionDao.selectByUserIdAll(newUser.getId());
                if (list.size() >0){
                    int num5 = orderInformAtionDao.updateOrderByUser(list,user);
                }
                Customer customer = customerDao.selectByUser(newUser.getUsername());
                if (customer !=null){
                    int num6 = customerDao.updateCustomerByUser(user,user.getUsername());
                }
            }else{
                map.put("success",flag);
                map.put("title",user.getUsername()+"用户修改失败");
            }
        }
        return map;
    }

    //删除用户信息
    @Override
    public Map<String, Object> deleteUser(String[] id) {
        ArrayList<String> imgpath = new ArrayList<>();
        for(String i:id){
            User user = userDao.getUserById(i);
            imgpath.add(user.getImgpath());

        }
        Map<String, Object> map =new HashMap<>();
        int count = userDao.deleteUser(id);
        if (count == id.length){
            map.put("success",true);
            map.put("title","删除成功");
            for(String path:imgpath){
                DeleteFile.deleteFile(path);
            }
        }else{
            map.put("success",false);
            map.put("title","删除失败");
        }
        return map;
    }

    @Override
    public Map<String, Object> getCommentList(Comment comment, Integer pageNo1, Integer pageSize1) {
        //分页
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(pageNo1, pageSize1);
        List<Comment> list = commentDao.getCommentList(comment);
        PageInfo pageInfo = new PageInfo(list);
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list", pageInfo.getList());
        return map;
    }

    @Override
    public Comment getCommentById(String id) {
        Comment comment = commentDao.getCommentById(id);
        return comment;
    }

    @Override
    public Map<String, Object> updateComment(Comment comment) {
        Map<String,Object> map = new HashMap<>();
        boolean flag = false;
        int num = commentDao.updateComment(comment);
        if (num == 1){
           flag=true;
            map.put("title","修改成功");
    }
        else{
            map.put("title","修改失败");
        }
        map.put("success",flag);

        return map;
    }

    @Override
    public Map<String, Object> delete(String[] id) {
        Map<String,Object> map = new HashMap<>();
        boolean flag = false;
        int count = commentDao.delete(id);
        if (count == id.length){
            flag = true;
            map.put("title","删除成功");
        }else{
            map.put("title","删除失败");
        }
        map.put("success",flag);

        return map;
    }



}
