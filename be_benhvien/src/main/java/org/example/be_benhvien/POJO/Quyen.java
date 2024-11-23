package org.example.be_benhvien.POJO;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "QUYEN")
public class Quyen {
    @Id
    private String maQuyen;

    private String quyen;

}
