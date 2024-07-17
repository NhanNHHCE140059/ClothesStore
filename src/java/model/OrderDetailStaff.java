/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import helper.OrderStatus;
import helper.PayStatus;
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
public class OrderDetailStaff {
     private int order_id;
    private Date orderDate;
   
    private OrderStatus order_status;
    private PayStatus pay_status;
    private ShipStatus shipping_status;
    private String pro_name;
    private double UnitPrice;
    private int Quantity;
    private String color_name;
    private String size_name;
    private String imageURL;
    private String username;
    private int acc_id;
    private String feedback_details;
    private String feedback_order;
        private String addressReceive;
    private String phone;
@Override
    public String toString() {
        return "OrderDetailStaff{" +
                "order_id=" + order_id +
                ", orderDate=" + orderDate +
                ", order_status=" + order_status +
                ", pay_status=" + pay_status +
                ", shipping_status=" + shipping_status +
                ", pro_name='" + pro_name + '\'' +
                ", UnitPrice=" + UnitPrice +
                ", Quantity=" + Quantity +
                ", color_name='" + color_name + '\'' +
                ", size_name='" + size_name + '\'' +
                ", imageURL='" + imageURL + '\'' +
                ", username='" + username + '\'' +
                ", acc_id=" + acc_id +
                ", feedback_details='" + feedback_details + '\'' +
                ", feedback_order='" + feedback_order + '\'' +
                ", phone='" + phone + '\'' +
                ", addressReceive='" + addressReceive + '\'' +
                '}';
    }
}
