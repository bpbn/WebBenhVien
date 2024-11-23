package org.example.be_benhvien.POJO;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Table(name = "HOCVI")
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class HocVi {
    @Id
    private String maHocVi;
    private String tenHocVi;
    private Integer bacHocVi;
}
