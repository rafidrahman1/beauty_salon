package com.example.rzb.service;

import com.example.rzb.entity.TownEntity;
import com.example.rzb.models.TownModel;

import java.util.List;


public interface TownService {

    TownEntity findTownById(Long id);
    TownEntity createTown(TownModel townModel);
    List<TownEntity> getTownList();

    TownEntity updateTown(TownModel townModel, Long townId);

    void deleteTown(Long townId);


}
