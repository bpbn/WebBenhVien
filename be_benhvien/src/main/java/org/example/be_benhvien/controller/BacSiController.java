package org.example.be_benhvien.controller;

import ch.qos.logback.core.model.Model;
import org.example.be_benhvien.DAO.BacSiDAO;
import org.example.be_benhvien.DAO.LichLamViecDAO;
import org.example.be_benhvien.POJO.BacSiPOJO;
import org.example.be_benhvien.POJO.DanhHieuPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/bacsi")
public class BacSiController {
    @Autowired
    private BacSiDAO bacSiDAO;
    @Autowired
    private LichLamViecDAO lichLamViecDAO;

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

    @GetMapping("/timbstheoma/{id}")
    public ResponseEntity timBSTheoMa(@PathVariable String id) {
        BacSiPOJO bs = bacSiDAO.timBacSiTheoMa(id);
        return new ResponseEntity<>(bs, HttpStatus.OK);
    }

    @GetMapping("/kiemTraHVCuaBS/{id}/{hocvi}")
    public ResponseEntity kiemTraHVCuaBS(@PathVariable String id, @PathVariable String hocvi) {
        Integer kt = bacSiDAO.kiemTraTonTaiHocViCuaBacSi(id, hocvi);
        return new ResponseEntity<>(kt, HttpStatus.OK);
    }

    @GetMapping("/ttGioiThieu/{id}")
    public ResponseEntity layThongTinGioiThieu(@PathVariable String id) {
        List<String> gt = bacSiDAO.layThongTinGioiThieu(id);
        return new ResponseEntity<>(gt, HttpStatus.OK);
    }

    @GetMapping("/ngayLamViec/{id}")
    public ResponseEntity layNgayLamViecCuaBacSi(@PathVariable String id) {
        List<String> gt = lichLamViecDAO.layNgayLamViecCuaBacSi(id);
        return new ResponseEntity<>(gt, HttpStatus.OK);
    }

    @GetMapping("/ngayLamViecTrongThang/{id}")
    public ResponseEntity layNgayLamViecCuaBacSiTrongThang(@PathVariable String id) {
        Object gt = lichLamViecDAO.layNgayLamViecCuaBacSiTrongThang(id);
        return new ResponseEntity<>(gt, HttpStatus.OK);
    }

    @GetMapping("/caLamViec/{id}/{date}")
    public ResponseEntity layCaLamTheoNgayCuaBacSi(@PathVariable String id, @PathVariable String date) {
        List<String> gt = lichLamViecDAO.layCaLamTheoNgayCuaBacSi(id, date);
        return new ResponseEntity<>(gt, HttpStatus.OK);
    }

    @GetMapping("/tachNgayTheoTuan/{i}")
    public ResponseEntity tachNgayTheoTuan(@PathVariable int i) {
        List<Integer> dates = lichLamViecDAO.tachNgayTheoTuan(i);
        return new ResponseEntity<>(dates, HttpStatus.OK);
    }

}
