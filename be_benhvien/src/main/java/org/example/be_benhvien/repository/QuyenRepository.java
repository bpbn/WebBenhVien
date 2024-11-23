package org.example.be_benhvien.repository;


import org.example.be_benhvien.POJO.Quyen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuyenRepository extends JpaRepository<Quyen, String> {
}
