package org.example.be_benhvien.controller;

import ch.qos.logback.core.model.Model;
import org.example.be_benhvien.DAO.BacSiDAO;
import org.example.be_benhvien.POJO.BacSiPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;

@RestController
@RequestMapping("/bacsi")
public class BacSiController {
    @Autowired
    private BacSiDAO bacSiDAO;

    @GetMapping("/danhsachbs")
    public ResponseEntity dsBS(Model model) {
        List<BacSiPOJO> danhSachBacSi = bacSiDAO.layDanhSachBacSi();
        return new ResponseEntity<>(danhSachBacSi, HttpStatus.OK);
    }

    @GetMapping("/danhsachhv")
    public ResponseEntity dsHV(Model model) {
        List<BacSiPOJO.HocVi> danhSachHocVi = bacSiDAO.layDanhSachHocVi();
        return new ResponseEntity<>(danhSachHocVi, HttpStatus.OK);
    }

    @GetMapping("/hocvi/{id}")
    public ResponseEntity dsHVcuaBS(@PathVariable String id) {
        List<BacSiPOJO.HocVi> dsHocVi = bacSiDAO.layDanhSachHocViCuaBacSi(id);
        return new ResponseEntity<>(dsHocVi, HttpStatus.OK);
    }

    @GetMapping("/danhhieu/{id}")
    public ResponseEntity<String> dhBS(@PathVariable String id) {
        String danhHieu = bacSiDAO.taoDanhHieuBS(id);
        return new ResponseEntity<>(danhHieu, HttpStatus.OK);
    }

}
