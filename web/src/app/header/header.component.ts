import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LoginService } from '../.services/login.services';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  @Input()  menu_item: String;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    public loginService: LoginService
  ) { 
   
   

  }

  ngOnInit(): void {
    console.log(this.loginService.checkConnectedState());
  }

  goToLogin() {
    this.loginService.disconnect();
    this.router.navigate(['/login']);
  }

  goToDashboard() {
    if(this.loginService.checkConnectedState()) {
      this.router.navigate(['/']);
    } else {
      this.router.navigate(['/login']);
    }
  }
}
