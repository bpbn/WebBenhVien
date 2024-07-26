import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CtbacsiComponent } from './ctbacsi.component';

describe('CtbacsiComponent', () => {
  let component: CtbacsiComponent;
  let fixture: ComponentFixture<CtbacsiComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CtbacsiComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CtbacsiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
