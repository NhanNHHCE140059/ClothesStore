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

    private int order_detail_id;
    private int order_id;
    private int variant_id;
    private double UnitPrice;
    private int Quantity;
    private String feedback_details;

}
