package com.example.rzb.controller;

import lombok.RequiredArgsConstructor;
import com.example.rzb.entity.TownEntity;
import com.example.rzb.models.TownModel;
import com.example.rzb.service.TownService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/town")
@RequiredArgsConstructor

public class TownController {
    private final TownService townService;
    @GetMapping("/all")
    public ResponseEntity<List<TownEntity>> getAllTown(){

        List<TownEntity> allTown = townService.getTownList();

        //all town return hobe
        return new ResponseEntity<>(allTown, HttpStatus.OK);
    }
    @GetMapping("/{townId}")
    public ResponseEntity<TownEntity> getTownById(@PathVariable("townId") long townId) {
        TownEntity townEntity = townService.findTownById(townId);
        return new ResponseEntity<>(townEntity, HttpStatus.OK);
    }


    @PostMapping("/create") //http request to post in database
    public ResponseEntity<TownEntity> createTown(@RequestBody TownModel townModel){
        TownEntity townEntity = townService.createTown(townModel);
        return new ResponseEntity<>(townEntity, HttpStatus.OK);
    }

    @PutMapping("/update/{townId}")
    public ResponseEntity<TownEntity> updateTown(@RequestBody TownModel townModel, @PathVariable Long townId){
        TownEntity townEntity = townService.updateTown(townModel, townId);
        return new ResponseEntity<>(townEntity, HttpStatus.OK);
    }
    @DeleteMapping("/delete/{townId}")
    public ResponseEntity<Object> deleteMapping(@PathVariable("townId") Long townId){
        townService.deleteTown(townId);
        return new ResponseEntity<>("Deleted", HttpStatus.OK);
    }

}
