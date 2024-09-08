package com.example.rzb.service;



import com.example.rzb.entity.CategoryEntity;
import com.example.rzb.models.CategoryModel;

import java.util.List;

public interface CategoryService {
    CategoryEntity findCategoryById(Long id);
    CategoryEntity createCategory(CategoryModel categoryModel);
    List<CategoryEntity> findCategoryByTownId(Long townId);
    List<CategoryEntity> getCategoryList();

    CategoryEntity updateCategory(CategoryModel categoryModel, Long categoryId);

    void deleteCategory(Long categoryId);
}

