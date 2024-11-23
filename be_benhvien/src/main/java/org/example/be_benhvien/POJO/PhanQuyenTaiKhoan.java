package org.example.be_benhvien.POJO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "PHANQUYENTAIKHOAN")
public class PhanQuyenTaiKhoan {
    @Id
    private String tenTaiKhoan;

    private String maQuyen;

}
