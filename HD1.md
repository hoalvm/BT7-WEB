# PHẦN 02 — REFERENCE CHO CODING AGENT
## Spring Boot 4.1.1 + Java 25 + Maven + MySQL + JSP/JSTL + AJAX + Swagger 3

Dùng file này làm source of truth. Không cần đọc lại PDF gốc.

## Yêu cầu bài tập
Trong 01 project:
1. CRUD REST API Category.
2. Swagger 3 / OpenAPI.
3. API + AJAX CRUD đầy đủ cho Category và Product.
4. Sinh viên tự commit/push sau khi kiểm tra. Coding Agent không được commit/push.

## Môi trường đã chốt
- Java 25
- Spring Boot 4.1.1
- Maven
- MySQL `localhost:3306`
- username `root`
- password `123456`
- JSP/JSTL + Bootstrap 5 + jQuery/AJAX
- Swagger 3 bằng Springdoc OpenAPI 3.x

## Build/JSP
Project dùng JSP nên ưu tiên:
```xml
<packaging>war</packaging>
```

Parent:
```xml
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>4.1.1</version>
  <relativePath/>
</parent>

<properties>
  <java.version>25</java.version>
</properties>
```

Dependency cần có theo nhóm:
- Spring MVC/Web
- Spring Data JPA
- Validation
- Lombok
- MySQL Connector/J
- Tomcat JSP compiler (`tomcat-embed-jasper`)
- Jakarta JSTL API + implementation
- Springdoc OpenAPI 3.x
- Commons IO nếu dùng `FilenameUtils`

Không dùng Springfox/Swagger 2.

## MySQL
```sql
CREATE DATABASE IF NOT EXISTS springboot_rest_ajax
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/springboot_rest_ajax?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Ho_Chi_Minh&characterEncoding=UTF-8
spring.datasource.username=root
spring.datasource.password=123456
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

storage.location=uploads
```

Không dùng SQL Server, `SQLServerDriver`, `SQLServerDialect`, `jdbc:sqlserver`, hoặc `nvarchar`-specific mapping.

## Kiến trúc
```text
JSP UI
  ↓ jQuery/AJAX
REST Controller
  ↓
Service
  ↓
Repository
  ↓
MySQL
```

Tách Page Controller trả JSP khỏi REST Controller trả JSON.

## Entity Category
Theo tài liệu:
```text
categoryId : Long
categoryName : String
icon : String
products : Set<Product>
```

Quan hệ:
```java
@OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
private Set<Product> products;
```

Tránh JSON recursion, ví dụ `@JsonIgnore` ở `products`.

## Entity Product
Theo tài liệu:
```text
productId : Long
productName : String
quantity : Integer/int
unitPrice : Double/double
images : String
description : String
discount : Double/double
createDate : Date/Timestamp
status : Short/short
category : Category
```

Quan hệ:
```java
@ManyToOne
@JoinColumn(name = "categoryId")
private Category category;
```

DB chỉ lưu filename/path tương đối của ảnh, không lưu BLOB.

## Repository
CategoryRepository:
```java
List<Category> findByCategoryNameContaining(String name);
Page<Category> findByCategoryNameContaining(String name, Pageable pageable);
Optional<Category> findByCategoryName(String name);
```

ProductRepository:
```java
List<Product> findByProductNameContaining(String name);
Page<Product> findByProductNameContaining(String name, Pageable pageable);
Optional<Product> findByProductName(String name);
Optional<Product> findByCreateDate(Date createAt);
```

Có thể điều chỉnh signature tối thiểu để tương thích Boot 4/JPA nếu cần, nhưng giữ nguyên chức năng.

## Service
Có:
```text
ICategoryService / CategoryServiceImpl
IProductService / ProductServiceImpl
IStorageService / FileSystemStorageServiceImpl
```

Controller không gọi Repository trực tiếp.

Update Category không upload icon mới → giữ icon cũ.
Update Product không upload image mới → giữ ảnh cũ.

## Response model
Theo tài liệu:
```java
public class Response {
    private Boolean status;
    private String message;
    private Object body;
}
```

Không `return null` ở REST endpoint; trả JSON + HTTP status rõ ràng.

## Storage
Tạo:
```text
StorageProperties
IStorageService
FileSystemStorageServiceImpl
StorageException
StorageFileNotFoundException
```

IStorageService tương đương:
```java
void init();
void delete(String storeFilename) throws Exception;
Path load(String filename);
Resource loadAsResource(String filename);
void store(MultipartFile file, String storeFilename);
String getStorageFilename(MultipartFile file, String id);
```

PDF có typo `getSorageFilename`; code mới có thể sửa tên.
Dùng UUID.
Normalize path và chặn path traversal.
Application startup phải `storageService.init()`.

## Category REST API
Base:
```text
/api/category
```

Endpoints bám tài liệu:
```http
GET    /api/category
POST   /api/category/getCategory?id={id}
POST   /api/category/addCategory
PUT    /api/category/updateCategory
DELETE /api/category/deleteCategory?categoryId={id}
```

