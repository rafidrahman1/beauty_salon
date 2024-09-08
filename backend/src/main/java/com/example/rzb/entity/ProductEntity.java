package com.example.rzb.entity;

import  jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Builder;
import com.fasterxml.jackson.annotation.JsonBackReference;


@Entity
@Table (name = "product_entity")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class ProductEntity {

    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String name;

    @Column
    private long time;

    @Column
    private long price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name= "category_id" , referencedColumnName = "id")
    @JsonBackReference
    private CategoryEntity category;

}
