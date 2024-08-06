import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { LichlamviecComponent } from '../lichlamviec/lichlamviec.component';

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
    this.loadAllDoctors();
  }

  showDoctorSection() {
    this.showDoctor = true;
    this.showDate = false;
    this.loadAllDoctors();
  }

  showDateSection() {
    this.showDoctor = false;
    this.showDate = true;
    this.phObj.doctor = ''; 
    this.phObj.appointment_date = '';
    this.phObj.time_slot = '';
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
    if (this.phObj.appointment_date && this.phObj.time_slot) {
      this.getBacSiByDateAndShift();
    }
  }

  onShiftChange($event: any) {
    if (this.phObj.appointment_date && this.phObj.time_slot) {
      this.getBacSiByDateAndShift();
    }
  }

  getBacSiByDateAndShift() {
    this.http.get<any[]>(`${this.doctorsApiUrl}?ngayLam=${this.phObj.appointment_date}&caLam=${this.phObj.time_slot}`)
      .subscribe(response => {
        console.log('Bác sĩ theo ngày và ca làm:', response);
        this.doctors = response;
      }, error => {
        console.error('Lỗi khi gọi API lấy bác sĩ:', error);
      });
  }

  onDoctorChange() {
    if (this.phObj.doctor) {
      this.http.get<any[]>(`${this.datesApiUrl}/${this.phObj.doctor}`)
        .subscribe(response => {
          console.log('Ngày làm việc của bác sĩ:', response);
        }, error => {
          console.error('Lỗi khi gọi API lấy ngày làm việc của bác sĩ:', error);
        });
    }
  }

  themPhieuHen() {
    // Chuyển đổi giá trị giới tính và ca làm để tương thích với database
    if (this.phObj.gender === 'Nam') {
      this.phObj.gender = 'Nam';
    } else if (this.phObj.gender === 'Nu') {
      this.phObj.gender = 'Nữ';
    }
  
    if (this.phObj.time_slot === 'morning') {
      this.phObj.time_slot = 'Sáng';
    } else if (this.phObj.time_slot === 'afternoon') {
      this.phObj.time_slot = 'Chiều';
    }

    const selectedDoctor = this.doctors.find(doctor => doctor.MaNhanVien === this.phObj.doctor);
    if (selectedDoctor) {
      this.phObj.doctor = selectedDoctor;
    } else {
      console.error('Không tìm thấy bác sĩ với mã:', this.phObj.doctor);
      return;
    }
  
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    console.log('Dữ liệu gửi đến API:', this.phObj);
    this.http.post<string>(this.apiUrl, this.phObj, { headers }).subscribe(
      response => {
        console.log('Phản hồi từ server:', response);
      },
      error => {
        console.error('Lỗi khi gọi API:', error);
        if (error instanceof HttpErrorResponse) {
          if (error.error instanceof ErrorEvent) {
            console.error('Lỗi phía client:', error.error.message);
          } else {
            console.error(`Lỗi phía server: ${error.status} - ${error.message}`);
            if (typeof error.error === 'string') {
              console.error('Phản hồi lỗi không phải JSON:', error.error);
            }
          }
        } else {
          console.error('Lỗi không mong đợi:', error);
        }
      }
    );
  }
  
  

  onSubmit() {
    if (this.isFormValid()) {
      this.themPhieuHen();
    } else {
      console.error('Form không hợp lệ');
    }
  }
  
  isFormValid(): boolean {
    return this.phObj.name && this.phObj.dob && this.phObj.gender && this.phObj.phone && 
           this.phObj.address && this.phObj.doctor && this.phObj.appointment_date && this.phObj.time_slot;
  }
}
