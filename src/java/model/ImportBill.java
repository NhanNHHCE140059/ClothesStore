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
    
    @Override
public String toString() {
    return "ImportBill{" +
            "bill_id=" + bill_id +
            ", create_date='" + create_date + '\'' +
            ", total_amount=" + total_amount +
            ", image_bill='" + image_bill + '\'' +
            '}';
}
}
