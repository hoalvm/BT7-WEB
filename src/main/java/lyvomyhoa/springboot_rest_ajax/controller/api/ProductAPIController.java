package lyvomyhoa.springboot_rest_ajax.controller.api;

import lyvomyhoa.springboot_rest_ajax.entity.Category;
import lyvomyhoa.springboot_rest_ajax.entity.Product;
import lyvomyhoa.springboot_rest_ajax.model.Response;
import lyvomyhoa.springboot_rest_ajax.service.ICategoryService;
import lyvomyhoa.springboot_rest_ajax.service.IProductService;
import lyvomyhoa.springboot_rest_ajax.service.IStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/product")
public class ProductAPIController {

    @Autowired
    private IProductService productService;

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IStorageService storageService;

    // GET /api/product
    @GetMapping
    public ResponseEntity<Response> getAll() {
        List<Product> products = productService.findAll();
        return ResponseEntity.ok(Response.builder()
                .status(true).message("OK").body(products).build());
    }

    // POST /api/product/getProduct?id={id}
    @PostMapping("/getProduct")
    public ResponseEntity<Response> getById(@RequestParam Long id) {
        Optional<Product> opt = productService.findById(id);
        if (opt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Response.builder().status(false).message("Product not found").body(null).build());
        }
        return ResponseEntity.ok(Response.builder().status(true).message("OK").body(opt.get()).build());
    }

    // POST /api/product/addProduct
    @PostMapping("/addProduct")
    public ResponseEntity<Response> addProduct(
            @RequestParam String productName,
            @RequestParam(required = false) MultipartFile imageFile,
            @RequestParam Double unitPrice,
            @RequestParam(required = false, defaultValue = "0") Double discount,
            @RequestParam(required = false, defaultValue = "") String description,
            @RequestParam Long categoryId,
            @RequestParam(defaultValue = "0") Integer quantity,
            @RequestParam(defaultValue = "1") Short status) {

        if (productName == null || productName.isBlank()) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Product name is required").body(null).build());
        }
        if (unitPrice == null || unitPrice < 0) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Unit price must be >= 0").body(null).build());
        }
        if (quantity < 0) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Quantity must be >= 0").body(null).build());
        }

        Optional<Category> catOpt = categoryService.findById(categoryId);
        if (catOpt.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Category not found").body(null).build());
        }

        Product product = new Product();
        product.setProductName(productName.trim());
        product.setUnitPrice(unitPrice);
        product.setDiscount(discount);
        product.setDescription(description);
        product.setQuantity(quantity);
        product.setStatus(status);
        product.setCategory(catOpt.get());
        product.setCreateDate(new Date());

        Product saved = productService.save(product);

        if (imageFile != null && !imageFile.isEmpty()) {
            String filename = storageService.getStorageFilename(imageFile, String.valueOf(saved.getProductId()));
            storageService.store(imageFile, filename);
            saved.setImages(filename);
            saved = productService.save(saved);
        }

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(Response.builder().status(true).message("Product created successfully").body(saved).build());
    }

    // PUT /api/product/updateProduct
    @PutMapping("/updateProduct")
    public ResponseEntity<Response> updateProduct(
            @RequestParam Long productId,
            @RequestParam String productName,
            @RequestParam(required = false) MultipartFile imageFile,
            @RequestParam Double unitPrice,
            @RequestParam(required = false, defaultValue = "0") Double discount,
            @RequestParam(required = false, defaultValue = "") String description,
            @RequestParam Long categoryId,
            @RequestParam(defaultValue = "0") Integer quantity,
            @RequestParam(defaultValue = "1") Short status) {

        Optional<Product> opt = productService.findById(productId);
        if (opt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Response.builder().status(false).message("Product not found").body(null).build());
        }
        if (productName == null || productName.isBlank()) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Product name is required").body(null).build());
        }
        if (unitPrice < 0 || quantity < 0) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Price and quantity must be >= 0").body(null).build());
        }

        Optional<Category> catOpt = categoryService.findById(categoryId);
        if (catOpt.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Response.builder().status(false).message("Category not found").body(null).build());
        }

        Product product = opt.get();
        product.setProductName(productName.trim());
        product.setUnitPrice(unitPrice);
        product.setDiscount(discount);
        product.setDescription(description);
        product.setQuantity(quantity);
        product.setStatus(status);
        product.setCategory(catOpt.get());

        if (imageFile != null && !imageFile.isEmpty()) {
            // Delete old image
            if (product.getImages() != null && !product.getImages().isBlank()) {
                try { storageService.delete(product.getImages()); } catch (Exception ignored) {}
            }
            String filename = storageService.getStorageFilename(imageFile, String.valueOf(productId));
            storageService.store(imageFile, filename);
            product.setImages(filename);
        }
        // No new image: keep existing

        Product updated = productService.save(product);
        return ResponseEntity.ok(Response.builder().status(true).message("Product updated successfully").body(updated).build());
    }

    // DELETE /api/product/deleteProduct?productId={id}
    @DeleteMapping("/deleteProduct")
    public ResponseEntity<Response> deleteProduct(@RequestParam Long productId) {
        Optional<Product> opt = productService.findById(productId);
        if (opt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Response.builder().status(false).message("Product not found").body(null).build());
        }
        Product product = opt.get();
        if (product.getImages() != null && !product.getImages().isBlank()) {
            try { storageService.delete(product.getImages()); } catch (Exception ignored) {}
        }
        productService.deleteById(productId);
        return ResponseEntity.ok(Response.builder().status(true).message("Product deleted successfully").body(null).build());
    }
}
