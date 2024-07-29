import { Component } from '@angular/core';
import { CardDatlichComponent } from "../card-datlich/card-datlich.component";
@Component({
  selector: 'app-datlich',
  standalone: true,
  imports: [CardDatlichComponent],
  templateUrl: './datlich.component.html',
  styleUrl: './datlich.component.css'
})
export class DatlichComponent {

}
