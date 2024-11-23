package org.example.be_benhvien.repository;

import org.example.be_benhvien.POJO.BenhNhan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BenhNhanRepository extends JpaRepository<BenhNhan, String> {
    @Query("SELECT MAX(b.maBenhNhan) FROM BenhNhan b")
    String findMaxMaBenhNhan();

    @Query("SELECT bn FROM BenhNhan bn WHERE bn.taiKhoan.tenTaiKhoan = :tenTaiKhoan")
    BenhNhan findByTenTaiKhoan(@Param("tenTaiKhoan") String tenTaiKhoan);
}
