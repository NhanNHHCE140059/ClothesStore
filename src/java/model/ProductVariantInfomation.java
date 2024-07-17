/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import helper.ProductSizeType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author My Computer
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProductVariantInfomation {

    private int variant_id;
    private int pro_id;
    private String pro_name;
    private double pro_price;
    private String cat_name;
    private ProductSizeType size_name;
    private String description;
    private String color_name;
    private String imageURL;
}
