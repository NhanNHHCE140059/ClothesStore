package model;



import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author Huenh
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CartInfo {

    private int cart_id;
    private int variant_id;
    private int pro_quantity;
    private double pro_price;
    private double total_price;
    private String color_name;
    private int size_id;
    private String pro_name;
    private String imageURL;
}
