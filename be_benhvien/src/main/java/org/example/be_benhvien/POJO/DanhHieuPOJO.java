package org.example.be_benhvien.POJO;

public class DanhHieuPOJO {
    private String maNhanVien;
    private String danhHieu;

    public void setDanhHieu(String danhHieu) {
        this.danhHieu = danhHieu;
    }

    public String getDanhHieu() {
        return danhHieu;
    }

    public String getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(String maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public DanhHieuPOJO() {}

    public DanhHieuPOJO(String maNhanVien, String danhHieu) {
        this.maNhanVien = maNhanVien;
        this.danhHieu = danhHieu;
    }
}