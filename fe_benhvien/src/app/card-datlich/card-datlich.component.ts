import { Component } from '@angular/core';
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
export class CardDatlichComponent {
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
    description: ''
  };

  private apiUrl = 'http://localhost:8080/phieuhen/themPH';  // Thay đổi theo URL của bạn

  constructor(private http: HttpClient) {}

  showDoctorSection() {
    this.showDoctor = true;
    this.showDate = false;
  }

  showDateSection() {
    this.showDoctor = false;
    this.showDate = true;
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
