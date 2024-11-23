package org.example.be_benhvien.DTO;

import lombok.Getter;
import lombok.Setter;
import org.example.be_benhvien.POJO.ChuyenKhoa;
import org.example.be_benhvien.POJO.HocVi;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class BacSiDTO {
    private String maBacSi;
    private String hoTen;
    private String gioiTinh;
    private String hocHam;
    private String anhDaiDien;
    private String gioiThieu;
    private String trangThai;
    private Date ngayCapNhat;
    private List<HocVi> hocViList;
    private ChuyenKhoa chuyenKhoa;

}
