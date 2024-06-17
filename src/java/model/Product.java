/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import helper.CategoryType;
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
public class Product {
    private int pro_id;
    private String pro_name;
    private double pro_price;
    private String imageURL;
    private String description;
    private String cat_name;

}
