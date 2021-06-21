import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import {Shop} from '../.models/shop.model'
import {User} from '../.models/user.model'
@Injectable({
    providedIn: 'root'
  })
export class UserService {
    shopList: Array<Shop>;
    users = [
        {
            id : '1',
            roles: 'ROLE_MERCHANT',
            first_name: 'Michel',
            last_name: 'Dupont',
            email: 'michel.dupont@gmail.com',
            password: 'test',
         },
         {
            id : '2',
            roles: 'ROLE_MERCHANT',
            first_name: 'Robert',
            last_name: 'Duchamp',
            email: 'robert.duchamp@gmail.com',
            password: 'test',
         },
         {
            id : '3',
            roles: 'ROLE_ADMIN',
            first_name: 'Roger',
            last_name: 'Delarivière',
            email: 'roger.delariviere@gmail.com',
            password: 'test',
         }
    ]

    userList:any;
  constructor(
    private route: ActivatedRoute,
    private router: Router,
	private httpClient: HttpClient
  ) { }

    getUserById(id) {
        const headers = new HttpHeaders({})
        return new Promise((resolve) => {
          this.httpClient.get('http://localhost:3000/users/'+id,{headers} ).subscribe(results => {
              console.log(results);
              resolve(new User().deserialize(results));

          }); 
        });
    }

    createUser(user) {
      const headers = new HttpHeaders({})
      return new Promise((resolve) => {
        this.httpClient.post('http://localhost:3000/register',user,{headers} ).subscribe(results => {
          resolve(true)
        }, error => {
          console.log(error);
          resolve(false)
        });
      });

    }

    getAllUsers() {
      const headers = new HttpHeaders({})
      return new Promise((resolve) => {
        this.httpClient.get('http://localhost:3000/users',{headers} ).subscribe(results => {
        this.userList = results;
        console.log(results)
        resolve(true);
      }, error => {
        console.log(error);
        resolve(false)
        });
      });

    }

    async getUserByEmail(email) {
        await this.getAllUsers();
        return new User().deserialize(this.userList.find(user => user.mail==email));
    }

}
