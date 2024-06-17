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

/**
 *
 * @author Huenh
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private int order_id;
    private String feedback_order;
    private Date orderDate;
    private String addressReceive;
    private String phone;
    private String username;
    private double totalPrice;
    private OrderStatus order_status;
    private PayStatus pay_status;
    private ShipStatus ship_status;
}
