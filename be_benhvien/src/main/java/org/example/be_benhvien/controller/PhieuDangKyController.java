package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.PhieuDangKyDAO;
import org.example.be_benhvien.DTO.PhieuDangKyDTO;
import org.example.be_benhvien.POJO.PhieuDangKy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/phieudangky")
public class PhieuDangKyController {

    @Autowired
    private PhieuDangKyDAO phieuDangKyDAO;

    @GetMapping("/all")
    public List<PhieuDangKy> getALLBacSi(){
        return phieuDangKyDAO.getAllBenhNhan();
    }

    @PostMapping("/them")
    public PhieuDangKy addPhieuDangKy(@RequestBody PhieuDangKyDTO phieuDangKy) {
        return phieuDangKyDAO.addPhieuDangKy(phieuDangKy);
    }


}
