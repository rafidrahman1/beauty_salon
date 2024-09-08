package com.example.rzb.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.*;

@Entity
public class BranchBreaks {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String startBreak;
    private String endBreak;

    @ManyToOne
    @JoinColumn(name = "working_hour_id")
    private WorkingHourList workingHourList;
    // Getters and Setters
}