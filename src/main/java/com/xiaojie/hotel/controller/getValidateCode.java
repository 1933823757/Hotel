package com.xiaojie.hotel.controller;

import com.sun.org.apache.xpath.internal.operations.Mod;
import com.xiaojie.hotel.Exception.ErrorException;
import com.xiaojie.hotel.Exception.LoginCodeException;
import com.xiaojie.hotel.Exception.LoginUserException;
import com.xiaojie.hotel.domian.Manager;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.ManagerService;
import com.xiaojie.hotel.service.UserService;
import com.xiaojie.hotel.util.CreateValidateCode;
import com.xiaojie.hotel.util.MD5Util;
import com.xiaojie.hotel.util.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

@Controller
public class getValidateCode {
    //验证码获取方法
    @RequestMapping("/getCode.do")
    public void getValidateCode(HttpServletResponse response, HttpServletRequest request) throws IOException {
        //创建输出流
        OutputStream outputStream = response.getOutputStream();
        //获取session
        HttpSession session = request.getSession();
        //获取验证码
        CreateValidateCode createValidateCode = new CreateValidateCode();
        String generateVerifyCode = createValidateCode.getString();
        //将验证码存入session，做登录验证
        session.setAttribute("code",generateVerifyCode);
        System.out.println(generateVerifyCode);
        //获取验证码图片
        BufferedImage image = createValidateCode.getImage();
        ImageIO.write(image, "png", outputStream);
        //关流
        outputStream.flush();
        outputStream.close();
    }
    @Autowired
    private UserService userService;

    @ResponseBody
    //普通用户登录请求
    @RequestMapping("/Verifylogin.do")
    public Map islogin(String username, String password, String captcha, HttpServletRequest request) throws LoginCodeException, LoginUserException, ErrorException {
        System.out.println("--------------------------------普通用户请求");
        Map<String,Object> map = new HashMap<>();
        if (username == null && password ==null && captcha == null){
          throw new ErrorException("非法请求");
        }
       String code = (String) request.getSession().getAttribute("code");
       if(!code.equals(captcha.toLowerCase())){
           throw new LoginCodeException("验证码错误");
       }
        User user = new User();
        user.setUsername(username);
        user.setPassword(MD5Util.getMD5(password));
        User user2 = userService.getUser(user);
        if (user2 == null){
            throw  new LoginUserException("账号密码错误");
        }
        request.getSession().setAttribute("user",user2);

        map.put("success",true);
        map.put("url","index.do");
        return map;
    }

    @Autowired
    private ManagerService managerService;

    @ResponseBody
    //管理员登录请求
    @RequestMapping("/managerlogin.do")
    public Map Managerlogin(String managername, String managerpassword, String captcha2, HttpServletRequest request) throws LoginCodeException, LoginUserException, ErrorException {
        System.out.println("--------------------------------管理员请求");
        Map<String,Object> map = new HashMap<>();
        if (managername == null && managerpassword ==null && captcha2 == null){
            throw new ErrorException("非法请求");
        }
        String code = (String) request.getSession().getAttribute("code");
        if(!code.equals(captcha2.toLowerCase())){
            throw new LoginCodeException("验证码错误");
        }
        Manager manager = new Manager();
        manager.setManagerName(managername);
        manager.setManagerPassword(MD5Util.getMD5(managerpassword));
        Manager manager1 = managerService.getManager(manager);
        if (manager1 == null){
            throw  new LoginUserException("账号密码错误");
        }
        request.getSession().setAttribute("manager",manager1);

        map.put("success",true);
        map.put("url","rootpage.do");
        return map;
    }
    //管理员修改密码请求
    @RequestMapping("/updateManager.do")
    @ResponseBody
    public Map updateManager(HttpServletRequest request,String oldPwd,String newPwd){
        Map<String,Object> map = new HashMap<>();
        boolean flag = false;
        Manager manager = (Manager)request.getSession().getAttribute("manager");
        String oldPwd1 = manager.getManagerPassword();
        if (MD5Util.getMD5(oldPwd).equals(oldPwd1)){
            manager.setManagerPassword(MD5Util.getMD5(newPwd));
            map = managerService.updateManager(manager);
            return map;
        }else{
            map.put("success",flag);
            map.put("title","原密码错误");
            return map;
        }
    }

    //返回管理主界面请求
    @RequestMapping("/rootpage.do")
    public ModelAndView torootpage(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rootpage/index");
        return  mv;
    }

    //返回主界面请求
    @RequestMapping("/index.do")
    public ModelAndView toindex(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return  mv;
    }
    //注册请求
    @RequestMapping("/register.do")
    @ResponseBody
    public Map register(User user){
        user.setPassword(MD5Util.getMD5(user.getPassword()));
        user.setId(UUIDUtil.getUUID());
        user.setImgpath("headimgs/defult.png");
        System.out.println(user);
        boolean flae = userService.register(user);
        Map<String,Object> map = new HashMap<>();
        map.put("success",flae);
        return  map;
    }
}
