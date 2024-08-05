import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-card-datlich',
  standalone: true,
  templateUrl: './card-datlich.component.html',
  styleUrls: ['./card-datlich.component.css'],
  imports: [FormsModule, CommonModule]
})
export class CardDatlichComponent implements OnInit {
  showDoctor: boolean = false;
  showDate: boolean = false;
  doctors: any[] = [];

  phObj: any = {
    name: '',
    dob: '',
    gender: '',
    phone: '',
    address: '',
    doctor: '',
    appointment_date: '',
    time_slot: '',
    description: ''
  };

  private apiUrl = 'http://localhost:4848/phieuhen/themPH';
  private doctorsApiUrl = 'http://localhost:4848/phieuhen/bstheongaylam';
  private datesApiUrl = 'http://localhost:4848/phieuhen/ngaylamvieccuabs';
  private allDoctorsApiUrl = 'http://localhost:4848/bacsi/danhsachbs';

  constructor(private http: HttpClient) {}

  ngOnInit() {
    // Tải danh sách bác sĩ khi component khởi tạo
    this.loadAllDoctors();
  }

  showDoctorSection() {
    this.showDoctor = true;
    this.showDate = false;
    // Nếu cần lấy danh sách bác sĩ toàn bộ
    this.loadAllDoctors();
  }

  showDateSection() {
    this.showDoctor = false;
    this.showDate = true;
    // Xóa lựa chọn trước đó
    this.phObj.doctor = '';
    this.phObj.appointment_date = '';
    this.phObj.time_slot = '';
  }

  // Gọi API để lấy danh sách bác sĩ
  loadAllDoctors() {
    this.http.get<any[]>(this.allDoctorsApiUrl)
      .subscribe(response => {
        this.doctors = response;
      }, error => {
        console.error('Lỗi khi gọi API lấy danh sách bác sĩ:', error);
      });
  }

  // Gọi API lấy bác sĩ theo ngày và khung giờ
  onDateChange() {
    if (this.phObj.appointment_date && this.phObj.time_slot) {
      this.getBacSiByDateAndShift();
    }
  }

  onShiftChange($event: any) {
    console.log($event.target.value);
    console.log(this.phObj.time_slot);
    if (this.phObj.appointment_date && this.phObj.time_slot) {
      this.getBacSiByDateAndShift();
    }
  }

  getBacSiByDateAndShift() {
    this.http.get<any[]>(`${this.doctorsApiUrl}?ngayLam=${this.phObj.appointment_date}&caLam=${this.phObj.time_slot}`)
        .subscribe(response => {
          this.doctors = response;
        }, error => {
          console.error('Lỗi khi gọi API lấy bác sĩ:', error);
        });
  }

  // Gọi API lấy ngày làm việc của bác sĩ
  onDoctorChange() {
    if (this.phObj.doctor) {
      this.http.get<any[]>(`${this.datesApiUrl}/${this.phObj.doctor}`)
        .subscribe(response => {
          // Xử lý phản hồi nếu cần
        }, error => {
          console.error('Lỗi khi gọi API lấy ngày làm việc của bác sĩ:', error);
        });
    }
  }

  themPhieuHen() {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    this.http.post<string>(this.apiUrl, this.phObj, { headers }).subscribe(
      response => {
        console.log('Phản hồi từ server:', response);
      },
      error => {
        console.error('Lỗi khi gọi API:', error);
      }
    );
  }

  onSubmit() {
    this.themPhieuHen();
  }
}
