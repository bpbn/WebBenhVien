package org.example.be_benhvien.controller;

import org.example.be_benhvien.DAO.BacSiDAO;
import org.example.be_benhvien.POJO.BacSi;
import org.example.be_benhvien.POJO.ChuyenKhoa;
import org.example.be_benhvien.POJO.HocVi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/bacsi")
public class BacSiController {

    @Autowired
    private BacSiDAO bacSiDAO;

    @GetMapping("/all")
    public List<BacSi> getALLBacSi(){
        return bacSiDAO.getAllBacSi();
    }

    // Lấy thông tin bác sĩ theo mã
    @GetMapping("/timbstheoma/{maBacSi}")
    public BacSi getBacSiById(@PathVariable String maBacSi) {
        return bacSiDAO.getBacSiById(maBacSi);
    }

    //Lấy bác sĩ theo chuyên khoa
    @GetMapping("/bstheochuyenkhoa/{maChuyenKhoa}")
    public List<BacSi> getBacSiByChuyenKhoa(@PathVariable String maChuyenKhoa) {
        return bacSiDAO.getBacSiByChuyenKhoa(maChuyenKhoa);
    }

    // Lấy danh sách học vị
    @GetMapping("/dshocvi")
    public List<HocVi> getAllHocVi() {
        return bacSiDAO.getAllHocVi();
    }

    // Lấy danh sách học hàm
    @GetMapping("/dshocham")
    public List<String> getAllHocHam() {
        return bacSiDAO.getAllHocHam();
    }

    // Lấy danh sách chuyên khoa
    @GetMapping("/dschuyenkhoa")
    public List<ChuyenKhoa> getAllChuyenKhoa() {
        return bacSiDAO.getAllChuyenKhoa();
    }

    // Lấy tổng số bác sĩ
    @GetMapping("/tong-bs")
    public long layTongSoBacSi() {
        return bacSiDAO.layTongSoBacSi();
    }

    // Lấy tổng số bác sĩ có học hàm
    @GetMapping("/tong-gs-pgs")
    public long layTongSoBacSiCoHocHam() {
        return bacSiDAO.layTongSoBacSiCoHocHam();
    }

    // Lấy tổng số bác sĩ có học vị Tiến sĩ
    @GetMapping("/tong-ts")
    public long layTongSoBacSiCoHocViTS() {
        return bacSiDAO.layTongSoBacSiCoHocViTS();
    }

    // Lấy tổng số bác sĩ có học vị Thạc sĩ
    @GetMapping("/tong-ths")
    public long layTongSoBacSiCoHocViTHS() {
        return bacSiDAO.layTongSoBacSiCoHocViTHS();
    }

    // Lấy danh sách học vị đã sắp xếp theo bậc của bác sĩ
    @GetMapping("/hocvi/{maBacSi}")
    public List<String> layHocViSapXep(@PathVariable String maBacSi) {
        return bacSiDAO.layHocViSapXepTheoBac(maBacSi);
    }

    @GetMapping("/kiemTraHVCuaBS/{id}/{hocvi}")
    public long kiemTraHVCuaBS(@PathVariable String id, @PathVariable String hocvi) {
        return bacSiDAO.kiemTraTonTaiHocViCuaBacSi(id, hocvi);
    }
}
