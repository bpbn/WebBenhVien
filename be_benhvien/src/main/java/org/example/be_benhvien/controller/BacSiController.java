package org.example.be_benhvien.controller;

import ch.qos.logback.core.model.Model;
import org.example.be_benhvien.DAO.BacSiDAO;
import org.example.be_benhvien.POJO.BacSiPOJO;
import org.example.be_benhvien.POJO.DanhHieuPOJO;
import org.jetbrains.annotations.ApiStatus;
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

    @GetMapping("/hocvi/{id}")
    public ResponseEntity dsHVcuaBS(@PathVariable String id) {
        List<BacSiPOJO.HocVi> dsHocVi = bacSiDAO.layDanhSachHocViCuaBacSi(id);
        return new ResponseEntity<>(dsHocVi, HttpStatus.OK);
    }

    @GetMapping("/danhsachdh")
    public ResponseEntity dsDH(Model model) {
        List<DanhHieuPOJO> danhSachDanhHieu = bacSiDAO.layDanhSachDanhHieu();
        return new ResponseEntity<>(danhSachDanhHieu, HttpStatus.OK);
    }


    @GetMapping("/tongGSvaPGS")
    public ResponseEntity<Integer> tongGSvaPGS(Model model) {
        Integer sum = bacSiDAO.tinhTongBacSiLaGS_PGS();
        return new ResponseEntity<>(sum, HttpStatus.OK);
    }

    @GetMapping("/tongTS")
    public ResponseEntity<Integer> tongTS(Model model) {
        Integer sum = bacSiDAO.tinhTongTienSi();
        return new ResponseEntity<>(sum, HttpStatus.OK);
    }

    @GetMapping("/tongThS")
    public ResponseEntity<Integer> tongThS(Model model) {
        Integer sum = bacSiDAO.tinhTongThacSi();
        return new ResponseEntity<>(sum, HttpStatus.OK);
    }

    @GetMapping("/tongBS")
    public ResponseEntity<Integer> tongBS(Model model) {
        Integer sum = bacSiDAO.tinhTongBacSi();
        return new ResponseEntity<>(sum, HttpStatus.OK);
    }

    @GetMapping("/danhsachhv")
    public ResponseEntity dsHV(Model model) {
        List<BacSiPOJO.HocVi> danhSachHocVi = bacSiDAO.layDanhSachHocVi();
        return new ResponseEntity<>(danhSachHocVi, HttpStatus.OK);
    }

    @GetMapping("/danhsachhh")
    public ResponseEntity dsHH(Model model) {
        List<String> danhSachHocHam = bacSiDAO.layDanhSachHocHam();
        return new ResponseEntity<>(danhSachHocHam, HttpStatus.OK);
    }

    @GetMapping("/danhsachcv")
    public ResponseEntity dsCV(Model model) {
        List<String> danhSachChucVu = bacSiDAO.layDanhSachChucVu();
        return new ResponseEntity<>(danhSachChucVu, HttpStatus.OK);
    }

}
