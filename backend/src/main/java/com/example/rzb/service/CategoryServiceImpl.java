package com.example.rzb.service;

import com.example.rzb.models.CategoryModel;
import com.example.rzb.entity.CategoryEntity;
import com.example.rzb.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor

public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;
    @Override
    public CategoryEntity findCategoryById(Long categoryId) {

        return categoryRepository.findById(categoryId)
                .orElseThrow();
    }

    public List<CategoryEntity> findCategoryByTownId(Long townId) {
        return categoryRepository.findByTownId(townId);
    }

    @Override
    public CategoryEntity createCategory(CategoryModel categoryModel) {
        CategoryEntity category = CategoryEntity.builder()//no need to build constructor
                .name(categoryModel.getName())
                .build();

        //elborated
        return categoryRepository.save(category);
    }

    @Override
    public List<CategoryEntity> getCategoryList() {
        return categoryRepository.findAll();
    }

    @Override
    public CategoryEntity updateCategory(CategoryModel categoryModel, Long categoryId) {
        CategoryEntity categoryFromDB = categoryRepository.findById(categoryId)
                .orElseThrow();
        return categoryRepository.save(categoryFromDB);
    }

    @Override
    public void deleteCategory(Long categoryId) {
        categoryRepository.deleteById(categoryId);
    }


}