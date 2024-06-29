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
public class ProductsVariant {
    private int variant_id;
    private int pro_id;
    private ProductSizeType size_name;
    private int color_id;
    private int image_id;
}
