import { HttpHeaders, HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import {Shop} from '../.models/shop.model'
import {User} from '../.models/user.model'
import { ShopsService } from './shops.services';
import { UserService } from './user.services';
@Injectable({
    providedIn: 'root'
  })
export class LoginService {
    shopList: Array<Shop>;
    currentUser: User;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
	private httpClient: HttpClient,
  private shopsService : ShopsService,
  private userService : UserService
  ) { 
      
  }

  loginUser(mail, password) {
    const headers = new HttpHeaders({})
    return new Promise((resolve) => {
      var params = new HttpParams().append('mail', mail).append('password', password);
  
      console.log(params);
      this.httpClient.get('http://localhost:3000/login',{headers, params} ).subscribe(results => {
          console.log(results);
          this.setCurrentUser(new User().deserialize(results))
          resolve(true);

      }); 
    });
}

// '{ headers?: HttpHeaders | { [header: string]: string | string[]; }; observe?: "body"; params?: HttpParams | { [param: string]: string | string[]; }; reportProgress?: boolean; responseType?: "json"; withCredentials?: boolean; }'.

  async checkEmailAndPassword(email, password) {
      var user = await this.userService.getUserByEmail(email);
      if(user.mail == email /*&& user.password==password*/) {
        this.setCurrentUser(user);
        return true;
      }
      else return false;
  }

  

  setCurrentUser(currentUser) {
     sessionStorage.setItem('currentUser', JSON.stringify(currentUser));
     sessionStorage.setItem('isConnected', 'true');
  }

  getCurrentUser() {
    return JSON.parse(sessionStorage.getItem('currentUser'));
  }

  checkConnectedState() {
      return sessionStorage.getItem('isConnected') ? true : false;
  }


  getCurrentUserRole() {
    return JSON.parse(sessionStorage.getItem('currentUser')).roles;
  }

  disconnect() {
      sessionStorage.removeItem('isConnected');
      sessionStorage.clear();

  }

   

}
