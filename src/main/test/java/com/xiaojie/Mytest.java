package com.xiaojie;

import com.xiaojie.hotel.service.UserService;
import com.xiaojie.hotel.util.CreateValidateCode;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;


public class Mytest {
    @Test
    public void test1(){
        CreateValidateCode c =  CreateValidateCode.Instance();
        System.out.println("图片为"+c.getImage());
        System.out.println("验证码为"+c.getString());
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
         us.text();
    }
}
