package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.BenhNhanDAO;
import org.example.be_benhvien.DAO.TaiKhoanDAO;
import org.example.be_benhvien.DTO.LoginRequest;
import org.example.be_benhvien.POJO.BenhNhan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/taikhoan")
public class TaiKhoanController {

    @Autowired
    private TaiKhoanDAO taiKhoanDAO;

    @Autowired
    private BenhNhanDAO benhNhanDAO;

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequest loginRequest) {
        return taiKhoanDAO.login(loginRequest);
    }


    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody BenhNhan benhNhan) {
        return benhNhanDAO.registerBenhNhan(benhNhan);
    }

}