Create multipart fields:
```text
categoryName
icon
```

Update multipart fields:
```text
categoryId
categoryName
icon
```

Bắt buộc:
- duplicate categoryName phải xử lý;
- category không tồn tại phải báo lỗi;
- update không chọn icon mới giữ icon cũ.

## Product REST API
PDF AJAX giao thêm “CRUD Products bằng Ajax”, nên phải đủ CRUD.

Base:
```text
/api/product
```

Endpoints đề xuất đồng dạng Category:
```http
GET    /api/product
POST   /api/product/getProduct?id={id}
POST   /api/product/addProduct
PUT    /api/product/updateProduct
DELETE /api/product/deleteProduct?productId={id}
```

Create multipart:
```text
productName
imageFile
unitPrice
discount
description
categoryId
quantity
status
```

Update thêm:
```text
productId
```

Bắt buộc:
- categoryId resolve sang Category tồn tại;
- createDate set khi tạo;
- update không image mới giữ image cũ;
- đổi categoryId thì relation đổi;
- delete xử lý record và physical file hợp lý;
- duplicate productName xử lý nếu service áp dụng logic này.

## Validation tối thiểu
Category:
```text
categoryName không rỗng
duplicate name
ID phải tồn tại
```

Product:
```text
productName không rỗng
ID phải tồn tại
categoryId phải tồn tại
unitPrice >= 0
quantity >= 0
discount hợp lệ
status hợp lệ theo representation
```

## Swagger 3
Spring Boot 4.1.1 dùng Springdoc OpenAPI 3.x tương thích Boot 4.

Swagger UI:
```text
/swagger-ui/index.html
```

Phải hiển thị Category API và Product API với GET/POST/PUT/DELETE.

## JSP/AJAX
JSP có:
```html
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
```

Category page:
```text
/categories
```
Danh sách phải được lấy qua:
```text
GET /api/category
```

CRUD Category phải qua AJAX:
- list
- create modal + FormData
- update modal + FormData
- delete AJAX

Product page:
```text
/products
```

Danh sách phải lấy qua:
```text
GET /api/product
```

CRUD Product phải qua AJAX:
- list
- create modal
- update modal
- delete AJAX

Product table tối thiểu:
```text
ID
Image
Product Name
Category
Unit Price
Discount
Quantity
Status
Actions
```

Product form:
```text
Product Name
Category select
Unit Price
Discount
Quantity
Status
Description
Image
```

Category select lấy dữ liệu thật từ API/backend, không hard-code.

## UI/UX
Clean, modern, restrained, neutral.

Không:
- gradient
- neon
- glassmorphism
- hero/banner
- dashboard cards vô nghĩa
- emoji trang trí
- animation dư
- marketing copy

Không hiển thị tech stack trên UI:
```text
Spring Boot
Java
MySQL
AJAX
jQuery
Swagger
REST API
Technology Stack
Built with
Powered by
```

Header có thể chỉ:
```text
Product Management | Categories | Products | API Docs
```

## Cấu trúc project mong muốn
```text
springboot-rest-ajax/
├── pom.xml
├── src/main/java/vn/iotstar/
│   ├── Application.java
│   ├── config/StorageProperties.java
│   ├── controller/
│   │   ├── CategoryPageController.java
│   │   ├── ProductPageController.java
│   │   └── api/
│   │       ├── CategoryAPIController.java
│   │       └── ProductAPIController.java
│   ├── entity/
│   │   ├── Category.java
│   │   └── Product.java
│   ├── model/Response.java
│   ├── repository/
│   │   ├── CategoryRepository.java
│   │   └── ProductRepository.java
│   ├── service/
│   │   ├── ICategoryService.java
│   │   ├── CategoryServiceImpl.java
│   │   ├── IProductService.java
│   │   ├── ProductServiceImpl.java
│   │   ├── IStorageService.java
│   │   └── FileSystemStorageServiceImpl.java
│   └── exception/
│       ├── StorageException.java
│       └── StorageFileNotFoundException.java
├── src/main/resources/application.properties
├── src/main/webapp/WEB-INF/views/
│   ├── common/
│   ├── categories/index.jsp
│   └── products/index.jsp
└── uploads/
```

## Definition of Done
```text
[ ] Boot 4.1.1 + Java 25
[ ] Maven BUILD SUCCESS
[ ] MySQL connection thành công
[ ] Categories + Products tables
[ ] Product → Category relation đúng
[ ] Category REST CRUD đủ
[ ] Product REST CRUD đủ
[ ] Category icon upload
[ ] Product image upload
[ ] update không file mới giữ file cũ
[ ] Swagger 3 chạy
[ ] Category AJAX CRUD đủ
[ ] Product AJAX CRUD đủ
[ ] UI clean/modern, không tech-stack text
[ ] không git commit
[ ] không git push
```
