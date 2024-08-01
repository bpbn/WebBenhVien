import { Routes } from '@angular/router';
import { TrangchuComponent } from './trangchu/trangchu.component';
import { BacsiComponent } from './bacsi/bacsi.component';
import { CtbacsiComponent } from './ctbacsi/ctbacsi.component';
import { DatlichComponent } from './datlich/datlich.component';

export const routes: Routes = [
    {path: 'home', title: 'Trang chủ', component: TrangchuComponent },
    {path: 'bacsi', title: 'Bác sĩ', component: BacsiComponent },
    {path: 'ctbacsi', title: 'Thông tin bác sĩ', component: CtbacsiComponent },
    {path: '', redirectTo: '/home', pathMatch: 'full'},
    {path: 'datlich', title: 'Đặt lịch hẹn', component: DatlichComponent },
];
