/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author My Computer
 */

public class DBContext {
 

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
    private final String serverName = "localhost";
    private final String dbName = "ClothesStore";
    private final String userID = "sa";
    private final String password = "123";

    public void closeConnection(Connection con, PreparedStatement ps, ResultSet rs) throws SQLException {
        if (rs != null && !rs.isClosed()) {
            rs.close();        }
        if (ps != null && !ps.isClosed()) {
            ps.close();
        }
        if (con != null && !con.isClosed()) {
            con.close();
        }
    }
   
     public static void main(String[] args) throws Exception {
        DBContext dbContext = new DBContext();
        try {
            Connection conn = dbContext.getConnection();
            if (conn != null) {
                System.out.println("Kết nối cơ sở dữ liệu thành công!");
                conn.close(); // Đóng kết nối sau khi sử dụng
            } else {
                System.out.println("Không thể kết nối cơ sở dữ liệu.");
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi kết nối cơ sở dữ liệu: " + ex.getMessage());
        }
    }
}
