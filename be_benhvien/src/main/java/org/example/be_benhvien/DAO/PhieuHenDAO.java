package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.BacSiPOJO;
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
        System.out.println("Dữ liệu nhận được: " + phieuHenPOJO);
        String newMaPhieuHen = generateNewMaPhieuHen();
        phieuHenPOJO.setMaPhieuHen(newMaPhieuHen);

        String sql = "INSERT INTO PHIEUHEN (MaPhieuHen, NgayKham, KhungGioKham, MaNhanVien, VanDeSucKhoe, TenBenhNhan, NgaySinh, GioiTinh, SDT, DiaChi) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                phieuHenPOJO.getMaPhieuHen(),
                phieuHenPOJO.getNgayKham(),
                phieuHenPOJO.getKhungGioKham(),
                phieuHenPOJO.getBacSi(),
                phieuHenPOJO.getVanDeSucKhoe(),
                phieuHenPOJO.getTenBenhNhan(),
                phieuHenPOJO.getNgaySinh(),
                phieuHenPOJO.getGioiTinh(),
                phieuHenPOJO.getSDT(),
                phieuHenPOJO.getDiaChi());
    }


    private String generateNewMaPhieuHen() {
        String sql = "SELECT MAX(MaPhieuHen) FROM PHIEUHEN";
        String maxMaPhieuHen = jdbcTemplate.queryForObject(sql, String.class);

        if (maxMaPhieuHen == null) {
            return "PH0000";
        }

        int numericPart = Integer.parseInt(maxMaPhieuHen.substring(2));

        int newNumericPart = numericPart + 1;

        return String.format("PH%04d", newNumericPart);
    }
}