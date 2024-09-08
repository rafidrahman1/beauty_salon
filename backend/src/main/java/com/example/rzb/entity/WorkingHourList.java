package com.example.rzb.entity;


import jakarta.persistence.*;

import java.util.List;

@Entity
public class WorkingHourList {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String day;
    private String endTime;
    private Integer isHoliday;
    private String startTime;

    @ManyToOne
    @JoinColumn(name = "branch_id")
    private BranchData branchData;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "workingHourList")
    private List<BranchBreaks> branchBreaks;
    // Getters and Setters
}

