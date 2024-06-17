/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

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
public class Bill {
      private int bill_id;
    private Date create_date;
    private double total_amount;
    private String pro_name;
    private double import_price;
    private int quantity;
    private String image_bill;
    private int pro_id;
    
}
