/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import helper.OrderStatus;
import helper.ProductSizeType;
import helper.ShipStatus;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
/**
 *
 * @author HP
 */
public class OrderDetailCustomer {


    private int order_id;
    private Date orderDate;
    private OrderStatus order_status;
    private ShipStatus shipping_status;
    private int order_detail_id;  // Thêm thuộc tính này
    private String pro_name;
    private double UnitPrice;
    private int Quantity;
    private String color_name;
    private String size_name;
    private String imageURL;
    private String feedback_details;
    private String addressReceive;
    private String phone;
    @Override
    public String toString() {
        return "OrderDetailCustomer{" +
                "order_id=" + order_id +
                ", orderDate=" + orderDate +
                ", order_status=" + order_status +
                ", shipping_status=" + shipping_status +
                ", order_detail_id=" + order_detail_id +  // Cập nhật phương thức toString
                ", pro_name='" + pro_name + '\'' +
                ", UnitPrice=" + UnitPrice +
                ", Quantity=" + Quantity +
                ", color_name='" + color_name + '\'' +
                ", size_name='" + size_name + '\'' +
                ", imageURL='" + imageURL + '\'' +
                ", feedback_details='" + feedback_details + '\'' +
                ", addressReceive='" + addressReceive + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }

}
