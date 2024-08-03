import { Component } from '@angular/core';
import {ChangeDetectionStrategy, model} from '@angular/core';
import {MatCardModule} from '@angular/material/card';
import {provideNativeDateAdapter} from '@angular/material/core';
import {MatDatepickerModule} from '@angular/material/datepicker';
import { CardDatlichComponent } from '../card-datlich/card-datlich.component';
import { BacsiService } from '../services/bacsi.service';
import { ActivatedRoute } from '@angular/router';
import { ChangeDetectorRef } from '@angular/core';
import { MbscEventcalendarView } from '@mobiscroll/angular';

@Component({
  selector: 'app-ctbacsi',
  standalone: true,
  imports: [MatCardModule, MatDatepickerModule, CardDatlichComponent],
  providers: [provideNativeDateAdapter()],
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './ctbacsi.component.html',
  styleUrl: './ctbacsi.component.css',
})
export class CtbacsiComponent {
  calView: MbscEventcalendarView = {
    schedule: {
      type: 'day'
    }
  };
  
  selected = model<Date | null>(null);

  constructor(
    private bacsiService : BacsiService,
    private route: ActivatedRoute,
    private cdRef: ChangeDetectorRef 
  ){}

  ttbacsi: any = {};
  id: string = "";
  ListDanhHieu: any[] = [];
  DanhHieu: string = "";
  ListGioiThieu: string[] = [];
  date: any[] = [];

  ngOnInit() {
    this.route.params.subscribe(param => {
      this.id = param['id'];
    })
    this.getTTBS();
    this.getListDanhHieu();
    this.getDanhHieuByMaNhanVien();
    this.getListGioiThieu()
    }

  getTTBS(){
    this.bacsiService.getBacSiByID(this.id).subscribe((res:any)=>{
      this.ttbacsi = res;
      this.cdRef.markForCheck();
    })
  }

  getListDanhHieu(){
    this.bacsiService.getListDanhHieu().subscribe((res:any)=>{
        this.ListDanhHieu = res;
    })
  }

  getDanhHieuByMaNhanVien() {
    const bacsi = this.ListDanhHieu.find(bs => bs.maNhanVien === this.id);
    if (bacsi && bacsi.danhHieu) {
      this.DanhHieu = bacsi.danhHieu;
    } else {
        this.DanhHieu = "";
    }
  }

  getListGioiThieu() {
    if (this.ttbacsi?.gioiThieu) {
      this.ListGioiThieu = this.ttbacsi.gioiThieu.split('\n');
    } else {
      this.ListGioiThieu = [];
    }
  }
  
}
