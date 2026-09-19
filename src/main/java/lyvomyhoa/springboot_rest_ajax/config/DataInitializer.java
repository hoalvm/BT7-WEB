package lyvomyhoa.springboot_rest_ajax.config;

import lyvomyhoa.springboot_rest_ajax.entity.Category;
import lyvomyhoa.springboot_rest_ajax.entity.Product;
import lyvomyhoa.springboot_rest_ajax.repository.CategoryRepository;
import lyvomyhoa.springboot_rest_ajax.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    public void run(String... args) {
        if (categoryRepository.count() > 0) return; // Chỉ seed lần đầu

        // --- Categories ---
        Category electronics = categoryRepository.save(Category.builder()
                .categoryName("Electronics").build());
        Category clothing = categoryRepository.save(Category.builder()
                .categoryName("Clothing").build());
        Category homeKitchen = categoryRepository.save(Category.builder()
                .categoryName("Home & Kitchen").build());
        Category booksMedia = categoryRepository.save(Category.builder()
                .categoryName("Books & Media").build());

        // --- Products ---
        List<Product> products = List.of(
            Product.builder()
                .productName("Wireless Noise-Cancelling Headphones")
                .unitPrice(2990000.0).discount(10.0).quantity(50)
                .status((short)1).category(electronics)
                .description("Premium over-ear headphones with 30-hour battery life.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Mechanical Gaming Keyboard")
                .unitPrice(1450000.0).discount(5.0).quantity(80)
                .status((short)1).category(electronics)
                .description("Full-size mechanical keyboard with RGB backlight and blue switches.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Ultra-Slim Laptop Stand")
                .unitPrice(390000.0).discount(0.0).quantity(120)
                .status((short)1).category(electronics)
                .description("Adjustable aluminum stand, compatible with most laptops 11–17\".")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Men's Slim-Fit Oxford Shirt")
                .unitPrice(450000.0).discount(15.0).quantity(200)
                .status((short)1).category(clothing)
                .description("Classic Oxford weave, 100% cotton, available in 6 colors.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Women's High-Waist Linen Pants")
                .unitPrice(520000.0).discount(10.0).quantity(150)
                .status((short)1).category(clothing)
                .description("Breathable linen blend with tapered fit and side pockets.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Unisex Minimalist Sneakers")
                .unitPrice(890000.0).discount(0.0).quantity(90)
                .status((short)1).category(clothing)
                .description("Clean white canvas sneakers with non-slip rubber sole.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Pour-Over Coffee Dripper Set")
                .unitPrice(320000.0).discount(0.0).quantity(60)
                .status((short)1).category(homeKitchen)
                .description("Borosilicate glass dripper with 40 paper filters included.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Ceramic Non-Stick Frying Pan 28cm")
                .unitPrice(680000.0).discount(8.0).quantity(45)
                .status((short)1).category(homeKitchen)
                .description("PFOA-free ceramic coating, induction-compatible, dishwasher-safe.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("Clean Code — Robert C. Martin")
                .unitPrice(245000.0).discount(5.0).quantity(300)
                .status((short)1).category(booksMedia)
                .description("A handbook of agile software craftsmanship. Essential for every developer.")
                .createDate(new Date()).build(),

            Product.builder()
                .productName("The Design of Everyday Things")
                .unitPrice(195000.0).discount(0.0).quantity(180)
                .status((short)0).category(booksMedia)
                .description("Don Norman's classic on user-centered design and usability.")
                .createDate(new Date()).build()
        );

        productRepository.saveAll(products);
    }
}
