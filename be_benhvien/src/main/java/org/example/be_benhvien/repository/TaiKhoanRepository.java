package org.example.be_benhvien.repository;

import org.example.be_benhvien.POJO.TaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TaiKhoanRepository extends JpaRepository<TaiKhoan, String> {
    Optional<TaiKhoan> findByTenTaiKhoan(String tenTaiKhoan);
}
