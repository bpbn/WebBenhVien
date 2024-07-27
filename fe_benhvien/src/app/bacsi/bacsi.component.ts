import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import {FormsModule} from '@angular/forms';
import {MatInputModule} from '@angular/material/input';
import {MatSelectModule} from '@angular/material/select';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatPaginatorModule} from '@angular/material/paginator';

interface Food {
  value: string;
  viewValue: string;
}

@Component({
  selector: 'app-bacsi',
  standalone: true,
  imports: [RouterLink, FormsModule, MatInputModule, MatFormFieldModule, MatSelectModule, MatPaginatorModule],
  templateUrl: './bacsi.component.html',
  styleUrl: './bacsi.component.css'
})
export class BacsiComponent {
  foods: Food[] = [
    {value: 'steak-0', viewValue: 'Steak'},
    {value: 'pizza-1', viewValue: 'Pizza'},
    {value: 'tacos-2', viewValue: 'Tacos'},
  ];
}
