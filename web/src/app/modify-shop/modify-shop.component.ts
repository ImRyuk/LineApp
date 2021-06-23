import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Shop } from '../.models/shop.model';
import { User } from '../.models/user.model';
import { Reward } from '../.models/reward.model';
import { LoginService } from '../.services/login.services';
import { ShopsService } from '../.services/shops.services';
import { UserService } from '../.services/user.services';

@Component({
  selector: 'app-modify-shop',
  templateUrl: './modify-shop.component.html',
  styleUrls: ['./modify-shop.component.css']
})
export class ModifyShopComponent implements OnInit {

  days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
  hoursList: Array<Number> = [];
  newShopForm: FormGroup
  owner: any;
  shop: any;
  rewardList: Array<String>;
  secteurList: Array<String>;
  constructor(
    private formBuilder: FormBuilder,
    private loginService: LoginService,
    private route: ActivatedRoute,
    private shopService: ShopsService,
    private userService: UserService,
    private router: Router
  ) {
    for(var i=0;i<24;i++) {
      this.hoursList.push(i);
    }
    this.rewardList = this.shopService.getRewardList();
      this.secteurList = this.shopService.getSecteurList();

   }

  ngOnInit(): void {

    this.route.params.subscribe(routeParams => {
      this.getShop(routeParams.id)
        });

    
  }

  async getShop(id) {
    this.shop = await this.shopService.getShopById(id);
    console.log(this.shop)
    this.owner = await this.userService.getUserById(this.shop.merchant);
    this.buildForm();
  }

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

    // convenience getter for easy access to form fields
    get f() { return this.newShopForm.controls; }

