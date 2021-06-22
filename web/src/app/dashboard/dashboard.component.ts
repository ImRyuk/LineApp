import { KeyValue } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {Shop} from '../.models/shop.model'
import { LoginService } from '../.services/login.services';
import { ShopsService } from '../.services/shops.services';
import { UserService } from '../.services/user.services';
@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  shopList: any;
  shops=[];
  requests=[];
  
  constructor(
    private shopService: ShopsService,
    public loginService : LoginService,
    private userService: UserService
  ) {
    console.log(this.loginService.getCurrentUser());
    this.getShops();

   
   }

  ngOnInit(): void {
  }

  async getShops() {
    this.shopList = await this.shopService.getShopListByUserId(this.loginService.getCurrentUser()._id);
    for(var i=0; i<this.shopList.length; i++) {
      if(this.shopList[i].verified == 'true') {
        this.shops.push(this.shopList[i]);
      } else {
        this.requests.push(this.shopList[i]);
      }
    }
  }

}
