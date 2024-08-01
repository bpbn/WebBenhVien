// import { Component } from '@angular/core';
// import { HttpClient, HttpHeaders } from '@angular/common/http';

// @Component({
//   selector: 'app-post-api',
//   standalone: true,
//   templateUrl: './post-api.component.html',
//   styleUrls: ['./post-api.component.css'],
//   providers: [HttpClient]
// })
// export class PostApiComponent {
//   showDoctor: boolean = false;
//   showDate: boolean = false;
  
//   phObj: any = {
//     name: '',
//     dob: '',
//     gender: '',
//     phone: '',
//     address: '',
//     doctor: '',
//     appointment_date: '',
//     description: ''
//   };

//   private apiUrl = 'http://localhost:8080/phieuhen/themPH';  // Thay đổi theo URL của bạn

//   constructor(private http: HttpClient) {}

//   showDoctorSection() {
//     this.showDoctor = true;
//     this.showDate = false;
//   }

//   showDateSection() {
//     this.showDoctor = false;
//     this.showDate = true;
//   }

//   themPhieuHen() {
//     const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
//     this.http.post<string>(this.apiUrl, this.phObj, { headers }).subscribe(
//       response => {
//         console.log('Phản hồi từ server:', response);
//       },
//       error => {
//         console.error('Lỗi khi gọi API:', error);
//       }
//     );
//   }

//   onSubmit() {
//     this.themPhieuHen();
//   }
// }
