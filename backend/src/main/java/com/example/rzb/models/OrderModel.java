package com.example.rzb.models;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class OrderModel {

    private Long id;
    private String name;
    private String phone;
    private String email;
    private String comment;
    private String details;
    private double price;
    private List<Long> productIds;

}

