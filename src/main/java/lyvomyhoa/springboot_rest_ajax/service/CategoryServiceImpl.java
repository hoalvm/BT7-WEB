package lyvomyhoa.springboot_rest_ajax.service;

import lyvomyhoa.springboot_rest_ajax.entity.Category;
import lyvomyhoa.springboot_rest_ajax.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Optional<Category> findById(Long id) {
        return categoryRepository.findById(id);
    }

    @Override
    public Optional<Category> findByCategoryName(String name) {
        return categoryRepository.findByCategoryName(name);
    }

    @Override
    public Category save(Category category) {
        return categoryRepository.save(category);
    }

    @Override
    public void deleteById(Long id) {
        categoryRepository.deleteById(id);
    }

    @Override
    public boolean existsByName(String name) {
        return categoryRepository.findByCategoryName(name).isPresent();
    }

    @Override
    public boolean existsByNameAndIdNot(String name, Long id) {
        return categoryRepository.findByCategoryName(name)
                .filter(c -> !c.getCategoryId().equals(id))
                .isPresent();
    }
}
