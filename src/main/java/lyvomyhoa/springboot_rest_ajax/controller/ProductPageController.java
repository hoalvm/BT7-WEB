package lyvomyhoa.springboot_rest_ajax.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductPageController {

    @GetMapping({"/", "/products"})
    public String productsPage() {
        return "products/index";
    }
}
