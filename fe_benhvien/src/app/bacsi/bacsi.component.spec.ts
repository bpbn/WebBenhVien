import { ComponentFixture, TestBed } from '@angular/core/testing';
import { BacsiComponent } from './bacsi.component';


describe('BacsiComponent', () => {
  let component: BacsiComponent;
  let fixture: ComponentFixture<BacsiComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BacsiComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BacsiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
