package com.xiaojie;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.domian.User;
import com.xiaojie.hotel.service.UserService;
import com.xiaojie.hotel.util.CreateValidateCode;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.util.MD5Util;
import com.xiaojie.hotel.util.UUIDUtil;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;

import java.util.List;


public class Mytest {
    @Test
    public void test1(){
        CreateValidateCode c =  CreateValidateCode.Instance();
        System.out.println("图片为"+c.getImage());
        System.out.println("验证码为"+c.getString());
        String s= MD5Util.getMD5("123");
        System.out.println(s);
    }
    @Test
    public void test2(){
        //1.指定配置文件,配置文件在类路径下
        String config = "conf/applicationCOntext.xml";
        //2.创建表示spring容器的对象，ApplicationContext
        //ApplicationContext就是表示spring容器，通过容器获取对象
        //ClassPathXmlApplactionContext:表示从类路径加载配置文件
        ApplicationContext ac = new ClassPathXmlApplicationContext(config);
        UserService us = (UserService) ac.getBean("userService");
        PageHelper.startPage(1,1);
        List<User> list = us.findAll();
        PageInfo pageInfo = new PageInfo(list);
        System.out.println(pageInfo.getList());
    }
    @Test
    public void test3(){
        DeleteFile.deleteFile("images/roomImgs/w.jpg;images/roomImgs/q.png");
    }
}
