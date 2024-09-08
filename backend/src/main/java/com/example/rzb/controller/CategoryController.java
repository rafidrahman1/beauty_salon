package com.example.rzb.controller;

import lombok.RequiredArgsConstructor;
import com.example.rzb.entity.CategoryEntity;
import com.example.rzb.models.CategoryModel;
import com.example.rzb.service.CategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/category")
@RequiredArgsConstructor



public class CategoryController {
    private final CategoryService categoryService;
    @GetMapping("/all")
    public ResponseEntity<List<CategoryEntity>> getAllCategory(){

        List<CategoryEntity> allCategory = categoryService.getCategoryList();

        //all category return hobe
        return new ResponseEntity<>(allCategory, HttpStatus.OK);
    }
    @GetMapping("/{categoryId}") //http request to get info from database
    public ResponseEntity<CategoryEntity> getCategoryById(@PathVariable("categoryId") long categoryId){
        CategoryEntity categoryEntity = categoryService.findCategoryById(categoryId);
        return new ResponseEntity<>(categoryEntity, HttpStatus.OK);
        //1 ta category
    }

    // Get categories by town ID
    @GetMapping("/town/{townId}")
    public ResponseEntity<List<CategoryEntity>> getCategoryByTownId(@PathVariable("townId") Long townId) {
        List<CategoryEntity> category = categoryService.findCategoryByTownId(townId);
        return new ResponseEntity<>(category, HttpStatus.OK);
    }

    @PostMapping("/create") //http request to post in database
    public ResponseEntity<CategoryEntity> createCategory(@RequestBody CategoryModel categoryModel){
        CategoryEntity categoryEntity = categoryService.createCategory(categoryModel);
        return new ResponseEntity<>(categoryEntity, HttpStatus.OK);
    }

    @PutMapping("/update/{categoryId}")
    public ResponseEntity<CategoryEntity> updateCategory(@RequestBody CategoryModel categoryModel, @PathVariable Long categoryId){
        CategoryEntity categoryEntity = categoryService.updateCategory(categoryModel, categoryId);
        return new ResponseEntity<>(categoryEntity, HttpStatus.OK);
    }
    @DeleteMapping("/delete/{categoryId}")
    public ResponseEntity<Object> deleteMapping(@PathVariable Long categoryId){
        categoryService.deleteCategory(categoryId);
        return new ResponseEntity<>("Deleted", HttpStatus.OK);
    }

}
