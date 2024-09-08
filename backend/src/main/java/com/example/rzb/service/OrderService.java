package com.example.rzb.service;

import com.example.rzb.entity.OrderEntity;
import com.example.rzb.models.OrderModel;

import java.util.List;

public interface OrderService {
    OrderEntity findOrderById(Long id);
    OrderEntity createOrder(OrderModel orderModel);

    List<OrderEntity> getOrderList();

    OrderEntity updateOrder(OrderModel orderModel, Long orderId);

    void deleteOrder(Long orderId);
    double calculatePrice(List<Long> productIds);


}
