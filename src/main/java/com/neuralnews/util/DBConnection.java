package com.neuralnews.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class to provide a JDBC connection to the MySQL database.
 * 
 * ⚠️ Requires mysql-connector-j-*.jar in WEB-INF/lib
 * 
 * To configure: change DB_URL, DB_USER, DB_PASSWORD below.
 */
public class DBConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/neuralnews";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456789"; // đổi nếu MySQL của bạn có mật khẩu

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                    "MySQL JDBC Driver không tìm thấy! Hãy thêm mysql-connector-j.jar vào WEB-INF/lib", e);
        }
    }

    /**
     * Trả về một Connection mới tới database.
     * Caller có trách nhiệm đóng Connection sau khi dùng xong.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
