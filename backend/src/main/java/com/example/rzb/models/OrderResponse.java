package com.example.rzb.models;

import com.example.rzb.entity.OrderEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderResponse {
    private OrderEntity order;
    private double calculatedPrice;
}
