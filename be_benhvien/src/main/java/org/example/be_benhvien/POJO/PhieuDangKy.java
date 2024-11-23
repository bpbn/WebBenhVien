package org.example.be_benhvien.POJO;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Entity
@Table(name="PHIEUDANGKY")
@AllArgsConstructor
@NoArgsConstructor
public class PhieuDangKy {
    @Id
    private String maPhieuDangKy;
    private Date ngayLap;
    private String maBHYT;
    private String trangThaiThanhToan;
    private String maBenhNhan;
    private String NVLap;

    private String lichLamViec;

    private String NVThanhToan;
    private String tinhTrangSucKhoe;
    private Integer STTTiepNhan;
    private Integer STTKham;
    private String hinhThucDangKy;



}
