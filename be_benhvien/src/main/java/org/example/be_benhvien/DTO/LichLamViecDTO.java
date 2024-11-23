package org.example.be_benhvien.DTO;

import lombok.Getter;
import lombok.Setter;
import org.example.be_benhvien.POJO.BacSi;
import org.example.be_benhvien.POJO.Phong;

import java.time.LocalDate;

@Getter
@Setter
public class LichLamViecDTO {
    private String maLich;
    private BacSi bacSi;
    private LocalDate ngayLam;
    private Phong phongLamViec;
}
