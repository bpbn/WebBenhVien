package org.example.be_benhvien.POJO;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "PHONG")
public class Phong {
    @Id
    private String maPhong;
    private String tenPhong;
    private String viTri;
}
