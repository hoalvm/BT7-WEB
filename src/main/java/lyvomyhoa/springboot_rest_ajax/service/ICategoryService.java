package lyvomyhoa.springboot_rest_ajax.service;

import lyvomyhoa.springboot_rest_ajax.entity.Category;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

public interface ICategoryService {

    List<Category> findAll();

    Optional<Category> findById(Long id);

    Optional<Category> findByCategoryName(String name);

    Category save(Category category);

    void deleteById(Long id);

    boolean existsByName(String name);

    boolean existsByNameAndIdNot(String name, Long id);
}