  onSubmit() {
    if (this.newShopForm.invalid) {
      console.log('invalid')
      return;
    }

    var id_user = this.loginService.getCurrentUser()._id;
    
    var shop = {
      reward: this.f.reward.value,
      //shopowner: this.f.shopowner.value,
      description:this.f.description.value,
      phone_number:this.f.phone.value,

      _id:this.shop._id,
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
    if(this.shopService.updateShop(shop)) {
      this.router.navigate(['/detail/'+shop._id]);
    }
 
    
  }

  buildForm() {
    this.newShopForm = this.formBuilder.group({
      name: [this.shop.name, Validators.required  ],
      siret_number: [this.shop.siret_number, Validators.required  ],
      shopowner: [this.owner.firstname+' '+this.owner.lastname  ],
      reward: [this.shop.reward ],
      phone: [this.shop.phone_number ? this.shop.phone_number : ''  ],
      address: [this.shop.location.streetNumber+' '+this.shop.location.streetName, Validators.required  ],
      city: [this.shop.location.city , Validators.required ],
      zip_code: [this.shop.location.zipcode , Validators.required ],
      description : [this.shop.description ? this.shop.description : ''  ],
      secteur : [this.shop.type , Validators.required ],
      hours: this.formBuilder.group({
        'monday': [this.shop.hours.monday.length>0 ? true:''  ],
        'monday-coupure': [this.shop.hours.monday.length>2 ? true:''  ],
        'monday-choice-1': [this.shop.hours.monday[0] ? this.shop.hours.monday[0]:this.hoursList[8]  ],
        'monday-choice-2': [this.shop.hours.monday[1] ? this.shop.hours.monday[1]:this.hoursList[12]  ],
        'monday-choice-3': [this.shop.hours.monday[2] ? this.shop.hours.monday[2]:this.hoursList[14]  ],
        'monday-choice-4': [this.shop.hours.monday[3] ? this.shop.hours.monday[3]:this.hoursList[18]  ],
  
        'tuesday': [this.shop.hours.tuesday.length>0 ? true:''  ],
        'tuesday-coupure': [this.shop.hours.tuesday.length>2 ? true:''  ],
        'tuesday-choice-1': [this.shop.hours.tuesday[0] ? this.shop.hours.tuesday[0]:this.hoursList[8]  ],
        'tuesday-choice-2': [this.shop.hours.tuesday[1] ? this.shop.hours.tuesday[1]:this.hoursList[12]  ],
        'tuesday-choice-3': [this.shop.hours.tuesday[2] ? this.shop.hours.tuesday[2]:this.hoursList[14]  ],
        'tuesday-choice-4': [this.shop.hours.tuesday[3] ? this.shop.hours.tuesday[3]:this.hoursList[18]  ],
  
        'wednesday': [this.shop.hours.wednesday.length>0 ? true:''  ],
        'wednesday-coupure': [this.shop.hours.wednesday.length>2 ? true:''  ],
        'wednesday-choice-1': [this.shop.hours.wednesday[0] ? this.shop.hours.wednesday[0]:this.hoursList[8]  ],
        'wednesday-choice-2': [this.shop.hours.wednesday[1] ? this.shop.hours.wednesday[1]:this.hoursList[12]  ],
        'wednesday-choice-3': [this.shop.hours.wednesday[2] ? this.shop.hours.wednesday[2]:this.hoursList[14]  ],
        'wednesday-choice-4': [this.shop.hours.wednesday[3] ? this.shop.hours.wednesday[3]:this.hoursList[18]  ],
  
        'thursday': [this.shop.hours.thursday.length>0 ? true:''  ],
        'thursday-coupure': [this.shop.hours.thursday.length>2 ? true:''  ],
        'thursday-choice-1': [this.shop.hours.thursday[0] ? this.shop.hours.thursday[0]:this.hoursList[8]  ],
        'thursday-choice-2': [this.shop.hours.thursday[1] ? this.shop.hours.thursday[1]:this.hoursList[12]  ],
        'thursday-choice-3': [this.shop.hours.thursday[2] ? this.shop.hours.thursday[2]:this.hoursList[14]  ],
        'thursday-choice-4': [this.shop.hours.thursday[3] ? this.shop.hours.thursday[3]:this.hoursList[18]  ],
  
        'friday': [this.shop.hours.friday.length>0 ? true:''  ],
        'friday-coupure': [this.shop.hours.friday.length>2 ? true:''  ],
        'friday-choice-1': [this.shop.hours.friday[0] ? this.shop.hours.friday[0]:this.hoursList[8]  ],
        'friday-choice-2': [this.shop.hours.friday[1] ? this.shop.hours.friday[1]:this.hoursList[12]  ],
        'friday-choice-3': [this.shop.hours.friday[2] ? this.shop.hours.friday[2]:this.hoursList[14]  ],
        'friday-choice-4': [this.shop.hours.friday[3] ? this.shop.hours.friday[3]:this.hoursList[18]  ],
  
        'saturday': [this.shop.hours.saturday.length>0 ? true:''  ],
        'saturday-coupure': [this.shop.hours.saturday.length>2 ? true:''  ],
        'saturday-choice-1': [this.shop.hours.saturday[0] ? this.shop.hours.saturday[0]:this.hoursList[8]  ],
        'saturday-choice-2': [this.shop.hours.saturday[1] ? this.shop.hours.saturday[1]:this.hoursList[12]  ],
        'saturday-choice-3': [this.shop.hours.saturday[2] ? this.shop.hours.saturday[2]:this.hoursList[14]  ],
        'saturday-choice-4': [this.shop.hours.saturday[3] ? this.shop.hours.saturday[3]:this.hoursList[18]  ],
  
        'sunday': [this.shop.hours.sunday.length>0 ? true:''  ],
        'sunday-coupure': [this.shop.hours.sunday.length>2 ? true:''  ],
        'sunday-choice-1': [this.shop.hours.sunday[0] ? this.shop.hours.sunday[0]:this.hoursList[8]  ],
        'sunday-choice-2': [this.shop.hours.sunday[1] ? this.shop.hours.sunday[1]:this.hoursList[12]  ],
        'sunday-choice-3': [this.shop.hours.sunday[2] ? this.shop.hours.sunday[2]:this.hoursList[14]  ],
        'sunday-choice-4': [this.shop.hours.sunday[3] ? this.shop.hours.sunday[3]:this.hoursList[18]  ],
      })

    });
  }

}
