package org.example.be_benhvien.POJO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@Entity
@Table(name="BENHNHAN")
@AllArgsConstructor
@NoArgsConstructor
public class BenhNhan {
    @Id
    private String maBenhNhan;
    private String hoTen;
    private String gioiTinh;
    private String diaChi;
    private Integer namSinh;
    private String dienThoai;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "TAIKHOAN", referencedColumnName = "TENTAIKHOAN")
    private TaiKhoan taiKhoan;
}
