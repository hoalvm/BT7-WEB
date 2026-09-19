package lyvomyhoa.springboot_rest_ajax;

import lyvomyhoa.springboot_rest_ajax.service.IStorageService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SpringbootRestAjaxApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringbootRestAjaxApplication.class, args);
	}

	@Bean
	CommandLineRunner init(IStorageService storageService) {
		return args -> storageService.init();
	}
}
