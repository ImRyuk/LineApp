import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-hours',
  templateUrl: './hours.component.html',
  styleUrls: ['./hours.component.css']
})
export class HoursComponent implements OnInit {
  @Input()  day: String;
  @Input()  hours: String;
  @Input()  form: FormGroup;
 jour: String;
  constructor(
    private formBuilder: FormBuilder
  ) { 
  
  }

  ngOnInit(): void {

    if(this.day=='monday') this.jour='Lundi'
    if(this.day=='tuesday') this.jour='Mardi'
    if(this.day=='wednesday') this.jour='Mercredi'
    if(this.day=='thursday') this.jour='Jeudi'
    if(this.day=='friday') this.jour='Vendredi'
    if(this.day=='saturday') this.jour='Samedi'
    if(this.day=='sunday') this.jour='Dimanche'

  }


}
