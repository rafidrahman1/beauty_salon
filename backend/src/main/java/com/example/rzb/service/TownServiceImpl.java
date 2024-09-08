package com.example.rzb.service;

import lombok.RequiredArgsConstructor;
import com.example.rzb.entity.TownEntity;
import com.example.rzb.models.TownModel;
import com.example.rzb.repository.TownRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor

public class TownServiceImpl implements TownService {

    private final TownRepository townRepository;
    @Override
    public TownEntity findTownById(Long townId) {

        return townRepository.findById(townId)
                .orElseThrow();
    }

    @Override
    public TownEntity createTown(TownModel townModel) {
        TownEntity town = TownEntity.builder()//no need to build constructor
                .name(townModel.getName())
                .build();

        //elaborated
        return townRepository.save(town);
    }

    @Override
    public List<TownEntity> getTownList() {
        return townRepository.findAll();
    }

    @Override
    public TownEntity updateTown(TownModel townModel, Long townId) {
        TownEntity townFromDB = townRepository.findById(townId)
                .orElseThrow();
        return townRepository.save(townFromDB);
    }

    @Override
    public void deleteTown(Long townId) {
        townRepository.deleteById(townId);
    }


}