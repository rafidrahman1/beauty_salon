package com.example.rzb.controller;

import lombok.RequiredArgsConstructor;
import com.example.rzb.entity.ProductEntity;
import com.example.rzb.models.ProductModel;
import com.example.rzb.service.ProductService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/product")
@RequiredArgsConstructor



public class ProductController {
    private final ProductService productService;
    @GetMapping("/all")
    public ResponseEntity<List<ProductEntity>> getAllProduct(){

        List<ProductEntity> allProduct = productService.getProductList();

        //all product return hobe
        return new ResponseEntity<>(allProduct, HttpStatus.OK);
    }
    @GetMapping("/{productId}") //http request to get info from database
    public ResponseEntity<ProductEntity> getProductById(@PathVariable("productId") long productId){
        ProductEntity productEntity = productService.findProductById(productId);
        return new ResponseEntity<>(productEntity, HttpStatus.OK);
        //1 ta product
    }

    // Get categories by category ID
    @GetMapping("/category/{categoryId}")
    public ResponseEntity<List<ProductEntity>> getProductByCategoryId(@PathVariable("categoryId") Long categoryId) {
        List<ProductEntity> product = productService.findProductByCategoryId(categoryId);
        return new ResponseEntity<>(product, HttpStatus.OK);
    }

    @PostMapping("/create") //http request to post in database
    public ResponseEntity<ProductEntity> createProduct(@RequestBody ProductModel productModel){
        ProductEntity productEntity = productService.createProduct(productModel);
        return new ResponseEntity<>(productEntity, HttpStatus.OK);
    }

    @PutMapping("/update/{productId}")
    public ResponseEntity<ProductEntity> updateProduct(@RequestBody ProductModel productModel, @PathVariable Long productId){
        ProductEntity productEntity = productService.updateProduct(productModel, productId);
        return new ResponseEntity<>(productEntity, HttpStatus.OK);
    }
    @DeleteMapping("/delete/{productId}")
    public ResponseEntity<Object> deleteMapping(@PathVariable Long productId){
        productService.deleteProduct(productId);
        return new ResponseEntity<>("Deleted", HttpStatus.OK);
    }

}
