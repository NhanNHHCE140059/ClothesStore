package service;

import model.Account;
import db.DBContext;
import helper.AccountStatus;
import helper.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import misc.Hash;

/**
 *
 * @author Huenh
 */
public class AccountService {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DBContext dbcontext = new DBContext();
    Hash hash = new Hash();

    //chuyen role tu db sang java
    public Role mapRole(int roleValue) {
        switch (roleValue) {
            case 0:
                return Role.Admin;
            case 1:
                return Role.Customer;
            case 2:
                return Role.Staff;
            default:
                throw new IllegalArgumentException("Unknown role value: " + roleValue);
        }
    }

    // Chuyen status tu db sang java
    public AccountStatus getStatusAccount(int status) {
        switch (status) {
            case 0:
                return AccountStatus.ACTIVATE;
            case 1:
                return AccountStatus.DEACTIVATE;
            default:
                throw new IllegalArgumentException("Unknown role value: " + status);
        }
    }

    // Lay account ra tu Username
    public Account getAccountByUsername(String username) {
        Account account = null;
        try {
            String query = "select * from accounts where username=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                account = new Account(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        mapRole(rs.getInt(9)),
                        getStatusAccount(rs.getInt(10))
                );
            }
            return account;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
        return account;
    }
//    //update info account "Fullname","Address","Email","Number Phone"
//

    public void updateInfoAccountUser(String fullName, String address, String emailAddress, String numberPhone, String username) {
        try {
            String query = "UPDATE accounts SET email = ?, phone= ?, name = ?,address=? WHERE username = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            ps.setString(2, numberPhone);
            ps.setString(3, fullName);
            ps.setString(4, address);
            ps.setString(5, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
    }

    public void updateImageUser(String img, String username) {
        try {
            String query = "UPDATE accounts SET image= ? WHERE username = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, img);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
    }

    //thay doi mat khau User
    public void changePasswordUser(String username, String password) {
        try {
            String query = "UPDATE accounts SET password =? WHERE username = ?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, password);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL error occurred while fetching account.");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("An unexpected error occurred.");
        }
    }

//    //Check matching Password and rePassword
    public boolean isPasswordMatching(String password, String rePassword) {
        if (password == null || rePassword == null) {
            return false;
        }
        return password.equals(rePassword);
    }
//    // Regex to check for valid full name (letters and spaces only)

    // Check login 
    public Account getAccount(String username, String hashPassword) {
        Account account = null;
        try {
            String query = "select * from [Accounts] where username=? and password=?";
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, hashPassword);
            rs = ps.executeQuery();
            while (rs.next()) {
                account = new Account(
                        rs.getInt("acc_id"),
                        rs.getString("username"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("password"),
                        Role.values()[rs.getInt("role")],
                        AccountStatus.values()[rs.getInt("acc_status")]);

            }
            return account;
        } catch (Exception e) {
            System.out.println("Loi get account");
            System.out.println(e);
        }
        return null;
    }

    public boolean isValidFullName(String fullName) {
        String regex = "^[a-zA-Z\\s]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(fullName);
        return matcher.matches();
    }
    
    //for register
    public void createAccount(String username, String name, String email, 
                                     String phoneNumber, String password, String address) {
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement("insert into [Accounts](username, name, "
                    + "email, phone, password, address, role, acc_status) values(?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phoneNumber);
            ps.setString(5, password);
            ps.setString(6, address);
            ps.setInt(7, 1); // Role => 1 == Customer
            ps.setInt(8, 0); // Account Status => 0 == Active
            ps.executeUpdate();
        } catch (Exception ex) {
            System.out.println("Loi create account");
            System.out.println(ex);
        }
    }
    
    // Return true if a username already existed
    public boolean exists(String username)  {
        try {
            connection = dbcontext.getConnection();
            ps = connection.prepareStatement("select * from [Accounts] where username=?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println("Error! user exists");
        }
        return false;
    }
    
}
