import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Shop } from '../.models/shop.model';
import { LoginService } from '../.services/login.services';
import { ShopsService } from '../.services/shops.services';

@Component({
  selector: 'app-side-menu',
  templateUrl: './side-menu.component.html',
  styleUrls: ['./side-menu.component.css']
})
export class SideMenuComponent implements OnInit {
  
  shopList: any;
  shops=[];
  requests=[];
  
  constructor(
    private router: Router,
    private shopService: ShopsService,
    private loginService: LoginService
  ) {
    this.getShops();
   }

  ngOnInit(): void {

  }

  async getShops(){
    if(this.loginService.getCurrentUser().roles[0]=='ROLE_MERCHANT')
      this.shopList = await this.shopService.getShopListByUserId(this.loginService.getCurrentUser()._id);
    else
      this.shopList = await this.shopService.getAllShops();
    for(var i=0; i<this.shopList.length; i++) {
      if(this.shopList[i].verified == true) {
        this.shops.push(this.shopList[i]);
      } else {
        this.requests.push(this.shopList[i]);
      }
    }
  }


}
