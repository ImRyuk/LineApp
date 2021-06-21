import { Component } from '@angular/core';
import { Shop } from './.models/shop.model';
import {ShopsService} from './.services/shops.services'
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'line-v1';
  shopList: Array<Shop>;
  constructor(
    shopService: ShopsService
  ) {
    
    // shopService.setShopListInStorage();
   
  }
}
