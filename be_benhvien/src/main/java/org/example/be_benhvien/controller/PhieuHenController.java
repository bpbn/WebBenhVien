package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.PhieuHenDAO;
import org.example.be_benhvien.POJO.PhieuHenPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
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
    public void themPhieuHen(@RequestBody PhieuHenPOJO phieuHenPOJO) {
        phieuHenDAO.themPhieuHen(phieuHenPOJO);
    }
}
