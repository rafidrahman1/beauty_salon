package com.example.rzb.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Builder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class ProductModel {

    private Long id;
    private String name;
    private Long time;
    private Long price;

}