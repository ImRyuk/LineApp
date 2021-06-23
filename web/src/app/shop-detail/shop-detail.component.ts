import { KeyValue } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import {Shop} from '../.models/shop.model'
import { User } from '../.models/user.model';
import { LoginService } from '../.services/login.services';
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
  rewardList: Array<String>;
  rewardForm: FormGroup
  currentUserRole:any;
  maxValue:any;
  constructor(
    private route: ActivatedRoute,
    private formBuilder: FormBuilder,
    private shopService: ShopsService,
    private userService: UserService,
    private loginService: LoginService
  ) {
    this.route.params.subscribe(routeParams => {this.getShop(routeParams.id)});
    this.rewardList = this.shopService.getRewardList();
   
    this.currentUserRole= this.loginService.getRole();



  }
  getScreenWidth() {
    return window.innerWidth || document.documentElement.clientWidth || document.getElementsByTagName('body')[0].clientWidth;
  }
  ngOnInit(): void {
    
  }
  // convenience getter for easy access to form fields
  get f() { return this.rewardForm.controls; }

  async getShop(id) {
    this.shop = await this.shopService.getShopById(id);
    console.log(this.shop);
    this.rewardForm = this.formBuilder.group({
      reward: [this.shop.reward!='' ? this.shop.reward : '']
    })
    this.owner = await this.userService.getUserById(this.shop.merchant);

    this.visits = this.shopService.getShopVisits();
    this.getMaxValue();

    console.log(this.getDay());
    console.log(this.shop.hours);
    console.log(this.shop.hours[this.getDay()])
 
  }

  graph(visit) {
    
    if( visit<this.shop.hours[this.getDay()][0] ||
        visit>this.shop.hours[this.getDay()][Object.keys(this.shop.hours[this.getDay()]).length-1]
      ) {
        return false
      
    } else if(this.shop.hours[this.getDay()].length>2 && 
              (visit > this.shop.hours[this.getDay()][1] && visit < this.shop.hours[this.getDay()][2])
      ){
        // console.log(this.shop.hours[this.getDay()][1])
      return false
    } else {
      return true;
    }
  }

  getDay() {
    switch (new Date().getDay()) {
      case 0:
        return 'sunday';
      case 1:
        return 'monday';
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
    }
    
  }

    getMaxValue() {
      var keys = Object.keys(this.visits);
      var min = this.visits[keys[0]]; // ignoring case of empty list for conciseness
      var max = this.visits[keys[0]];
      var i;

      for (i = 1; i < keys.length; i++) {
          var value = this.visits[keys[i]];
          if (value < min) min = value;
          if (value > max) max = value;
      }
      this.maxValue = max;
      console.log(max);
    }
  async validateShop(shopId) {
    var shop = await this.shopService.validateShop(shopId);
    if(shop) location.reload();
    //else error
  }

showValue(event) {
  if(document.getElementById('graph-'+event.target.id)!=null) {
        document.getElementById('graph-'+event.target.id).style.backgroundColor='#4CC9F0';
        document.getElementById('value-'+event.target.id).style.visibility='visible';
        document.getElementById('hour-'+event.target.id).style.visibility='visible';
  }

}

hideValue(event) {
  if(document.getElementById('graph-'+event.target.id)!=null) {
  document.getElementById('graph-'+event.target.id).style.backgroundColor='#F72585';
    document.getElementById('value-'+event.target.id).style.visibility='hidden';
    console.log(Number(document.getElementById('hour-'+event.target.id).getAttribute('class').split('-')[0]))
    if(Number(document.getElementById('hour-'+event.target.id).getAttribute('class').split('-')[1])%2!=0)
      document.getElementById('hour-'+event.target.id).style.visibility='hidden';
  }
  
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
    if(this.shop.reward!=this.f.reward.value) {
      this.shop.reward = this.f.reward.value;
      this.shopService.updateShop(this.shop);
    }







    showReward.style.display='block';
    selectReward.style.display='none';
    buttonReward.setAttribute('value', 'modifier');
  }
}

}
