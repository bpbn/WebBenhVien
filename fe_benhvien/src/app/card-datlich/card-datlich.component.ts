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

  phObj: any = {
    name: '',
    dob: '',
    gender: '',
    phone: '',
    address: '',
    doctor: '',
    appointment_date: '',
    description: '',
    caLam: ''
  };

  doctors: any[] = [];
  availableDates: any[] = [];
  availableShifts: any[] = [];
  doctorDatesMap: { [doctor: string]: string[] } = {};
  dateShiftsMap: { [date: string]: any[] } = {};

  private baseUrl = 'http://localhost:4848'; 

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.getDoctors();
  }

  getDoctors() {
    this.http.get<any[]>(`${this.baseUrl}/bacsi/danhsachbs`).subscribe(
      response => {
        this.doctors = response;
      },
      error => {
        console.error('Lỗi khi lấy danh sách bác sĩ:', error);
      }
    );
  }

  showDoctorSection() {
    this.showDoctor = true;
    this.showDate = false;
    this.phObj.doctor = '';
    this.phObj.appointment_date = '';
    this.availableShifts = [];
    this.getAvailableDatesForDoctors();
  }

  showDateSection() {
    this.showDoctor = false;
    this.showDate = true;
    this.phObj.doctor = '';
    this.phObj.appointment_date = '';
    this.availableShifts = [];
    this.getAllAvailableDates();
  }

  getAvailableDatesForDoctors() {
    this.doctors.forEach(doctor => {
      this.getAvailableDatesForDoctor(doctor.name);
    });
  }

  getAvailableDatesForDoctor(doctorName: string) {
    this.http.get<any[]>(`${this.baseUrl}/phieuhen/ngaylamvieccuabs`, { params: { tenBacSi: doctorName } }).subscribe(
      response => {
        this.doctorDatesMap[doctorName] = response;
        if (this.phObj.doctor === doctorName) {
          this.availableDates = response;
        }
      },
      error => {
        console.error('Lỗi khi lấy ngày làm việc của bác sĩ:', error);
      }
    );
  }

  onDoctorChange(event: Event) {
    const target = event.target as HTMLSelectElement;
    this.phObj.doctor = target.value;
    this.availableDates = this.doctorDatesMap[this.phObj.doctor] || [];
    this.phObj.appointment_date = '';
    this.availableShifts = [];
  }

  getAllAvailableDates() {
    this.http.get<any[]>(`${this.baseUrl}/phieuhen/ngaylamvieccuabs`, { params: { tenBacSi: '' } }).subscribe(
      response => {
        this.availableDates = response;
      },
      error => {
        console.error('Lỗi khi lấy tất cả các ngày làm việc:', error);
      }
    );
  }

  onDateChange(event: Event) {
    const target = event.target as HTMLSelectElement;
    const date = target.value;
    this.phObj.appointment_date = date;
    if (this.showDoctor && this.phObj.doctor) {
      this.getAvailableShiftsForDoctor(date);
    } else if (this.showDate) {
      this.getAvailableShiftsForDate(date);
    }
  }

  getAvailableShiftsForDoctor(date: string) {
    this.http.get<any[]>(`${this.baseUrl}/phieuhen/bstheongaylam`, { params: { ngayLam: date, caLam: 'Sáng' } }).subscribe(
      response => {
        this.availableShifts = response;
      },
      error => {
        console.error('Lỗi khi lấy ca làm việc theo ngày và bác sĩ:', error);
      }
    );
  }

  getAvailableShiftsForDate(date: string) {
    this.http.get<any[]>(`${this.baseUrl}/phieuhen/bstheongaylam`, { params: { ngayLam: date, caLam: '' } }).subscribe(
      response => {
        this.dateShiftsMap[date] = response;
      },
      error => {
        console.error('Lỗi khi lấy ca làm việc theo ngày:', error);
      }
    );
  }

  onShiftChange(caLam: string) {
    this.phObj.caLam = caLam;
    if (this.showDate) {
      this.phObj.doctor = this.dateShiftsMap[this.phObj.appointment_date]?.find(shift => shift.caLam === caLam)?.doctor || '';
    }
  }

  themPhieuHen() {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    this.http.post<string>(this.baseUrl + '/phieuhen/themPH', this.phObj, { headers }).subscribe(
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
