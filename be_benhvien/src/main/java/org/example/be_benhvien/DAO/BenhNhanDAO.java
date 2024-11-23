package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.BenhNhan;
import org.example.be_benhvien.POJO.PhanQuyenTaiKhoan;
import org.example.be_benhvien.POJO.TaiKhoan;
import org.example.be_benhvien.config.BCryptEncoder;
import org.example.be_benhvien.config.JWTUtil;
import org.example.be_benhvien.repository.BenhNhanRepository;
import org.example.be_benhvien.repository.PhanQuyenTaiKhoanRepository;
import org.example.be_benhvien.repository.TaiKhoanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BenhNhanDAO {

    @Autowired
    private BenhNhanRepository benhNhanRepository;

    @Autowired
    private TaiKhoanRepository taiKhoanRepository;

    @Autowired
    private BCryptEncoder passwordEncoder;

    @Autowired
    private PhanQuyenTaiKhoanRepository phanQuyenTaiKhoanRepository;

    @Autowired
    private JWTUtil jwtUtil;

    public List<BenhNhan> getAllBenhNhan() {
        return benhNhanRepository.findAll();
    }

    public BenhNhan getBenhNhanTheoId(String maBenhNhan){
        return benhNhanRepository.findById(maBenhNhan).orElse(null);
    }

    public BenhNhan getBNTheoTenTK(String tenTaiKhoan){
        return benhNhanRepository.findByTenTaiKhoan(tenTaiKhoan);
    }

    private String generateMaBenhNhan() {
        String maxMaBenhNhan = benhNhanRepository.findMaxMaBenhNhan();
        if (maxMaBenhNhan == null) {
            return "BN0001";
        }

        int numericPart = Integer.parseInt(maxMaBenhNhan.substring(2)) + 1;
        return String.format("BN%04d", numericPart);
    }

    private Optional<TaiKhoan> checkIfAccountExists(String tenTaiKhoan) {
        return taiKhoanRepository.findByTenTaiKhoan(tenTaiKhoan);
    }

    public ResponseEntity<String> registerBenhNhan(BenhNhan benhNhan) {
        TaiKhoan taiKhoan = benhNhan.getTaiKhoan();

        if (checkIfAccountExists(taiKhoan.getTenTaiKhoan()).isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Tài khoản đã tồn tại");
        }

        String hashedPassword = passwordEncoder.encode(taiKhoan.getMatKhau());
        taiKhoan.setMatKhau(hashedPassword);

        benhNhan.setMaBenhNhan(generateMaBenhNhan());

        taiKhoanRepository.save(taiKhoan);
        benhNhanRepository.save(benhNhan);

        PhanQuyenTaiKhoan phanQuyenTaiKhoan = new PhanQuyenTaiKhoan();
        phanQuyenTaiKhoan.setTenTaiKhoan(taiKhoan.getTenTaiKhoan());
        phanQuyenTaiKhoan.setMaQuyen("PATIENT");

        phanQuyenTaiKhoanRepository.save(phanQuyenTaiKhoan);

        return ResponseEntity.status(HttpStatus.CREATED).body("{\"message\": \"Đăng ký thành công\"}");

    }

    public BenhNhan updateBenhNhan(String maBenhNhan, BenhNhan benhNhanDetails) {
        Optional<BenhNhan> optionalBenhNhan = benhNhanRepository.findById(maBenhNhan);

        if (optionalBenhNhan.isPresent()) {
            BenhNhan existingBenhNhan = optionalBenhNhan.get();
            existingBenhNhan.setHoTen(benhNhanDetails.getHoTen());
            existingBenhNhan.setNamSinh(benhNhanDetails.getNamSinh());
            existingBenhNhan.setGioiTinh(benhNhanDetails.getGioiTinh());
            existingBenhNhan.setDiaChi(benhNhanDetails.getDiaChi());
            existingBenhNhan.setDienThoai(benhNhanDetails.getDienThoai());

            return benhNhanRepository.save(existingBenhNhan);
        } else {
            throw new RuntimeException("Bệnh nhân không tồn tại với mã: " + maBenhNhan);
        }
    }

}
