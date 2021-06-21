import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { User } from '../.models/user.model';
import { LoginService } from '../.services/login.services';
import { UserService } from '../.services/user.services';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {
  menu_item:String = "signup-page"
  signupForm: FormGroup

  constructor(
    private formBuilder: FormBuilder,
    private loginService: LoginService,
    private userService: UserService,
    private router: Router,
  ) { 
    this.signupForm = this.formBuilder.group({
      email: ['', Validators.required],
      name: ['', Validators.required],
      firstname: ['', Validators.required],
      password: ['', Validators.required],
      checkPassword: ['', Validators.required]
    });
  }

  ngOnInit(): void {
  }

  // convenience getter for easy access to form fields
  get f() { return this.signupForm.controls; }

  checkPassword(password, checkPassword) {
    if(password==checkPassword) return true
    else return false;
  }

  onSubmit() {
  
    if (this.signupForm.invalid || !this.checkPassword(this.f.password.value, this.f.checkPassword.value)) {
      //toaster
      return;
    }

    var user = new User().deserialize({
      firstname : this.f.firstname.value,
      lastname: this.f.name.value,
      mail: this.f.email.value,
      password: this.f.password.value,

    })
    

    if(user) {
      this.loginService.setCurrentUser(this.userService.getUserByEmail(user.mail));
      this.router.navigate(['/']);
    } else {
      //toaster
    }
    

    
  }

}
