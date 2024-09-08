package com.example.rzb.controller;

import com.example.rzb.entity.BranchData;
import com.example.rzb.service.BranchService;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/branches")
public class BranchController {
    @Autowired
    private BranchService branchService;

    @GetMapping
    public List<BranchData> getAllBranches() {
        return branchService.getAllBranches();
    }

    @GetMapping("/{id}")
    public ResponseEntity<BranchData> getBranchById(@PathVariable Long id) {
        return ResponseEntity.ok(branchService.getBranchById(id));
    }

    @PostMapping
    public ResponseEntity<BranchData> createBranch(@RequestBody BranchData branchData) {
        return new ResponseEntity<>(branchService.createBranch(branchData), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<BranchData> updateBranch(@PathVariable Long id, @RequestBody BranchData branchData) {
        return ResponseEntity.ok(branchService.updateBranch(id, branchData));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBranch(@PathVariable Long id) {
        branchService.deleteBranch(id);
        return ResponseEntity.noContent().build();
    }
}

