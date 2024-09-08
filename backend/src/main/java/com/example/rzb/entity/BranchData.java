package com.example.rzb.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.List;

@Entity
public class BranchData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String addressLine1;
    private String branchFor;
    private String contactEmail;
    private String contactNumber;
    private String createdAt;
    private Integer createdBy;
    private String deletedAt;
    private Integer deletedBy;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Integer managerId;
    private String name;
    private String slug;
    private Integer status;
    private String updatedAt;
    private Integer updatedBy;
    private String branchImg;
    private String description;
    private Integer totalReview;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "branchData")
    private List<WorkingHourList> workingHourList;
    // Getters and Setters
}

