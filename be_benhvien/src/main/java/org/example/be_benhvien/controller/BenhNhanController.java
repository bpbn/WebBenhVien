package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.BenhNhanDAO;
import org.example.be_benhvien.POJO.BenhNhan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/benhnhan")
public class BenhNhanController {

    @Autowired
    private BenhNhanDAO benhNhanDAO;

    @GetMapping("/allbenhnhan")
    public List<BenhNhan> getALLBenhNhan(){
        return benhNhanDAO.getAllBenhNhan();
    }

    @GetMapping("/timbntheoma/{maBenhNhan}")
    public BenhNhan getBenhNhanTheoMa(@PathVariable String maBenhNhan) {
        return benhNhanDAO.getBenhNhanTheoId(maBenhNhan);
    }

    @PutMapping("/update/{maBenhNhan}")
    public ResponseEntity<BenhNhan> updateBenhNhan(@PathVariable String maBenhNhan, @RequestBody BenhNhan benhNhanDetails) {
        BenhNhan updatedBenhNhan = benhNhanDAO.updateBenhNhan(maBenhNhan, benhNhanDetails);
        return ResponseEntity.ok(updatedBenhNhan);
    }

    @GetMapping("/timbntheotentk/{tenTaiKhoan}")
    public ResponseEntity<BenhNhan> getBenhNhanByTenTaiKhoan(@PathVariable String tenTaiKhoan) {
        BenhNhan benhNhan = benhNhanDAO.getBNTheoTenTK(tenTaiKhoan);
        if (benhNhan != null) {
            return ResponseEntity.ok(benhNhan);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}