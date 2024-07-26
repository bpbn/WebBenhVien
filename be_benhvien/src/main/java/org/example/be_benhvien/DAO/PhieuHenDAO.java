package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.PhieuHenPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class PhieuHenDAO {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public PhieuHenDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void themPhieuHen(PhieuHenPOJO phieuHenPOJO) {
        String sql = "INSERT INTO PHIEUHEN (MaPhieuHen, NgayKham, KhungGioKham, VanDeSucKhoe, TenBenhNhan, NgaySinh, GioiTinh, SDT, DiaChi) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                phieuHenPOJO.getMaPhieuHen(),
                phieuHenPOJO.getNgayKham(),
                phieuHenPOJO.getKhungGioKham(),
                phieuHenPOJO.getVanDeSucKhoe(),
                phieuHenPOJO.getTenBenhNhan(),
                phieuHenPOJO.getNgaySinh(),
                phieuHenPOJO.getGioiTinh(),
                phieuHenPOJO.getSDT(),
                phieuHenPOJO.getDiaChi());
    }
}

