package org.example.be_benhvien.controller;

import ch.qos.logback.core.model.Model;
import org.example.be_benhvien.DAO.BacSiDAO;
import org.example.be_benhvien.POJO.BacSiPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;

@RestController
@RequestMapping("/bacsi")
public class BacSiController {
    @Autowired
    private BacSiDAO bacSiDAO;

    @GetMapping("/danhsach")
    public ResponseEntity danhsachBacSi(Model model) throws SQLException {
        List<BacSiPOJO> danhSachBacSi = bacSiDAO.layDanhSachBacSi();
        return new ResponseEntity<>(danhSachBacSi, HttpStatus.OK);
    }
}
