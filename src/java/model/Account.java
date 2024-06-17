package model;

import helper.AccountStatus;
import helper.Role;
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
public class Account {

    private int acc_id;
    private String username;
    private String name;
    private String image;
    private String email;
    private String phone;
    private String address;
    private String password;
    private Role role;
    private AccountStatus acc_status;

}
