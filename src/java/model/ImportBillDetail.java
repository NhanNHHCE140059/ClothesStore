package model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ImportBillDetail {
    private int detailBill_id;
    private int bill_id;
    private int variant_id;
    private int quantity;
    private double import_price;
}
