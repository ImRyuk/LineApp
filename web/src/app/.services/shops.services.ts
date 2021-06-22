import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import {Shop} from '../.models/shop.model'
import { UserService } from './user.services';
import { Reward } from '../.models/reward.model';
import { TypeOfShop } from '../.models/typeOfShop.model';

@Injectable({
    providedIn: 'root'
  })
export class ShopsService {

    shopList: any;
  
  constructor(
    private route: ActivatedRoute,
    private router: Router,
	private httpClient: HttpClient,
    private userService: UserService
  ) { }


getAllShops() {
    const headers = new HttpHeaders({'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
        })
        var shopList: Array<Shop> = [];
    return new Promise((resolve) => {
        this.httpClient.get('http://localhost:3000/shops',{headers}).subscribe(results => {
        for(var i=0; i<Object.keys(results).length;i++) {
            shopList.push(new Shop().deserialize(results[i]));
        }
        resolve(shopList);
    }, error => {
      console.log(error);
      resolve(false)
      });
    });
     
}

getShopById(id) {
    return new Promise((resolve) => {
        const headers = new HttpHeaders({})
        this.httpClient.get('http://localhost:3000/shops/'+id,{headers} ).subscribe(results => {
       
            resolve(new Shop().deserialize(results));
            //return new Shop().deserialize(results);

        }, error => {
            resolve(false);
        }); 
    });
}

getShopListByUserId(userId) {
    return new Promise((resolve) => {
        const headers = new HttpHeaders({})
        var shopList: Array<Shop> = [];
        this.httpClient.get('http://localhost:3000/users/'+userId+"/shops",{headers} ).subscribe(results => {
            for(var i=0; i<Object.keys(results).length;i++) {
                shopList.push(new Shop().deserialize(results[i]));
            }
            console.log(shopList);
            resolve(shopList);
        }, error => {
            resolve(false);
        }); 
    });
}



updateShop(updatedShop) {

    const headers = new HttpHeaders({})
    return new Promise((resolve) => {
        this.httpClient.put('http://localhost:3000/shops/'+updatedShop._id,updatedShop,{headers}).subscribe(results => {
            console.log(results) ;
            resolve(true);
        }, error => {
            console.log(error);
            resolve(false)
        });
    });

}

validateShop(shopId) {
    const headers = new HttpHeaders({})
    return new Promise((resolve) => {
        this.httpClient.post('http://localhost:3000/admin/shops/'+shopId+'/verify/',{headers}).subscribe(results => {
            console.log(results) ;
            resolve(true);
        }, error => {
            console.log(error);
            resolve(false)
        });
    });
  
}

createShop(newShop) {

    const headers = new HttpHeaders({})
    return new Promise((resolve) => {
        this.httpClient.post('http://localhost:3000/shops',newShop,{headers}).subscribe(results => {
            console.log(results) ;
            resolve(true);
        }, error => {
            console.log(error);
            resolve(false)
        });
    });

}


getSecteurList() {
    return new TypeOfShop().list;
}

getRewardList() {
    return new Reward().rewardList;
   
}


/////////

getAllVisits() {
    const headers = new HttpHeaders({})
    return new Promise((resolve) => {
        this.httpClient.get('http://localhost:3000/visits',{headers}).subscribe(results => {
            console.log(results) ;
            resolve(results);
        }, error => {
            console.log(error);
            resolve(false)
        });
    });
}
    getShopVisits() {
        //??
        return {
            0:1,
            1:1,
            2:1,
            3:1,
            4:1,
            5:1,
            6:1,
            7:1,
            8:1,
            9:1,
            10:2,
            11:5,
            12:1,
            13:4,
            14:1,
            15:1,
            16:1,
            17:1,
            18:1,
            19:1,
            20:1,
            21:1,
            22:1,
            23:1,

        }
    }

 

}
