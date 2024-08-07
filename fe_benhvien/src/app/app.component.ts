import { FormsModule } from '@angular/forms';
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from './navbar/navbar.component';
import { TrangchuComponent } from "./trangchu/trangchu.component";
import { FooterComponent } from "./footer/footer.component";


@Component({
  selector: 'app-root',
  standalone: true,
  imports: [ FormsModule, RouterOutlet, NavbarComponent, TrangchuComponent, FooterComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Bệnh viện bệnh nhiệt đới';
}
