package org.example.be_benhvien.POJO;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="CHUYENKHOA")
public class ChuyenKhoa{

    @Id
    private String maChuyenKhoa;
    private String tenChuyenKhoa;
    private String hinhAnh;
}
