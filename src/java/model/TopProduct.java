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
public class TopProduct {

    String imageURL;
    String name;
    String color_name;
    ProductSizeType size_name;
    double price;
    double quantity;
}
