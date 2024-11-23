package org.example.be_benhvien.DAO;

import org.example.be_benhvien.DTO.PhieuDangKyDTO;
import org.example.be_benhvien.POJO.LichLamViec;
import org.example.be_benhvien.POJO.PhieuDangKy;
import org.example.be_benhvien.repository.LichLamViecRepository;
import org.example.be_benhvien.repository.PhieuDangKyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Service
public class PhieuDangKyDAO {
    @Autowired
    private PhieuDangKyRepository phieuDangKyRepository;
    @Autowired
    private LichLamViecRepository lichLamViecRepository;
    @Autowired
    private LichLamViecDAO lichLamViecDAO;

    public List<PhieuDangKy> getAllBenhNhan() {
        return phieuDangKyRepository.findAll();
    }

    public String generateMaPDK() {
        String prefix = "PDK";
        String lastMaPDK = phieuDangKyRepository.findMaxMaPhieuDangKy();

        if (lastMaPDK == null) {
            return prefix + "0000"; // Nếu chưa có mã nào, trả về PDK0000
        }

        // Lấy phần số từ mã PDK hiện tại
        int currentNumber = Integer.parseInt(lastMaPDK.substring(3));
        // Tăng số lên 1
        int newNumber = currentNumber + 1;
        // Định dạng thành chuỗi với 4 chữ số
        return prefix + String.format("%04d", newNumber);
    }

    public String timLichLamViec(String maBacSi, LocalDate ngayLam) {
        LichLamViec lichLamViec = lichLamViecRepository.findByBacSi_MaBacSiAndNgayLam(maBacSi, ngayLam);
        if (lichLamViec != null) {
            return lichLamViec.getMaLich();
        } else {
            return "Lich lam viec khong tim thay";
        }
    }


    public PhieuDangKy addPhieuDangKy(PhieuDangKyDTO phieuDangKyDTO) {
        PhieuDangKy phieuDangKy = new PhieuDangKy();


        String maBacSi = phieuDangKyDTO.getMaBacSi();
        LocalDate ngayKham = phieuDangKyDTO.getNgayKham();

        String maLich = timLichLamViec(maBacSi, ngayKham);
//        System.out.println(ngayKham);
//        System.out.println(maLich);

        LichLamViec lichLamViec = lichLamViecRepository.findById(maLich).orElse(null);
        if (lichLamViec == null) {
            throw new RuntimeException("Lịch làm việc không tồn tại.");
        }
        phieuDangKy.setLichLamViec(lichLamViec.getMaLich());

        phieuDangKy.setMaPhieuDangKy(generateMaPDK());
        phieuDangKy.setNgayLap(new Date());
        phieuDangKy.setHinhThucDangKy("Trực tuyến");
        phieuDangKy.setTrangThaiThanhToan("Chưa thanh toán");
        phieuDangKy.setMaBHYT(phieuDangKyDTO.getMaBHYT());
        phieuDangKy.setMaBenhNhan(phieuDangKyDTO.getMaBenhNhan());
        phieuDangKy.setTinhTrangSucKhoe(phieuDangKyDTO.getTinhTrangSucKhoe());

        long stt = phieuDangKyRepository.findMaxSTTByLich(maLich);
        phieuDangKy.setSTTKham(stt >= 0 ? (int)(stt + 1) : 1);


        return phieuDangKyRepository.save(phieuDangKy);
    }

}
