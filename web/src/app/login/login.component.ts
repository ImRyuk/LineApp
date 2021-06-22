import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { LoginService } from '../.services/login.services';
import { UserService } from '../.services/user.services';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  menu_item:String = "login-page"
  loginForm: FormGroup
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private formBuilder: FormBuilder,
    private loginService: LoginService,
    private userService: UserService
  ) {
   }

  ngOnInit(): void {
    this.loginForm = this.formBuilder.group({
      email: ['', Validators.required],
      password: ['', Validators.required]
    });
  }
    // convenience getter for easy access to form fields
    get f() { return this.loginForm.controls; }

 async onSubmit() {
 
    if (this.loginForm.invalid) {
      //toaster ??
      return;
    }

   //remplacer par this.loginService.loginUser(this.f.email.value,this.f.password.value);
    if(await this.loginService.loginUser(this.f.email.value,this.f.password.value)) {
      this.router.navigate(['/']);
    } else {
      //toaster ?
    }
    
  }

}
