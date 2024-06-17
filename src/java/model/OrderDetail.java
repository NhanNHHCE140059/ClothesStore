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
public class OrderDetail {

    private int order_id;
    private int pro_id;
    private double UnitPrice;
    private int Quantity;

}
