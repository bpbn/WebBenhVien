package org.example.be_benhvien.repository;

import org.example.be_benhvien.POJO.BacSi;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BacSiRepository extends JpaRepository<BacSi, String> {

    @Query("SELECT b FROM BacSi b JOIN b.chuyenKhoa ck WHERE ck.maChuyenKhoa = :maChuyenKhoa")
    List<BacSi> findBacSiByChuyenKhoa(@Param("maChuyenKhoa") String maChuyenKhoa);

    // Đếm số bác sĩ có học hàm
    @Query("SELECT COUNT(b) FROM BacSi b WHERE b.hocHam IN :hocHams")
    long countByHocHamIn(@Param("hocHams") List<String> hocHams);

    // Đếm số bác sĩ có mã học vị là Thạc sĩ / TS
    long countByHocViList_MaHocVi(String maHocVi);

    // Đếm tổng số bác sĩ
    long count();
}
