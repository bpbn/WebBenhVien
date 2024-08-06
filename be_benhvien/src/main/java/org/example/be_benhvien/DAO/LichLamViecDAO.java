package org.example.be_benhvien.DAO;

import org.example.be_benhvien.POJO.BacSiPOJO;
import org.example.be_benhvien.POJO.LichLamViecPOJO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.time.DayOfWeek;


@Repository
public class LichLamViecDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<LichLamViecPOJO> layBacSiTheoNgayLamVaCaLam(LocalDate ngayLam, String caLam) {
        String sql = "SELECT L.CALAM, L.NGAYLAM, N.TENNHANVIEN, N.MANHANVIEN " +
                "FROM LICHLAMVIEC L " +
                "JOIN NHANVIEN N ON L.MANHANVIEN = N.MANHANVIEN " +
                "WHERE L.NGAYLAM = ? AND L.CALAM = ?";
        return jdbcTemplate.query(sql, new Object[]{ngayLam, caLam}, (rs, rowNum) -> {
            LichLamViecPOJO lichLamViecPOJO = new LichLamViecPOJO();
            BacSiPOJO bacSiPOJO = new BacSiPOJO();

            lichLamViecPOJO.setCaLam(rs.getString("CALAM"));
            lichLamViecPOJO.setNgayLam(rs.getDate("NGAYLAM").toLocalDate());

            bacSiPOJO.setTenNhanVien(rs.getString("TENNHANVIEN"));
            bacSiPOJO.setMaNhanVien(rs.getString("MANHANVIEN"));
            lichLamViecPOJO.setBacSi(bacSiPOJO);

            return lichLamViecPOJO;
        });
    }

    public List<LichLamViecPOJO> layNgayLamViecTheoMaNhanVien(String maNhanVien) {
        String sql = "SELECT NGAYLAM, CALAM " +
                "FROM LICHLAMVIEC " +
                "WHERE MANHANVIEN = ?";
        return jdbcTemplate.query(sql, new Object[]{maNhanVien}, (rs, rowNum) -> {
            LichLamViecPOJO lichLamViecPOJO = new LichLamViecPOJO();

            lichLamViecPOJO.setNgayLam(rs.getDate("NGAYLAM").toLocalDate());
            lichLamViecPOJO.setCaLam(rs.getString("CALAM"));

            return lichLamViecPOJO;
        });
    }

    public List<String> layNgayLamViecCuaBacSi(String maNhanVien){
        List<String> ds = new ArrayList<String>();
        try {
            String sql = "SELECT DISTINCT NGAYLAM FROM LICHLAMVIEC WHERE MANHANVIEN = ?";
            Object[] args = {maNhanVien};
            return jdbcTemplate.queryForList(sql, args, String.class);
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

    public List<String> layCaLamTheoNgayCuaBacSi(String maNhanVien, String ngayLam){
        List<String> ds = new ArrayList<String>();
        try {
            String sql = "SELECT CALAM FROM LICHLAMVIEC WHERE MANHANVIEN = ? AND NGAYLAM = ?";
            Object[] args = {maNhanVien, ngayLam};
            return jdbcTemplate.queryForList(sql, args, String.class);
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

    public Object layNgayLamViecCuaBacSiTrongThang(String maNhanVien) {
        List<Integer> ds = new ArrayList<>();
        try {
            String sql = "SELECT DAY(NGAYLAM) AS NGAY FROM LICHLAMVIEC WHERE MANHANVIEN = ? AND MONTH(NGAYLAM) = MONTH(GETDATE())";
            Object[] args = {maNhanVien};

            List<Integer> ngayLamViecs = jdbcTemplate.queryForList(sql, args, Integer.class);

            return ngayLamViecs.stream().mapToInt(Integer::intValue).toArray();
        } catch (Exception e) {
            System.out.println((e.getMessage()));
        }
        return ds;
    }

    public static List<Integer> tachNgayTheoTuan(int weekIndex) {
        if (weekIndex <= 0) {
            throw new IllegalArgumentException("Week index must be 1 or greater");
        }

        LocalDate today = LocalDate.now();
        LocalDate firstDayOfMonth = today.withDayOfMonth(1);
        LocalDate firstDayOfWeek = firstDayOfMonth.with(DayOfWeek.MONDAY);

        int daysToAdd = (weekIndex - 1) * 7;
        firstDayOfWeek = firstDayOfWeek.plusDays(daysToAdd);

        List<Integer> weekDays = new ArrayList<>();
        LocalDate currentDay = firstDayOfWeek;

        for (int j = 0; j < 7; j++) {
            if (currentDay.isAfter(today.withDayOfMonth(today.lengthOfMonth()))) {
                // Handle end of month and fill remaining days with next month
                int daysInCurrentMonth = currentDay.lengthOfMonth();
                for (int k = weekDays.size(); k < 7; k++) {
                    weekDays.add(currentDay.getDayOfMonth());
                    if (currentDay.getDayOfMonth() == daysInCurrentMonth) {
                        currentDay = currentDay.plusMonths(1).withDayOfMonth(1);
                    } else {
                        currentDay = currentDay.plusDays(1);
                    }
                }
                break;
            }
            weekDays.add(currentDay.getDayOfMonth());
            currentDay = currentDay.plusDays(1);
        }

        return weekDays;
    }

}
