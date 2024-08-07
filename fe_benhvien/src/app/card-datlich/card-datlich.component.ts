import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { LichlamviecComponent } from '../lichlamviec/lichlamviec.component';
import {MatSnackBar} from '@angular/material/snack-bar';
import { Router } from '@angular/router';

@Component({
  selector: 'app-card-datlich',
  standalone: true,
  templateUrl: './card-datlich.component.html',
  styleUrls: ['./card-datlich.component.css'],
  imports: [FormsModule, CommonModule, LichlamviecComponent]
})
export class CardDatlichComponent implements OnInit {
  showDoctor: boolean = false;
  showDate: boolean = false;
  doctors: any[] = [];

  phObj: any = {
    maPhieuHen: '',
    tenBenhNhan: '',
    ngaySinh: '',
    gioiTinh: '',
    sdt: '',
    diaChi: '',
    bacSi: '',
    ngayKham: '',
    khungGioKham: '',
    vanDeSucKhoe: ''
  };

  private apiUrl = 'http://localhost:4848/phieuhen/themPH';
  private doctorsApiUrl = 'http://localhost:4848/phieuhen/bstheongaylam';
  private allDoctorsApiUrl = 'http://localhost:4848/bacsi/danhsachbs';
  private dateApiUrl = 'http://localhost:4848/phieuhen/ngaylamvieccuabs';
  private shiftApiUrl = 'http://localhost:4848/phieuhen/caLamViec';

  constructor(
    private http: HttpClient,
    private _snackBar: MatSnackBar,
    private router: Router,
  ) {}

  ngOnInit() {
  }

  openSnackBar(message: string, action: string) {
    this._snackBar.open(message, action);
  }
  
  showDoctorSection() {
    this.loadAllDoctors();
    this.showDoctor = true;
    this.showDate = false;
  }

  showDateSection() {
    this.showDoctor = false;
    this.showDate = true;
    this.phObj.bacSi = ''; 
    this.phObj.ngayKham = '';
    this.phObj.khungGioKham = '';
  }

  loadAllDoctors() {
    this.http.get<any[]>(this.allDoctorsApiUrl)
      .subscribe(response => {
        console.log('Danh sách bác sĩ:', response);
        this.doctors = response;
      }, error => {
        console.error('Lỗi khi gọi API lấy danh sách bác sĩ:', error);
      });
  }

  onDateChange() {
    if (this.phObj.ngayKham && this.phObj.khungGioKham) {
      this.getBacSiByDateAndShift();
    }
  }

  onShiftChange($event: any) {
    if (this.phObj.ngayKham && this.phObj.khungGioKham) {
      this.getBacSiByDateAndShift();
    }
  }

  getBacSiByDateAndShift() {
    this.http.get<any[]>(`${this.doctorsApiUrl}?ngayLam=${this.phObj.ngayKham}&caLam=${this.phObj.khungGioKham}`)
      .subscribe(response => {
        console.log('Bác sĩ theo ngày và ca làm:', response);
        this.doctors = response;
      }, error => {
        console.error('Lỗi khi gọi API lấy bác sĩ:', error);
      });
  }

  onDoctorChange() {
    if (this.phObj.bacSi) {
      this.http.get<any[]>(`${this.dateApiUrl}?maNhanVien=${this.phObj.bacSi}`)
        .subscribe(response => {
          console.log('Ngày làm việc của bác sĩ:', response);
        }, error => {
          console.error('Lỗi khi gọi API lấy ngày làm việc của bác sĩ:', error);
        });
    }
  }
  

  themPhieuHen() {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    console.log('Dữ liệu gửi đến API:', this.phObj);
    this.http.post<string>(this.apiUrl, this.phObj, { headers }).subscribe(
      response => {
        console.log('Phản hồi từ server:', response) 
      },
      error => {
        console.error('Lỗi khi gọi API:', error);
      }
    );
  }
  

  onSubmit() {
    if (this.isFormValid()) {
      this.themPhieuHen();
      this.openSnackBar('Đặt lịch hẹn thành công', 'OK');
      this.router.navigate(['/']); 
    } else {
      this.openSnackBar('Đặt lịch hẹn thất bại', 'OK');
      console.error('Form không hợp lệ');
    }
  }

  isFormValid(): boolean {
    return this.phObj.tenBenhNhan && this.phObj.ngaySinh && this.phObj.gioiTinh && this.phObj.sdt && 
           this.phObj.diaChi && this.phObj.bacSi && this.phObj.ngayKham && this.phObj.khungGioKham;
  }
}
