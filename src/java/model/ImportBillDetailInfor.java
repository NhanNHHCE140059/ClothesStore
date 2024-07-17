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
public class ImportBillDetailInfor {
    private int detailBill_id;
    private int bill_id;
     private String pro_name;

    private int quantity;
    private double import_price;
    private ProductSizeType size_name;
    private String color_name;
    private String imageURL;
    @Override
public String toString() {
    return "ImportBillDetailInfor{" +
            "detailBill_id=" + detailBill_id +
            ", bill_id=" + bill_id +
            ", pro_name='" + pro_name + '\'' +
            ", quantity=" + quantity +
            ", import_price=" + import_price +
            ", size_name=" + size_name +
            ", color_name='" + color_name + '\'' +
            ", imageURL='" + imageURL + '\'' +
            '}';
}

}
