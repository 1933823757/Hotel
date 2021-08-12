package com.xiaojie.hotel.service.Impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaojie.hotel.dao.CustomerDao;
import com.xiaojie.hotel.domian.Customer;
import com.xiaojie.hotel.service.CustomerService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerServiceImpl implements CustomerService {
    private CustomerDao customerDao;

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

    @Override
    public Map<String, Object> getCustomerList(Customer customer, Integer pageNo1, Integer pageSize1) {
        //分页
        Map<String, Object> map = new HashMap<>();
        PageHelper.startPage(pageNo1, pageSize1);
        List<Customer> list = customerDao.selectCustomerAll(customer);
        PageInfo pageInfo = new PageInfo(list);
        map.put("total", pageInfo.getTotal());
        map.put("pages", pageInfo.getPages());
        map.put("list", pageInfo.getList());
        return map;
    }

    //删除客户记录
    @Override
    public Map<String, Object> deleteCustomer(String[] id) {
        int index = 0;
        boolean flag = false;
        Map<String, Object> map = new HashMap<>();
        for(int i = 0;i<id.length;i++){
            String customerId = id[i];
            Customer customer = customerDao.selectCustomerById(customerId);
            if (Integer.valueOf(customer.getState())>0){
                if (Integer.valueOf(customer.getState()) == 1){
                    map.put("title","删除失败,"+customer.getC_name()+"预定了房间");

                }else{
                    map.put("title","删除失败,"+customer.getC_name()+"正在入住房间中");
                }
            }
            else{
                int num = customerDao.deleteCustomerById(customerId);
                if (num == 1){
                    map.put("title",customer.getC_name()+"客户删除成功");
                    index+=1;
                }
            }
        }
        if (index ==id.length){
            flag = true;
        }
        map.put("success",flag);
        return map;
    }
}
