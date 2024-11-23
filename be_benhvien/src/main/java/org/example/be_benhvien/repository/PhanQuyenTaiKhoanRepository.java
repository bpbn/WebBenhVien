package org.example.be_benhvien.repository;

import org.example.be_benhvien.POJO.PhanQuyenTaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PhanQuyenTaiKhoanRepository extends JpaRepository<PhanQuyenTaiKhoan, String> {
    Optional<PhanQuyenTaiKhoan> findByTenTaiKhoanAndMaQuyen(String tenTaiKhoan, String maQuyen);
}
