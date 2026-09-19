package lyvomyhoa.springboot_rest_ajax.service;

import lyvomyhoa.springboot_rest_ajax.entity.Product;

import java.util.List;
import java.util.Optional;

public interface IProductService {

    List<Product> findAll();

    Optional<Product> findById(Long id);

    Optional<Product> findByProductName(String name);

    Product save(Product product);

    void deleteById(Long id);

    boolean existsByName(String name);

    boolean existsByNameAndIdNot(String name, Long id);
}
