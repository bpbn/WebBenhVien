import { BacsiService } from './../services/bacsi.service';
import { Component } from '@angular/core';
import { MatCardImage } from '@angular/material/card';
import { HttpClient } from '@angular/common/http';


@Component({
  selector: 'app-trangchu',
  standalone: true,
  imports: [MatCardImage],
  templateUrl: './trangchu.component.html',
  styleUrl: './trangchu.component.css'
})
export class TrangchuComponent {
  constructor(private bacsiService : BacsiService){}

  tongBacSi: number = 0;
  tongTienSi: number = 0;
  tongThacSi: number = 0;
  tongPSG_TS: number = 0;

  ngOnInit() {
    this.getTongBacSi();
    this.getTongPGS_GS();
    this.getTongThacSi();
    this.getTongTienSi();
  }

  getTongBacSi(){
    this.bacsiService.getTongBacSi().subscribe(sum=>{
      this.tongBacSi = sum;
    })
  }

  getTongTienSi(){
    this.bacsiService.getTongTienSi().subscribe(sum=>{
      this.tongTienSi = sum;
    })
  }

  getTongThacSi(){
    this.bacsiService.getTongThacSi().subscribe(sum=>{
      this.tongThacSi = sum;
    })
  }

  getTongPGS_GS(){
    this.bacsiService.getTongGSvaPGS().subscribe(sum=>{
      this.tongPSG_TS = sum;
    })
  }

}
