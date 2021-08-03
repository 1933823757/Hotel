package com.xiaojie.hotel.controller;

import com.xiaojie.hotel.Exception.LoginCodeException;
import com.xiaojie.hotel.Exception.LoginUserException;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.UserService;
import com.xiaojie.hotel.util.CreateValidateCode;
import com.xiaojie.hotel.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
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
    @RequestMapping("/Verifylogin.do")
    public String islogin(String username,String password,String captcha,HttpServletRequest request) throws LoginCodeException, LoginUserException {
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
        return  "index";
    }
}
