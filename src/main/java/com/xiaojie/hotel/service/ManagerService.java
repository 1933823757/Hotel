package com.xiaojie.hotel.service;

import com.xiaojie.hotel.domian.Manager;

import java.util.Map;

public interface ManagerService {
    Manager getManager(Manager manager);

    Map<String, Object> updateManager(Manager manager);
}
