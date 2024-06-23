/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author Nguyen Thanh Thien - CE171253
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    private int cart_id;
    private int acc_id;
    private int pro_id;
    private String pro_name;
    private int pro_quantity;
    private double pro_price;
    private double Total_price;
}
