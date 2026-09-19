package lyvomyhoa.springboot_rest_ajax.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Response {
    private Boolean status;
    private String message;
    private Object body;
}
