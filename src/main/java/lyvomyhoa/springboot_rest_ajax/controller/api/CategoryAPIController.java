package lyvomyhoa.springboot_rest_ajax.controller.api;

import lyvomyhoa.springboot_rest_ajax.entity.Category;
import lyvomyhoa.springboot_rest_ajax.model.Response;
import lyvomyhoa.springboot_rest_ajax.service.ICategoryService;
import lyvomyhoa.springboot_rest_ajax.service.IProductService;
import lyvomyhoa.springboot_rest_ajax.service.IStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/category")
public class CategoryAPIController {

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IProductService productService;

    @Autowired
    private IStorageService storageService;

    // GET /api/category — list all
    @GetMapping
    public ResponseEntity<Response> getAll() {
        List<Category> categories = categoryService.findAll();
        return ResponseEntity.ok(Response.builder()
                .status(true)
                .message("OK")
                .body(categories)
                .build());
    }

    // POST /api/category/getCategory?id={id}
    @PostMapping("/getCategory")
    public ResponseEntity<Response> getById(@RequestParam Long id) {
        Optional<Category> opt = categoryService.findById(id);
        if (opt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Response.builder().status(false).message("Category not found").body(null).build());
        }
        return ResponseEntity.ok(Response.builder().status(true).message("OK").body(opt.get()).build());
    }

    // POST /api/category/addCategory
    @PostMapping("/addCategory")
    public ResponseEntity<Response> addCategory(
            @RequestParam String categoryName,
            @RequestParam(required = false) MultipartFile icon) {

        if (categoryName == null || categoryName.isBlank()) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Category name is required").body(null).build());
        }
        if (categoryService.existsByName(categoryName.trim())) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Category name already exists").body(null).build());
        }

        Category category = new Category();
        category.setCategoryName(categoryName.trim());

        // Save first to get ID for filename
        Category saved = categoryService.save(category);

        // Handle icon upload
        if (icon != null && !icon.isEmpty()) {
            String filename = storageService.getStorageFilename(icon, String.valueOf(saved.getCategoryId()));
            storageService.store(icon, filename);
            saved.setIcon(filename);
            saved = categoryService.save(saved);
        }

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(Response.builder().status(true).message("Category created successfully").body(saved).build());
    }

    // PUT /api/category/updateCategory
    @PutMapping("/updateCategory")
    public ResponseEntity<Response> updateCategory(
            @RequestParam Long categoryId,
            @RequestParam String categoryName,
            @RequestParam(required = false) MultipartFile icon) {

        Optional<Category> opt = categoryService.findById(categoryId);
        if (opt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Response.builder().status(false).message("Category not found").body(null).build());
        }

        if (categoryName == null || categoryName.isBlank()) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Category name is required").body(null).build());
        }

        if (categoryService.existsByNameAndIdNot(categoryName.trim(), categoryId)) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Category name already exists").body(null).build());
        }

        Category category = opt.get();
        category.setCategoryName(categoryName.trim());

        // Handle icon: only replace if new file provided
        if (icon != null && !icon.isEmpty()) {
            // Delete old icon
            if (category.getIcon() != null && !category.getIcon().isBlank()) {
                try { storageService.delete(category.getIcon()); } catch (Exception ignored) {}
            }
            String filename = storageService.getStorageFilename(icon, String.valueOf(categoryId));
            storageService.store(icon, filename);
            category.setIcon(filename);
        }
        // If no new icon: keep existing icon

        Category updated = categoryService.save(category);
        return ResponseEntity.ok(Response.builder().status(true).message("Category updated successfully").body(updated).build());
    }

    // DELETE /api/category/deleteCategory?categoryId={id}
    @DeleteMapping("/deleteCategory")
    public ResponseEntity<Response> deleteCategory(@RequestParam Long categoryId) {
        Optional<Category> opt = categoryService.findById(categoryId);
        if (opt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Response.builder().status(false).message("Category not found").body(null).build());
        }

        if (productService.existsByCategoryId(categoryId)) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Cannot delete category: products are assigned to this category").body(null).build());
        }

        Category category = opt.get();
        // Delete icon file if exists
        if (category.getIcon() != null && !category.getIcon().isBlank()) {
            try { storageService.delete(category.getIcon()); } catch (Exception ignored) {}
        }
        try {
            categoryService.deleteById(categoryId);
        } catch (org.springframework.dao.DataIntegrityViolationException ex) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Cannot delete category: products are assigned to this category").body(null).build());
        }
        return ResponseEntity.ok(Response.builder().status(true).message("Category deleted successfully").body(null).build());
    }
}
