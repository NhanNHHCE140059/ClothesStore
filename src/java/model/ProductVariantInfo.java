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

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProductVariantInfo {

    int variant_id;
    int pro_id;
    String pro_name;
    Double pro_price;
    int color_id;
    String color_name;
    ProductSizeType size_id;
    String imageURL;
    int cat_id;
    String cat_name;
}
