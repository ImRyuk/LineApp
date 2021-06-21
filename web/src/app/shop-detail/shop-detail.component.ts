import { KeyValue } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import {Shop} from '../.models/shop.model'
import { User } from '../.models/user.model';
import { ShopsService } from '../.services/shops.services';
import { UserService } from '../.services/user.services';

@Component({
  selector: 'app-shop-detail',
  templateUrl: './shop-detail.component.html',
  styleUrls: ['./shop-detail.component.css']
})
export class ShopDetailComponent implements OnInit {

  owner: any;
  originalOrder = (a: KeyValue<number,string>, b: KeyValue<number,string>): number => {return 0;}
  visits: any;
  reward: String;
  shop:any;

  constructor(
    private route: ActivatedRoute,
    private shopService: ShopsService,
    private userService: UserService
  ) {
    this.route.params.subscribe(routeParams => {this.getShop(routeParams.id)});
  }

  ngOnInit(): void {
    
  }

  async getShop(id) {
    this.shop = await this.shopService.getShopById(id);
    console.log(this.shop)
    this.owner = await this.userService.getUserById(this.shop.merchant);
    //??
    this.reward = this.shopService.getShopReward(this.shop._id);
    this.visits = this.shopService.getShopVisits();
  }


showValue(event) {
  document.getElementById('graph-'+event.target.id).style.backgroundColor='#4CC9F0';
  document.getElementById('value-'+event.target.id).style.visibility='visible';
}

hideValue(event) {
  document.getElementById('graph-'+event.target.id).style.backgroundColor='#F72585';
  document.getElementById('value-'+event.target.id).style.visibility='hidden';
}
  

changeReward() {
  var showReward = document.getElementById('show-reward');
  var selectReward = document.getElementById('select-reward');
  var buttonReward = document.getElementById('button-reward');
  if(buttonReward.getAttribute('value') == 'modifier') {
    showReward.style.display='none';
    selectReward.style.display='block';
    buttonReward.setAttribute('value', 'valider');
  } else {
    //this.shopService.updateShopReward()
    showReward.style.display='block';
    selectReward.style.display='none';
    buttonReward.setAttribute('value', 'modifier');
  }
}

}
