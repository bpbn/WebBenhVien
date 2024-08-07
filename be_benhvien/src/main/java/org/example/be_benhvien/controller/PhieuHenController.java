package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.LichLamViecDAO;
import org.example.be_benhvien.DAO.PhieuHenDAO;
import org.example.be_benhvien.POJO.LichLamViecPOJO;
import org.example.be_benhvien.POJO.PhieuHenPOJO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/phieuhen")
public class PhieuHenController {

    private static final Logger logger = LoggerFactory.getLogger(PhieuHenController.class);
    private final PhieuHenDAO phieuHenDAO;

    @Autowired
    public PhieuHenController(PhieuHenDAO phieuHenDAO, LichLamViecDAO lichLamViecDAO) {
        this.phieuHenDAO = phieuHenDAO;
        this.lichLamViecDAO = lichLamViecDAO;
    }

    @PostMapping("/themPH")
    public ResponseEntity<?> themPhieuHen(@RequestBody PhieuHenPOJO phieuHenPOJO) {
        try {
            logger.info("Nhận được yêu cầu thêm phiếu hẹn: {}", phieuHenPOJO);
            phieuHenDAO.themPhieuHen(phieuHenPOJO);
            return new ResponseEntity<>("Phiếu hẹn đã được thêm thành công!", HttpStatus.CREATED);
        } catch (Exception e) {
            logger.error("Lỗi khi thêm phiếu hẹn: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "Lỗi khi thêm phiếu hẹn: " + e.getMessage()));
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

    @GetMapping("/ngaylamvieccuabs")
    public ResponseEntity<List<LichLamViecPOJO>> layNgayVaCaTheoMaNhanVien(
            @RequestParam String maNhanVien) {
        List<LichLamViecPOJO> danhSachNgayVaCa = lichLamViecDAO.layNgayLamViecTheoMaNhanVien(maNhanVien);
        return new ResponseEntity<>(danhSachNgayVaCa, HttpStatus.OK);
    }

    @GetMapping("/caLamViec")
    public ResponseEntity layCaLamTheoNgayCuaBacSi(@RequestParam String maNhanVien, @RequestParam String ngayLam) {
        List<String> gt = lichLamViecDAO.layCaLamTheoNgayCuaBacSi(maNhanVien, ngayLam);
        return new ResponseEntity<>(gt, HttpStatus.OK);
    }
}
