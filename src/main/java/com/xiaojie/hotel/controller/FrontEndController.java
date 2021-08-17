package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.domian.Comment;
import com.xiaojie.hotel.domian.Engage;
import com.xiaojie.hotel.domian.OrderInformAtion;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.FrontEndService;
import com.xiaojie.hotel.service.PutUpService;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.util.UUIDUtil;
import com.xiaojie.hotel.service.MailSenderSrvServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/frontend")
public class FrontEndController {

    @Autowired
    private FrontEndService frontservice;
    @Autowired
    private PutUpService putUpService;

    @RequestMapping("/getRooms.do")
    @ResponseBody
    public Map<String,Object> getRooms(){
        Map<String,Object> map = frontservice.getRooms();
        return map;
    }

    //跳转到房间订购首页
    @RequestMapping("/toroom.do")
    public String toRoom(){
        return "room/room";
    }

    //跳转到总统套房订购页

    @RequestMapping("/todeluxe_room.do")
    public String todeluxeRoom(){
        return "room/deluxe-room";
    }

    //房间分页
    @RequestMapping("/getRoomFenYe.do")
    @ResponseBody
    public Map getRoomFenYe(String pageNo,String pageSize){
        Map<String,Object> map = frontservice.getRoomFenYe( Integer.valueOf(pageNo),Integer.valueOf(pageSize));
        return  map;
    }

    //房间订单页
    @RequestMapping("/toroomOrder.do")
    public ModelAndView toRoomOrder(String id){
        ModelAndView mv = new ModelAndView();
        Map<String,Object> map = frontservice.getRoomOrder(id);
        mv.setViewName("room/room-order");
        mv.addObject("room",map.get("room"));
        mv.addObject("imgpaths",map.get("imgpaths"));
        return mv;
    }

    //添加评论
    @RequestMapping("/addComment.do")
    @ResponseBody
    public Map addComment(Comment comment){
        Map<String,Object> map = frontservice.addComment(comment);
        return map;
    }

    //通过id获取房间的评论
    @RequestMapping("/getCommentById.do")
    @ResponseBody
    public Map getCommentById(String roomId){
        Map<String,Object> map = frontservice.getCommentById(roomId);
        return map;
    }

    //添加预定信息
    @RequestMapping("/addEngage.do")
    @ResponseBody
    public Map addEngage(Engage engage,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        String id = user.getId();
        engage.setId(id);
        Map<String,Object> map = putUpService.addEngage(engage);
        if ((boolean)map.get("success")){
            boolean flag = frontservice.updateUserIdCard(engage.getIdCard(),id);
            map.put("success",flag);
        }
        return map;
    }

    //获取总统套房分页
    @RequestMapping("/getDeluxe.do")
    @ResponseBody
    public Map getDeluxe(String pageNo,String pageSize){
        Map<String,Object> map = frontservice.getDeluxe(Integer.valueOf(pageNo),Integer.valueOf(pageSize));
        return map;
    }

    //跳转到用户信息页
    @RequestMapping("/touserlist.do")
    public String touserList(){
        return "usersetting/userlist";
    }
    //跳转用户详细页
    @RequestMapping("/touser.do")
    public String touser(){
        return "usersetting/user";
    }
    //跳转订单页
    @RequestMapping("/touserorder.do")
    public  String touserOrder(){
        return "usersetting/userorder";
    }
    //跳转到联系界面
    @RequestMapping("/tocontact.do")
    public String tocontact(){
        return "contactus/contact";
    }

    //储存路径
    String saveFilePath = "D://Java-Webxiangmu//hotel//src//main//webapp//images//headimgs";
    //用户修改个人信息请求
    @RequestMapping("/updateUser.do")
    public ModelAndView updateUser(User user, MultipartFile file, HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("usersetting/user");
        if (file.isEmpty()){
            //到这里则说明用户没有上传图片，则不需要更新图片
            Map<String,Object> map = frontservice.updateUserNotPath(user);
            if ((boolean)map.get("success")){
                mv.addObject("title","信息更改成功");
                request.getSession().setAttribute("user",(User)map.get("user"));
                return mv;
            }else{
                mv.addObject("title","信息更改失败");
                return  mv;
            }
        }else{
            //获取上传文件的原名
            String oldFileName = file.getOriginalFilename();
            //新的图片名字
            String newFileName = UUIDUtil.getUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
            //新图片
            File newFile = new File(saveFilePath + "\\" + newFileName);
            String path = "images/headimgs/" + newFileName;
            try {
                file.transferTo(newFile);
            } catch (IOException e) {
                e.printStackTrace();
                mv.addObject("title","头像上传失败");
                return mv;
            }
            user.setImgpath(path);
            Map<String,Object> map = frontservice.updateUser(user);
            if ((boolean)map.get("success")){
                mv.addObject("title","信息更改成功");
                request.getSession().setAttribute("user",(User)map.get("user"));
                return mv;
            }else{
                mv.addObject("title","信息更改失败");
                //修改失败删除新照片
                DeleteFile.deleteFile(path);
                return mv;
            }
        }
    }

    //获取user订单信息
    @RequestMapping("/getOrderUser.do")
    @ResponseBody
    public List getOrderUser(String id){
        List<OrderInformAtion> orderInformAtionList = frontservice.getOrderUser(id);
        return orderInformAtionList;
    }

    //删除订单信息
    @RequestMapping("/deleteOrder.do")
    @ResponseBody
    public Map deleteOrder(String id){
        Map<String,Object> map = frontservice.deleteOrder(id);
        return map;
    }

    //跳转到阅读更多界面
    @RequestMapping("/toreadmore.do")
    public String toreadMore(){
        return "readmore/readmore";
    }

    //跳转到服务界面
    @RequestMapping("/toservices.do")
    public String toServices(){
        return "service/services";
    }

    @Autowired
    private MailSenderSrvServices mailSenderSrvServices;
    //邮箱发送
    @RequestMapping("/toemail.do")
    @ResponseBody
    public Map toEmail(String name,String email,String phone,String type,String textarea){
        Map<String,Object> map = new HashMap<>();
        String to = "1933823757@qq.com";
        String subject = "姓名"+name+","+"邮箱"+email+","+"手机号码"+phone+"，"+"房间类型"+type;
        String content = textarea;
        mailSenderSrvServices.sendEmail(to,subject,content);
        map.put("success",true);
        return map;
    }
}
