package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.domian.Comment;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.UserService;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.util.MD5Util;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
        用户管理控制器
 */
@Controller
@RequestMapping("/userlist")
public class UserController {
    @Autowired
    private UserService userService;

    //跳转视图
    @RequestMapping("/touserList.do")
    public String toUserList(){
        return "rootpage/userlist/userlist";
    }

    //头像图片上传控制器
    List<String> imgPaths = new ArrayList<>();
    @RequestMapping("/addImg.do")
    @ResponseBody
    public Map<String,Object> addImg(@RequestParam("file") MultipartFile file){
        Map<String, Object> uploadData = new HashMap<String, Object>();
        //获取上传文件的原名
        String oldFileName = file.getOriginalFilename();
        //储存路径
        String saveFilePath = "D://Java-Webxiangmu//hotel//src//main//webapp//images//headimgs";
        //新的图片名字
        String newFileName = UUIDUtil.getUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
        //新图片
        File newFile = new File(saveFilePath + "\\" + newFileName);
        try {
            file.transferTo(newFile);
            uploadData.put("msg", "上传成功");
        } catch (IOException e) {
            uploadData.put("code", -1);
            uploadData.put("msg", "上传失败");
            uploadData.put("error", "上传失败，请检查网络连接或联系管理员");
        }
        //将路径存入全局变量
        String path = "images/headimgs/" + newFileName;
        imgPaths.add(path);
        System.out.println("string图片存放------------------------" + imgPaths.toString());
        return uploadData;
    }

    //添加用户请求
    @RequestMapping("/addUser.do")
    @ResponseBody
    public Map<String,Object> addUser(User user){
        String imgpath=null;
        Map<String,Object> map =new HashMap<>();
        if (imgPaths.size()>0){
            for(String i:imgPaths){
                imgpath=i;
                user.setImgpath(i);
            }
            user.setPassword(MD5Util.getMD5(user.getPassword()));
            user.setId(UUIDUtil.getUUID());
            map = userService.addUser(user);
            if ((boolean)map.get("success")){
                imgPaths.clear();
            }else{
                DeleteFile.deleteFile(imgpath);
                imgPaths.clear();
            }
            return map;
        }else{
            map.put("success",false);
            map.put("title","头像未上传，请先上传头像");
            return map;
        }
    }

    //分页请求
    @RequestMapping("/getUserList.do")
    @ResponseBody
    public Map<String,Object> getUserList(User user,String pageNo,String pageSize){
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        Map<String,Object> map = userService.getUserList(user,pageNo1,pageSize1);
        return map;
    }

    //修改用户请求
    @RequestMapping("/getUserById.do")
    @ResponseBody
    public User getUserById(String id){
        User user = userService.getUserById(id);
        return user;
    }

    //修改用户信息的请求
    @RequestMapping("/updateUser.do")
    @ResponseBody
    public Map<String,Object> updateUser(User user){
        Map<String,Object> map = new HashMap<>();
        if (imgPaths.size()>0){
            //上传了文件，则需要更新图片
            for (String i:imgPaths){
                user.setImgpath(i);
            }
        }
        map=userService.updateUser(user);
        imgPaths.clear();
        return map;
    }

    //删除用户信息
    @RequestMapping("/deleteUser.do")
    @ResponseBody
    public Map<String,Object> deleteUser(HttpServletRequest request){
        String[] id =request.getParameterValues("id");
        Map<String,Object> map = userService.deleteUser(id);
        return map;
    }

    //跳转到评论界面
    @RequestMapping("/tocomment.do")
    public String tocomment(){
        return "rootpage/comment/comment";
    }

    //获取评论请求
    @RequestMapping("/getComment.do")
    @ResponseBody
    public Map getComment(Comment comment,String pageNo,String pageSize){
        Integer pageNo1 = Integer.valueOf(pageNo);
        Integer pageSize1 = Integer.valueOf(pageSize);
        Map<String,Object> map = userService.getCommentList(comment,pageNo1,pageSize1);
        return map;
    }

    @RequestMapping("/getCommentById.do")
    @ResponseBody
    public Comment getCommentById(String id){
        Comment comment = userService.getCommentById(id);
        return comment;
    }

    @RequestMapping("/updateComment.do")
    @ResponseBody
    public Map updateComment(Comment comment){
        Map<String,Object> map = userService.updateComment(comment);
        return map;
    }

    @RequestMapping("/deleteComment.do")
    @ResponseBody
    public Map deleteComment(HttpServletRequest request){
        String [] id = request.getParameterValues("id");
        Map<String,Object> map = userService.delete(id);
        return  map;
    }
}
