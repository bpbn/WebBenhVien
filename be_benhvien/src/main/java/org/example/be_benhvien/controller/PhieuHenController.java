package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.LichLamViecDAO;
import org.example.be_benhvien.DAO.PhieuHenDAO;
import org.example.be_benhvien.POJO.LichLamViecPOJO;
import org.example.be_benhvien.POJO.PhieuHenPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/phieuhen")
public class PhieuHenController {

    private final PhieuHenDAO phieuHenDAO;

    @Autowired
    public PhieuHenController(PhieuHenDAO phieuHenDAO, LichLamViecDAO lichLamViecDAO) {
        this.phieuHenDAO = phieuHenDAO;
        this.lichLamViecDAO = lichLamViecDAO;
    }

    @PostMapping("/themPH")
    public ResponseEntity<String> themPhieuHen(@RequestBody PhieuHenPOJO phieuHenPOJO) {
        try {
            phieuHenDAO.themPhieuHen(phieuHenPOJO);
            return new ResponseEntity<>("Phiếu hẹn đã được thêm thành công!", HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>("Lỗi khi thêm phiếu hẹn: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private final LichLamViecDAO lichLamViecDAO;

    @GetMapping("/bstheongaylam")
    public ResponseEntity<List<LichLamViecPOJO>> layBacSiTheoNgayVaCa(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate ngayLam,
            @RequestParam String caLam) {
        if ("morning".equals(caLam)) {
            caLam = "Sáng";
        } else if ("afternoon".equals(caLam)) {
            caLam = "Chiều";
        }
        List<LichLamViecPOJO> danhSachBacSi = lichLamViecDAO.layBacSiTheoNgayLamVaCaLam(ngayLam, caLam);
        return new ResponseEntity<>(danhSachBacSi, HttpStatus.OK);
    }

    @GetMapping("/ngaylamvieccuabs/{maNhanVien}")
    public ResponseEntity<List<LichLamViecPOJO>> layNgayVaCaTheoMaNhanVien(
            @PathVariable String maNhanVien) {
        List<LichLamViecPOJO> danhSachNgayVaCa = lichLamViecDAO.layNgayLamViecTheoMaNhanVien(maNhanVien);
        return new ResponseEntity<>(danhSachNgayVaCa, HttpStatus.OK);
    }
}
