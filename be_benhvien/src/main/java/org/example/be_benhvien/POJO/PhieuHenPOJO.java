package org.example.be_benhvien.POJO;

import java.util.Date;

public class PhieuHenPOJO {
    private String MaPhieuHen;
    private Date NgayKham;
    private String KhungGioKham;
    private BacSiPOJO BacSi;
    private String VanDeSucKhoe;
    private String TenBenhNhan;
    private Date NgaySinh;
    private String GioiTinh;
    private String SDT;
    private String DiaChi;

    public String getMaPhieuHen() {
        return MaPhieuHen;
    }

    public void setMaPhieuHen(String maPhieuHen) {
        MaPhieuHen = maPhieuHen;
    }

    public Date getNgayKham() {
        return NgayKham;
    }

    public void setNgayKham(Date ngayKham) {
        NgayKham = ngayKham;
    }

    public String getKhungGioKham() {
        return KhungGioKham;
    }

    public void setKhungGioKham(String khungGioKham) {
        KhungGioKham = khungGioKham;
    }

    public String getVanDeSucKhoe() {
        return VanDeSucKhoe;
    }

    public void setVanDeSucKhoe(String vanDeSucKhoe) {
        VanDeSucKhoe = vanDeSucKhoe;
    }

    public String getTenBenhNhan() {
        return TenBenhNhan;
    }

    public void setTenBenhNhan(String tenBenhNhan) {
        TenBenhNhan = tenBenhNhan;
    }

    public Date getNgaySinh() {
        return NgaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        NgaySinh = ngaySinh;
    }

    public String getGioiTinh() {
        return GioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        GioiTinh = gioiTinh;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public String getDiaChi() {
        return DiaChi;
    }

    public void setDiaChi(String diaChi) {
        DiaChi = diaChi;
    }


    public BacSiPOJO getBacSi() {
        return BacSi;
    }

    public void setBacSi(BacSiPOJO bacSi) {
        BacSi = bacSi;
    }
}
