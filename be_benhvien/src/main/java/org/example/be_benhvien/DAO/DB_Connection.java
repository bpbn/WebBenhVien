package org.example.be_benhvien.DAO;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

import java.sql.*;
public class DB_Connection {
    public Connection connect() {
        String server ="DESKTOP-QKV3AJV\\SQLEXPRESS";
        String user ="sa";
        String password ="123";
        String db = "QL_BENHVIEN";
        int port = 1433;

        SQLServerDataSource ds = new SQLServerDataSource();
        ds.setTrustServerCertificate(true);
        ds.setServerName(server);
        ds.setUser(user);
        ds.setPassword(password);
        ds.setDatabaseName(db);
        ds.setPortNumber(port);

        try {
            return ds.getConnection();
        } catch (SQLException e) {
            System.err.println("Lỗi khi kết nối đến cơ sở dữ liệu: " + e.getMessage());
            return null;
        }
    }
}