package org.example.be_benhvien.POJO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Entity
@Table(name ="LICHLAMVIEC")
@AllArgsConstructor
@NoArgsConstructor
public class LichLamViec {
    @Id
    private String maLich;

    @ManyToOne
    @JoinColumn(name = "MABACSI")
    private BacSi bacSi;
    private LocalDate ngayLam;

    @ManyToOne
    @JoinColumn(name = "MAPHONG")
    private Phong phongLamViec;

}
