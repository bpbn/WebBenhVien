package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.BacSiPOJO;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Repository
public class BacSiDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private StringHttpMessageConverter stringHttpMessageConverter;

    public List<BacSiPOJO> layDanhSachBacSi(){
        List<BacSiPOJO> ds = new ArrayList<BacSiPOJO>();
        try {
            String sql = "SELECT * FROM THONGTINBACSI T JOIN NHANVIEN N ON T.MANHANVIEN = N.MANHANVIEN";
            return jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(BacSiPOJO.class));
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

    public List<BacSiPOJO.HocVi> layDanhSachHocVi(){
        List<BacSiPOJO.HocVi> ds = new ArrayList<BacSiPOJO.HocVi>();
        try {
            String sql = "select * from HocVi";
            return jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(BacSiPOJO.HocVi.class));
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

    public List<BacSiPOJO.HocVi> layDanhSachHocViCuaBacSi(String MaBacSi){
        List<BacSiPOJO.HocVi> ds = new ArrayList<BacSiPOJO.HocVi>();
        try {
            String sql = "SELECT h.MAHOCVI, h.TENHOCVI, h.BACHOCVI FROM CHITIETHOCVI ct INNER JOIN HOCVI h ON ct.MAHOCVI = h.MAHOCVI WHERE ct.MANHANVIEN = ?";
            Object[] args = {MaBacSi};
            return jdbcTemplate.query(sql, args, BeanPropertyRowMapper.newInstance(BacSiPOJO.HocVi.class));
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

    public BacSiPOJO timBacSiTheoMa(String MaBacSi){
        BacSiPOJO bacSi = null;
        List<BacSiPOJO> ds = layDanhSachBacSi();
        for(BacSiPOJO bs : ds){
            if(MaBacSi.equals(bs.getMaNhanVien())){
                bacSi = bs;
            }
        }
        return bacSi;
    }

    public String taoDanhHieuBS(String MaBacSi){
        StringBuilder danhHieu = new StringBuilder();

        BacSiPOJO bs = timBacSiTheoMa(MaBacSi);
        if(bs.getHocHam() != null) {
            if (bs.getHocHam().equals("Phó giáo sư"))
                danhHieu = new StringBuilder("PGS");
            else if (bs.getHocHam().equals("Giáo sư"))
                danhHieu = new StringBuilder("GS");
        }

        List<BacSiPOJO.HocVi> ds = layDanhSachHocViCuaBacSi(MaBacSi);

        for (int hightest = 1; hightest <= 6; hightest++) {
            for (BacSiPOJO.HocVi h : ds) {
                if (h.getBacHocVi() == hightest) {
                    danhHieu.append(".").append(h.getMaHocVi());
                }
            }
        }

        if (danhHieu.charAt(0) =='.') {
            danhHieu.deleteCharAt(0);
        }

        return danhHieu.toString();
    }

    public Integer tinhTongBacSiLaGS_PGS(){
        int sum = 0;
        List<BacSiPOJO> list = layDanhSachBacSi();
        for(BacSiPOJO bs : list){
            if(bs.getHocHam().equals("Giáo sư") || bs.getHocHam().equals("Phó giáo sư"))
            {
                sum++;
            }
        }
        return  sum;
    }

    public Integer tinhTongTienSi(){
        int sum = 0;
        List<BacSiPOJO> list = layDanhSachBacSi();
        for(BacSiPOJO bs : list){
            List<BacSiPOJO.HocVi> list2 = layDanhSachHocViCuaBacSi(bs.getMaNhanVien());
            for(BacSiPOJO.HocVi h : list2) {
                if(h.getMaHocVi().equals("TS"))
                {
                    sum++;
                }
            }
        }
        return  sum;
    }

    public Integer tinhTongThacSi(){
        int sum = 0;
        List<BacSiPOJO> list = layDanhSachBacSi();
        for(BacSiPOJO bs : list){
            List<BacSiPOJO.HocVi> list2 = layDanhSachHocViCuaBacSi(bs.getMaNhanVien());
            for(BacSiPOJO.HocVi h : list2) {
                if(h.getMaHocVi().equals("THS"))
                {
                    sum++;
                }
            }
        }
        return  sum;
    }

    public Integer tinhTongBacSi(){
        int sum = 0;
        List<BacSiPOJO> list = layDanhSachBacSi();
        for(BacSiPOJO bs : list){
            sum++;
        }
        return  sum;
    }
}

