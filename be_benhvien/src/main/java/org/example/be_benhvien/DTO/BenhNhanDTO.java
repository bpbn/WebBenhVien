package org.example.be_benhvien.DTO;

import lombok.Getter;
import lombok.Setter;
import org.example.be_benhvien.POJO.TaiKhoan;

@Getter
@Setter
public class BenhNhanDTO {
    private String maBenhNhan;
    private String hoTen;
    private String gioiTinh;
    private String diaChi;
    private Integer namSinh;
    private String dienThoai;
    private TaiKhoan taiKhoan;
}
