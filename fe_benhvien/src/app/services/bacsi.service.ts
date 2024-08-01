import { url } from 'inspector';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class BacsiService {

  apiURL: string = "http://localhost:4848/bacsi"

  constructor(private http: HttpClient){}

  getAllDoctor(){
    return this.http.get(this.apiURL + "/danhsachbs");
  }

  getTongBacSi(){
    return this.http.get<number>(this.apiURL + "/tongBS");
  }

  getTongTienSi(){
    return this.http.get<number>(this.apiURL + "/tongTS");
  }

  getTongThacSi(){
    return this.http.get<number>(this.apiURL + "/tongThS");
  }

  getTongGSvaPGS(){
    return this.http.get<number>(this.apiURL + "/tongGSvaPGS");
  }

  getListHocVi(){
    return this.http.get(this.apiURL + "/danhsachhv");
  }

  getListHocHam(){
    return this.http.get<string[]>(this.apiURL + "/danhsachhh");
  }

  getListChucVu(){
    return this.http.get<string[]>(this.apiURL + "/danhsachcv");
  }

  getDanhHieu(id: string){
    return this.http.get<string>(this.apiURL + "/danhsachcv/" + id);
  }
}
