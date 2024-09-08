package com.example.rzb.service;

import com.example.rzb.entity.ProductEntity;
import com.example.rzb.models.ProductModel;

import java.util.List;

public interface ProductService {
    ProductEntity findProductById(Long id);
    ProductEntity createProduct(ProductModel productModel);
    List<ProductEntity>findProductByCategoryId(Long categoryId);

    List<ProductEntity> getProductList();

    ProductEntity updateProduct(ProductModel productModel, Long productId);

    void deleteProduct(Long productId);
}
