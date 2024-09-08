package com.example.rzb.service;

import com.example.rzb.entity.BranchData;
import com.example.rzb.repository.BranchDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BranchService {
    @Autowired
    private BranchDataRepository branchDataRepository;

    public List<BranchData> getAllBranches() {
        return branchDataRepository.findAll();
    }

    public BranchData getBranchById(Long id) {
        return branchDataRepository.findById(id)
                .orElseThrow() ;
    }

    public BranchData createBranch(BranchData branchData) {
        return branchDataRepository.save(branchData);
    }

    public BranchData updateBranch(Long id, BranchData branchData) {
        BranchData existingBranch = getBranchById(id);
        // Update fields as needed
        return branchDataRepository.save(existingBranch);
    }

    public void deleteBranch(Long id) {
        branchDataRepository.deleteById(id);
    }
}

