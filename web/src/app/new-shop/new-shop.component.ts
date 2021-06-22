import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginService } from '../.services/login.services';
import { ShopsService } from '../.services/shops.services';

@Component({
  selector: 'app-new-shop',
  templateUrl: './new-shop.component.html',
  styleUrls: ['./new-shop.component.css']
})
export class NewShopComponent implements OnInit {

  days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
  hoursList: Array<Number> = [];
  
  
  newShopForm: FormGroup
  rewardList: Array<String>;
  secteurList: Array<String>;
  constructor(
    private formBuilder: FormBuilder,
    private loginService: LoginService,
    private shopService :ShopsService,
    private router: Router,
  ) { 
    for(var i=0;i<24;i++) {
      this.hoursList.push(i);
    }
    this.rewardList = this.shopService.getRewardList();
    this.secteurList = this.shopService.getSecteurList();
  }

  ngOnInit(): void {
    this.newShopForm = this.formBuilder.group({
      name: ['', Validators.required ],
      siret_number: ['' , Validators.required],
      shopowner: ['' ],
      reward: [this.rewardList[0] ],
      phone: ['' ],
      address: ['' , Validators.required],
      city: ['', Validators.required ],
      zip_code: ['', Validators.required ],
      description : ['' ],
      secteur : [this.secteurList[0] ],
      hours: this.formBuilder.group({
        'monday': ['' ],
        'monday-coupure': ['' ],
        'monday-choice-1': [this.hoursList[8] ],
        'monday-choice-2': [this.hoursList[12] ],
        'monday-choice-3': [this.hoursList[14] ],
        'monday-choice-4': [this.hoursList[18] ],
  
        'tuesday': ['' ],
        'tuesday-coupure': ['' ],
        'tuesday-choice-1': [this.hoursList[8] ],
        'tuesday-choice-2': [this.hoursList[12] ],
        'tuesday-choice-3': [this.hoursList[14] ],
        'tuesday-choice-4': [this.hoursList[18] ],
  
        'wednesday': ['' ],
        'wednesday-coupure': ['' ],
        'wednesday-choice-1': [this.hoursList[8] ],
        'wednesday-choice-2': [this.hoursList[12] ],
        'wednesday-choice-3': [this.hoursList[14] ],
        'wednesday-choice-4': [this.hoursList[18] ],
  
        'thursday': ['' ],
        'thursday-coupure': ['' ],
        'thursday-choice-1': [this.hoursList[8] ],
        'thursday-choice-2': [this.hoursList[12] ],
        'thursday-choice-3': [this.hoursList[14] ],
        'thursday-choice-4': [this.hoursList[18] ],
  
        'friday': ['' ],
        'friday-coupure': ['' ],
        'friday-choice-1': [this.hoursList[8] ],
        'friday-choice-2': [this.hoursList[12] ],
        'friday-choice-3': [this.hoursList[14] ],
        'friday-choice-4': [this.hoursList[18] ],
  
        'saturday': ['' ],
        'saturday-coupure': ['' ],
        'saturday-choice-1': [this.hoursList[8] ],
        'saturday-choice-2': [this.hoursList[12] ],
        'saturday-choice-3': [this.hoursList[14] ],
        'saturday-choice-4': [this.hoursList[18] ],
  
        'sunday': ['' ],
        'sunday-coupure': ['' ],
        'sunday-choice-1': [this.hoursList[8]],
        'sunday-choice-2': [this.hoursList[12]],
        'sunday-choice-3': [this.hoursList[14] ],
        'sunday-choice-4': [this.hoursList[18] ],
      })
  

    });
  }
    // convenience getter for easy access to form fields
    get f() { return this.newShopForm.controls; }

formatHours() {
  var hoursResult = {
    monday:[],tuesday:[],wednesday:[],thursday:[],friday:[],saturday:[],sunday:[],
  }

  this.days.forEach(day => {
    if(this.f.hours.value[day]==true && this.f.hours.value[day+"-choice-1"]!='' && this.f.hours.value[day+"-choice-2"]!='') {
      hoursResult[day].push(this.f.hours.value[day+"-choice-1"], this.f.hours.value[day+"-choice-2"])
     }
     if(this.f.hours.value[day+"-coupure"]==true && this.f.hours.value[day+"-choice-3"]!='' && this.f.hours.value[day+"-choice-4"]!='') {
      hoursResult[day].push(this.f.hours.value[day+"-choice-3"], this.f.hours.value[day+"-choice-4"])
      }
  });
    console.log(hoursResult);
    return hoursResult;
}

  onSubmit() {
    console.log(this.newShopForm);
    if (this.newShopForm.invalid) {
      console.log('ici')
      return;
    }
    var address_name = '';
    for(var i=1; i<this.f.address.value.split(' ').length;i++) {
      address_name+=this.f.address.value.split(' ')[i]+' ';
    }
    
    
    var number_address = this.f.address.value.split(' ')[0];
    var id_user = this.loginService.getCurrentUser()._id;
  
    var shop = {
      // shopowner: this.f.shopowner.value,
      reward: this.f.reward.value,
      phone_number:this.f.phone.value,
      description:this.f.description.value,
      hours: this.formatHours(),
      adress_name: this.f.address.value,
      city: this.f.city.value,
      zip_code: this.f.zip_code.value,
      merchant:id_user,
      name: this.f.name.value,
      siret_number: this.f.siret_number.value,
      type:this.f.secteur.value,
    }
 

    console.log(shop);
    if(this.shopService.createShop(shop)) {
      this.router.navigate(['/']);
    } else {
      //Error
    }
 
    
  }

}
