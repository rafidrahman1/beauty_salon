package com.example.rzb.repository;


import com.example.rzb.entity.TownEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public  interface TownRepository extends JpaRepository<TownEntity, Long> {

       //List<TownEntity> findByPrice(Double price); //custom find method which is not present in JpaRepository
}
