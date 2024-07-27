import { Component } from '@angular/core';
import {ChangeDetectionStrategy, model} from '@angular/core';
import {MatCardModule} from '@angular/material/card';
import {provideNativeDateAdapter} from '@angular/material/core';
import {MatDatepickerModule} from '@angular/material/datepicker';

@Component({
  selector: 'app-ctbacsi',
  standalone: true,
  imports: [MatCardModule, MatDatepickerModule],
  providers: [provideNativeDateAdapter()],
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './ctbacsi.component.html',
  styleUrl: './ctbacsi.component.css'
})
export class CtbacsiComponent {
  selected = model<Date | null>(null);
}
