package org.example.be_benhvien.POJO;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Table(name="TAIKHOAN")
@AllArgsConstructor
@NoArgsConstructor
public class TaiKhoan {
    @Id

    private String tenTaiKhoan;
    private String matKhau;

}
