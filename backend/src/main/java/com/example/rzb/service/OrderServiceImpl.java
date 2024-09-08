package com.example.rzb.service;

import com.example.rzb.entity.OrderEntity;
import com.example.rzb.entity.ProductEntity;
import com.example.rzb.models.OrderModel;
import com.example.rzb.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import com.example.rzb.repository.ProductRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;

    @Override
    public OrderEntity findOrderById(Long orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    @Override
    public OrderEntity createOrder(OrderModel orderModel) {
        List<ProductEntity> products = productRepository.findAllById(orderModel.getProductIds());

        // Calculate total price and generate order details
        double totalPrice = calculatePrice(orderModel.getProductIds()); // Updated method to get price
        String productDetails = products.stream()
                .map(product -> product.getName() + " - Time: " + product.getTime() + " min | Price: $" + product.getPrice())
                .collect(Collectors.joining("\n"));

        // Create OrderEntity and save it
        OrderEntity orderEntity = OrderEntity.builder()
                .name(orderModel.getName())
                .email(orderModel.getEmail())
                .phone(orderModel.getPhone())
                .comment(orderModel.getComment())
                .details(productDetails)
                .price(totalPrice)
                .build();

        return orderRepository.save(orderEntity);
    }

    @Override
    public List<OrderEntity> getOrderList() {
        return orderRepository.findAll();
    }

    @Override
    public OrderEntity updateOrder(OrderModel orderModel, Long orderId) {
        OrderEntity orderFromDB = findOrderById(orderId);
        orderFromDB.setName(orderModel.getName());
        orderFromDB.setEmail(orderModel.getEmail());
        orderFromDB.setPhone(orderModel.getPhone());
        orderFromDB.setComment(orderModel.getComment());
        orderFromDB.setDetails(orderModel.getDetails());
        orderFromDB.setPrice(orderModel.getPrice());
        return orderRepository.save(orderFromDB);
    }

    @Override
    public void deleteOrder(Long orderId) {
        orderRepository.deleteById(orderId);
    }

    public double calculatePrice(List<Long> productIds) {
        List<ProductEntity> products = productRepository.findAllById(productIds);

        return products.stream()
                .mapToDouble(ProductEntity::getPrice)
                .sum();
    }


}
