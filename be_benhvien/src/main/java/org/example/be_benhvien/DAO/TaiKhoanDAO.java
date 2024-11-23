package org.example.be_benhvien.DAO;

import org.example.be_benhvien.DTO.LoginRequest;
import org.example.be_benhvien.POJO.TaiKhoan;
import org.example.be_benhvien.config.BCryptEncoder;
import org.example.be_benhvien.config.JWTUtil;
import org.example.be_benhvien.repository.TaiKhoanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TaiKhoanDAO {
    @Autowired
    private TaiKhoanRepository taiKhoanRepository;

    @Autowired
    private JWTUtil jwtUtil;

    @Autowired
    private BCryptEncoder passwordEncoder;

    private Optional<TaiKhoan> checkIfAccountExists(String tenTaiKhoan) {
        return taiKhoanRepository.findByTenTaiKhoan(tenTaiKhoan);
    }

    public ResponseEntity<String> login(LoginRequest loginRequest) {
        if (!isValidUser(loginRequest.getTenTaiKhoan(), loginRequest.getMatKhau())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("{\"message\": \"Tên tài khoản hoặc mật khẩu không đúng\"}");
        }


        String token = jwtUtil.generateToken(loginRequest.getTenTaiKhoan());
        return ResponseEntity.ok("{\"token\": \"" + token + "\"}");
    }


    private boolean isValidUser(String tenTaiKhoan, String matKhau) {
        Optional<TaiKhoan> accountOpt = checkIfAccountExists(tenTaiKhoan);
        if (accountOpt.isPresent()) {
            TaiKhoan taiKhoan = accountOpt.get();
            return passwordEncoder.matches(matKhau, taiKhoan.getMatKhau());
        }
        return false;
    }
}
