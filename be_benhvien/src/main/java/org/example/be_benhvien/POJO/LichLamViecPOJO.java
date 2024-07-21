package org.example.be_benhvien.POJO;

import javax.xml.crypto.Data;
import java.util.Date;

public class LichLamViecPOJO {
    private String MaLich;
    private BacSiPOJO BacSi;
    private Date NgayLam;
    private String CaLam;
    private PhongKham PhongLamViec;

    public String getMaLich() {
        return MaLich;
    }

    public void setMaLich(String maLich) {
        MaLich = maLich;
    }

    public BacSiPOJO getBacSi() {
        return BacSi;
    }

    public void setBacSi(BacSiPOJO bacSi) {
        BacSi = bacSi;
    }

    public Date getNgayLam() {
        return NgayLam;
    }

    public void setNgayLam(Date ngayLam) {
        NgayLam = ngayLam;
    }

    public String getCaLam() {
        return CaLam;
    }

    public void setCaLam(String caLam) {
        CaLam = caLam;
    }

    public PhongKham getPhongLamViec() {
        return PhongLamViec;
    }

    public void setPhongLamViec(PhongKham phongLamViec) {
        PhongLamViec = phongLamViec;
    }

    private class PhongKham{
        private String MaPhong;
        private String TenPhong;
        private String ViTri;

        public String getMaPhong() {
            return MaPhong;
        }

        public void setMaPhong(String maPhong) {
            MaPhong = maPhong;
        }

        public String getTenPhong() {
            return TenPhong;
        }

        public void setTenPhong(String tenPhong) {
            TenPhong = tenPhong;
        }

        public String getViTri() {
            return ViTri;
        }

        public void setViTri(String viTri) {
            ViTri = viTri;
        }
    }
}
