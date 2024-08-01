import { HttpClient } from '@angular/common/http';
import { Component, inject } from '@angular/core';

@Component({
  selector: 'app-get-api',
  standalone: true,
  imports: [],
  templateUrl: './get-api.component.html',
  styleUrl: './get-api.component.css'
})
export class GetApiComponent {

  bacsiList: any [] = [];

constructor(private http: HttpClient){

}

getAllBacSi()
{
  this.http.get("http://localhost:4848/bacsi/danhsachbs").subscribe((result:any)=>{
    this.bacsiList = result;
  })
}

}
