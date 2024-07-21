package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.BacSiPOJO;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Repository
public class BacSiDAO {
    public static ArrayList<BacSiPOJO> layDanhSachBacSi(){
        ArrayList<BacSiPOJO> ds = new ArrayList<BacSiPOJO>();
        try {
            String sql = "select * from BacSi";
            DB_Connection dbConnection = new DB_Connection();
            Connection connection = dbConnection.connect();
            Statement statement = connection.createStatement();

            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                BacSiPOJO bacSi = new BacSiPOJO();

                bacSi.setMaBacSi(resultSet.getString("MABACSI"));
                bacSi.setTenBacSi(resultSet.getString("TENBACSI"));
                bacSi.setChucVu(resultSet.getString("CHUCVU"));
                bacSi.setHocHam(resultSet.getString("HOCHAM"));
                bacSi.setGioiThieu(resultSet.getString("GIOITHIEU"));
                bacSi.setHinhAnh(resultSet.getString("HINHANH"));
                bacSi.setGioiTinh(resultSet.getString("GIOITINH"));

                String sql2 = "SELECT * FROM HOCVI WHERE MAHOCVI IN (SELECT MAHOCVI FROM CHITIETHOCVI WHERE MABACSI = 'BS0001')";
                ResultSet resultSet2 = statement.executeQuery(sql2);
                while (resultSet2.next()) {
                    BacSiPOJO.HocVi hocVi = new BacSiPOJO.HocVi();

                    hocVi.setMaHocVi(resultSet2.getString("MAHOCVI"));
                    hocVi.setTenHocVi(resultSet.getString("TENHOCVI"));

                    bacSi.addHocVi(hocVi);
                }
                ds.add(bacSi);
            }
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

//    public static void main(String[] args) throws SQLException {
//        ArrayList<BacSiPOJO> danhSachBacSi = layDanhSachBacSi();
//    }
}

