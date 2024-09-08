package com.example.rzb.controller;

import com.example.rzb.models.OrderResponse;
import lombok.RequiredArgsConstructor;
import com.example.rzb.entity.OrderEntity;
import com.example.rzb.models.OrderModel;
import com.example.rzb.service.OrderService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/order")
@RequiredArgsConstructor



public class OrderController {
    private final OrderService orderService;
    @GetMapping("/all")
    public ResponseEntity<List<OrderEntity>> getAllOrder(){

        List<OrderEntity> allOrder = orderService.getOrderList();

        //all order return hobe
        return new ResponseEntity<>(allOrder, HttpStatus.OK);
    }
    @GetMapping("/{orderId}") //http request to get info from database
    public ResponseEntity<OrderEntity> getOrderById(@PathVariable("orderId") long orderId){
        OrderEntity orderEntity = orderService.findOrderById(orderId);
        return new ResponseEntity<>(orderEntity, HttpStatus.OK);
        //1 ta order
    }
    



    @PutMapping("/update/{orderId}")
    public ResponseEntity<OrderEntity> updateOrder(@RequestBody OrderModel orderModel, @PathVariable Long orderId){
        OrderEntity orderEntity = orderService.updateOrder(orderModel, orderId);
        return new ResponseEntity<>(orderEntity, HttpStatus.OK);
    }
    @DeleteMapping("/delete/{orderId}")
    public ResponseEntity<Object> deleteMapping(@PathVariable Long orderId){
        orderService.deleteOrder(orderId);
        return new ResponseEntity<>("Deleted", HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<OrderResponse> createOrder(@RequestBody OrderModel orderModel){
        OrderEntity orderEntity = orderService.createOrder(orderModel);
        double calculatedPrice = orderService.calculatePrice(orderModel.getProductIds());
        OrderResponse response = new OrderResponse(orderEntity, calculatedPrice);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }


}
