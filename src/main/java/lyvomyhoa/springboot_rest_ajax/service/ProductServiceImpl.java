package lyvomyhoa.springboot_rest_ajax.service;

import lyvomyhoa.springboot_rest_ajax.entity.Product;
import lyvomyhoa.springboot_rest_ajax.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements IProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public Optional<Product> findById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    public Optional<Product> findByProductName(String name) {
        return productRepository.findByProductName(name);
    }

    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }

    @Override
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public boolean existsByName(String name) {
        return productRepository.findByProductName(name).isPresent();
    }

    @Override
    public boolean existsByNameAndIdNot(String name, Long id) {
        return productRepository.findByProductName(name)
                .filter(p -> !p.getProductId().equals(id))
                .isPresent();
    }

    @Override
    public boolean existsByCategoryId(Long categoryId) {
        return productRepository.existsByCategory_CategoryId(categoryId);
    }
}
