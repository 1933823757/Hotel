package com.xiaojie;

import com.xiaojie.hotel.util.CreateValidateCode;
import org.junit.Test;


public class Mytest {
    @Test
    public void test1(){
        CreateValidateCode c =  CreateValidateCode.Instance();
        System.out.println("图片为"+c.getImage());
        System.out.println("验证码为"+c.getString());
    }
}
