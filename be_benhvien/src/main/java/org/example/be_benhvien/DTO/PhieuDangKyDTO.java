package org.example.be_benhvien.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class PhieuDangKyDTO {
    private String maPhieuDangKy;
    private Date ngayLap;
    private String maBHYT;
    private String trangThaiThanhToan;
    private String maBenhNhan;
    private String lichLamViec;
    private String tinhTrangSucKhoe;
    private Integer STTTiepNhan;
    private String hinhThucDangKy;
    private LocalDate ngayKham;
    private String maBacSi;
}
