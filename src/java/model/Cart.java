package model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    private int cart_id;
    private int acc_id;
    private int variant_id; 
    private int pro_quantity;
    private double pro_price;
    private double Total_price;
}
