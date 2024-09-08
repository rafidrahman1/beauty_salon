package com.example.rzb.repository;

import com.example.rzb.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;




@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Long> {



}
