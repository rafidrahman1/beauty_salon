package com.example.rzb.service;

import com.example.rzb.entity.ProductEntity;
import com.example.rzb.models.ProductModel;
import com.example.rzb.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor

public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Override
    public ProductEntity findProductById(Long productId){

        return productRepository.findById(productId)
                .orElseThrow();

    }

    @Override
    public ProductEntity createProduct(ProductModel productModel) {
        ProductEntity product = ProductEntity.builder()
                .name(productModel.getName())
                .build();
        return productRepository.save(product);
    }

    @Override
    public List<ProductEntity> findProductByCategoryId(Long categoryId){
        return  productRepository.findByCategoryId(categoryId);
    }

    @Override
    public List<ProductEntity> getProductList() {

        return productRepository.findAll();
    }

    @Override
    public ProductEntity updateProduct(ProductModel productModel, Long productId) {
        ProductEntity productFromDB = productRepository.findById(productId)
                .orElseThrow();
        return productRepository.save(productFromDB);
    }

    @Override
    public void deleteProduct(Long productId) {
        productRepository.deleteById(productId);

    }


}
