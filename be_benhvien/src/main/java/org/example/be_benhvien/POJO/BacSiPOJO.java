package org.example.be_benhvien.POJO;

import java.util.List;

public class BacSiPOJO {
    private String MaBacSi;
    private String TenBacSi;

    private String ChucVu;
    private String HocHam;
    private String GioiThieu;
    private String GioiTinh;
    private String HinhAnh;
    private List<HocVi> HocVi;

    public static class HocVi{
        private String MaHocVi;
        private String TenHocVi;
        private Integer BacHocVi;

        public  HocVi(){}

        public String getMaHocVi() {
            return MaHocVi;
        }

        public void setMaHocVi(String maHocVi) {
            MaHocVi = maHocVi;
        }

        public String getTenHocVi() {
            return TenHocVi;
        }

        public void setTenHocVi(String tenHocVi) {
            TenHocVi = tenHocVi;
        }

        public Integer getBacHocVi() {
            return BacHocVi;
        }

        public void setBacHocVi(Integer bacHocVi) {
            BacHocVi = bacHocVi;
        }
    }

    public BacSiPOJO(){}

    public String getMaBacSi() {
        return MaBacSi;
    }

    public void setMaBacSi(String maBacSi) {
        MaBacSi = maBacSi;
    }

    public String getTenBacSi() {
        return TenBacSi;
    }

    public void setTenBacSi(String tenBacSi) {
        TenBacSi = tenBacSi;
    }

    public String getChucVu() {
        return ChucVu;
    }

    public void setChucVu(String chucVu) {
        ChucVu = chucVu;
    }

    public String getHocHam() {
        return HocHam;
    }

    public void setHocHam(String hocHam) {
        HocHam = hocHam;
    }

    public String getGioiThieu() {
        return GioiThieu;
    }

    public void setGioiThieu(String gioiThieu) {
        GioiThieu = gioiThieu;
    }

    public String getGioiTinh() {
        return GioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        GioiTinh = gioiTinh;
    }

    public String getHinhAnh() {
        return HinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        HinhAnh = hinhAnh;
    }

    public List<HocVi> getHocVi() {
        return HocVi;
    }

    public void setHocVi(List<HocVi> hocVi) {
        HocVi = hocVi;
    }

    public void addHocVi(HocVi hocVi){
        HocVi.add(hocVi);
    }
}
