package lyvomyhoa.springboot_rest_ajax.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CategoryPageController {

    @GetMapping("/categories")
    public String categoriesPage() {
        return "categories/index";
    }
}
