package com.xiaojie;

import com.xiaojie.hotel.util.CreateValidateCode;
import com.xiaojie.hotel.util.DeleteFile;
import com.xiaojie.hotel.util.MD5Util;
import com.xiaojie.hotel.service.Impl.MailSenderSrvServiceImpl;
import com.xiaojie.hotel.service.MailSenderSrvServices;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


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
        MailSenderSrvServices s = new MailSenderSrvServiceImpl();
        String to = "1933823757@qq.com";
        String subject = "测试，这是一部新邮件";
        String cotent = "今天天气正不错，测试";
        s.sendEmail(to,subject,cotent);
//        UserService us = (UserService) ac.getBean("userService");
//        PageHelper.startPage(1,1);
//        List<User> list = us.findAll();
//        PageInfo pageInfo = new PageInfo(list);
//        System.out.println(pageInfo.getList());
    }
    @Test
    public void test3(){
        DeleteFile.deleteFile("images/roomImgs/w.jpg;images/roomImgs/q.png");
    }
    @Test
    public void test4(){
        String s1 = "101";
        String s2 = "1cd1e761c854493388350c6604c8c96f";
        System.out.println("s1----------------"+s1.length());
        System.out.println("s2----------------"+s2.length());
    }
}
