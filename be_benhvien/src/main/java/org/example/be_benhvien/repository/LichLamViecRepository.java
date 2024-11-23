package org.example.be_benhvien.repository;

import org.example.be_benhvien.POJO.BacSi;
import org.example.be_benhvien.POJO.LichLamViec;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;

public interface LichLamViecRepository extends JpaRepository<LichLamViec, String> {

    // Tìm ngày làm việc theo mã bác sĩ
    List<LichLamViec> findByBacSi_MaBacSi(String maBacSi);

    // Tìm bác sĩ theo ngày làm việc
    @Query("SELECT l.bacSi FROM LichLamViec l WHERE l.ngayLam = :ngayLam")
    List<BacSi> findBacSiByNgayLam(LocalDate ngayLam);

    LichLamViec findByBacSi_MaBacSiAndNgayLam(String maBacSi, LocalDate ngayLam);
}
