package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.PhieuHenDAO;
import org.example.be_benhvien.POJO.PhieuHenPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;

@RestController
@RequestMapping("/phieuhen")
public class PhieuHenController {

    private final PhieuHenDAO phieuHenDAO;

    @Autowired
    public PhieuHenController(PhieuHenDAO phieuHenDAO) {
        this.phieuHenDAO = phieuHenDAO;
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
}
