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
    this.shopService.getAllVisits();

   
   }

  ngOnInit(): void {
  }

  async getShops() {
    console.log(this.loginService.getCurrentUser().roles[0])
    if(this.loginService.getCurrentUser().roles[0]=='ROLE_MERCHANT')
      this.shopList = await this.shopService.getShopListByUserId(this.loginService.getCurrentUser()._id);
    else
      this.shopList = await this.shopService.getAllShops();

      console.log(this.shopList)

    for(var i=0; i<this.shopList.length; i++) {
      if(this.shopList[i].verified == true) {
        this.shops.push(this.shopList[i]);
      } else {
        this.requests.push(this.shopList[i]);
      }
    }
  }

}
