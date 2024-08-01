import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import {FormsModule} from '@angular/forms';
import {MatInputModule} from '@angular/material/input';
import {MatSelectModule} from '@angular/material/select';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatPaginatorModule} from '@angular/material/paginator';
import { BacsiService } from '../services/bacsi.service';


@Component({
  selector: 'app-bacsi',
  standalone: true,
  imports: [RouterLink, FormsModule, MatInputModule, MatFormFieldModule, MatSelectModule, MatPaginatorModule],
  templateUrl: './bacsi.component.html',
  styleUrl: './bacsi.component.css'
})
export class BacsiComponent {

  constructor(private bacsiService : BacsiService){}

  ListHocVi: any[] = [];
  ListHocHam: string[] = [];
  ListChucVu: string[] = [];
  ListBacSi: any[] = [];
  DanhHieu: string = "";

  ngOnInit() {
    this.getListHocVi();
    this.getListHocHam();
    this.getListChucVu();
    this.getListBacSi();
  }

  getListHocVi(){
    this.bacsiService.getListHocVi().subscribe((res:any)=>{
      this.ListHocVi = res;
    })
  }

  getListHocHam(){
    this.bacsiService.getListHocHam().subscribe((res:any)=>{
      this.ListHocHam = res;
    })
  }

  getListChucVu(){
    this.bacsiService.getListChucVu().subscribe((res:any)=>{
      this.ListChucVu = res;
    })
  }

  getListBacSi(){
    this.bacsiService.getAllDoctor().subscribe((res:any)=>{
        this.ListBacSi = res;
    })
  }

  getDanhHieu(id: string){
    this.bacsiService.getDanhHieu(id).subscribe(res => {
      this.DanhHieu = res;
    })
  }

}
