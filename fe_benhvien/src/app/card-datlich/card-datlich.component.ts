import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { lastValueFrom } from 'rxjs';
import { BacsiService } from '../services/bacsi.service';

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

  constructor(
    private http: HttpClient,
    private bacsiService : BacsiService
  ) {}

  async ngOnInit() {
    await this.getDoctors();
  }

  async getDoctors() {
    this.bacsiService.getAllDoctor().subscribe((res:any)=>{
      this.doctors = res;
  })
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
    this.getAvailableDatesForDoctor('');
  }

   getAvailableDatesForDoctors() {
    for (const doctor of this.doctors) {
      this.getAvailableDatesForDoctor(doctor.maNhanVien);
      debugger;
      console.log(this.availableDates);
    }
  }

   getAvailableDatesForDoctor(manv: string) {
    this.bacsiService.getAvailableDatesForDoctor(manv).subscribe((res:any)=>{
      this.availableDates = res;
    })
  }

  onDoctorChange(event: Event) {
    const target = event.target as HTMLSelectElement;
    this.phObj.doctor = target.value;
    this.availableDates = this.doctorDatesMap[this.phObj.doctor] || [];
    this.phObj.appointment_date = '';
    this.availableShifts = [];
  }

  // async getAllAvailableDates() {
  //   try {
  //     console.log('Đang lấy tất cả các ngày làm việc...');
  //     const response = await lastValueFrom(this.http.get<any[]>(`${this.baseUrl}/phieuhen/ngaylamvieccuabs`, { params: { tenBacSi: '' } }));
  //     this.availableDates = response || [];
  //     console.log('Tất cả các ngày làm việc:', response);
  //   } catch (error) {
  //     console.error('Lỗi khi lấy tất cả các ngày làm việc:', error);
  //   }
  // }

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

  async getAvailableShiftsForDoctor(date: string) {
    try {
      console.log(`Đang lấy ca làm việc cho bác sĩ vào ngày ${date}...`);
      this.availableShifts = await lastValueFrom(this.http.get<any[]>(`${this.baseUrl}/phieuhen/bstheongaylam`, { params: { ngayLam: date, caLam: 'Sáng' } })) || [];
      console.log(`Ca làm việc vào ngày ${date}:`, this.availableShifts);
    } catch (error) {
      console.error('Lỗi khi lấy ca làm việc theo ngày và bác sĩ:', error);
    }
  }

  async getAvailableShiftsForDate(date: string) {
    try {
      console.log(`Đang lấy ca làm việc vào ngày: ${date}...`);
      this.dateShiftsMap[date] = await lastValueFrom(this.http.get<any[]>(`${this.baseUrl}/phieuhen/bstheongaylam`, { params: { ngayLam: date, caLam: '' } })) || [];
      console.log(`Ca làm việc vào ngày ${date}:`, this.dateShiftsMap[date]);
    } catch (error) {
      console.error('Lỗi khi lấy ca làm việc theo ngày:', error);
    }
  }

  onShiftChange(caLam: string) {
    this.phObj.caLam = caLam;
    if (this.showDate) {
      this.phObj.doctor = this.dateShiftsMap[this.phObj.appointment_date]?.find(shift => shift.caLam === caLam)?.doctor || '';
    }
  }

  async themPhieuHen() {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    try {
      console.log('Đang gửi phiếu hẹn...', this.phObj);
      const response = await lastValueFrom(this.http.post<string>(`${this.baseUrl}/phieuhen/themPH`, this.phObj, { headers }));
      console.log('Phản hồi từ server:', response);
    } catch (error) {
      console.error('Lỗi khi gọi API:', error);
    }
  }

  onSubmit() {
    this.themPhieuHen();
  }
}
