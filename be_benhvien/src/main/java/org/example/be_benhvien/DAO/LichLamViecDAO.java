package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.BacSiPOJO;
import org.example.be_benhvien.POJO.LichLamViecPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Repository
public class LichLamViecDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<LichLamViecPOJO> layBacSiTheoNgayLamVaCaLam(LocalDate ngayLam, String caLam) {
        String sql = "SELECT L.CALAM, L.NGAYLAM, N.TENNHANVIEN " +
                "FROM LICHLAMVIEC L " +
                "JOIN NHANVIEN N ON L.MANHANVIEN = N.MANHANVIEN " +
                "WHERE L.NGAYLAM = ? AND L.CALAM = ?";
        return jdbcTemplate.query(sql, new Object[]{ngayLam, caLam}, (rs, rowNum) -> {
            LichLamViecPOJO lichLamViecPOJO = new LichLamViecPOJO();
            BacSiPOJO bacSiPOJO = new BacSiPOJO();

            lichLamViecPOJO.setCaLam(rs.getString("CALAM"));
            lichLamViecPOJO.setNgayLam(rs.getDate("NGAYLAM").toLocalDate());

            bacSiPOJO.setTenNhanVien(rs.getString("TENNHANVIEN"));
            lichLamViecPOJO.setBacSi(bacSiPOJO);

            return lichLamViecPOJO;
        });
    }

    public List<LichLamViecPOJO> layNgayLamViecTheoMaNhanVien(String maNhanVien) {
        String sql = "SELECT NGAYLAM, CALAM " +
                "FROM LICHLAMVIEC " +
                "WHERE MANHANVIEN = ?";
        return jdbcTemplate.query(sql, new Object[]{maNhanVien}, (rs, rowNum) -> {
            LichLamViecPOJO lichLamViecPOJO = new LichLamViecPOJO();

            lichLamViecPOJO.setNgayLam(rs.getDate("NGAYLAM").toLocalDate());
            lichLamViecPOJO.setCaLam(rs.getString("CALAM"));

            return lichLamViecPOJO;
        });
    }

}
