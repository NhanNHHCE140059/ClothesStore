package model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ImportBill {
    private int bill_id;
    private String create_date;
    private double total_amount;
    private String image_bill;
}
