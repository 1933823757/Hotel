package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Customer;

import java.util.Map;

public interface CustomerService {
    Map<String, Object> getCustomerList(Customer customer, Integer pageNo1, Integer pageSize1);

    Map<String, Object> deleteCustomer(String[] id);
}
