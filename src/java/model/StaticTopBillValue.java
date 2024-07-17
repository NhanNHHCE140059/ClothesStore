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
 * @author My Computer
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class StaticTopBillValue {
    int billID;
    String username;
    double Amount;
    Date date;
}
