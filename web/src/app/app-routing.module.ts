import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { SignupComponent } from './signup/signup.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { NewShopComponent } from './new-shop/new-shop.component';
import { ShopDetailComponent } from './shop-detail/shop-detail.component';
import { ModifyShopComponent } from './modify-shop/modify-shop.component';

const routes: Routes = [
  { path: '', component: DashboardComponent },
  { path: 'login', component: LoginComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'newshop', component: NewShopComponent },
  { path: 'modify/:id', component: ModifyShopComponent },
  { path: 'detail/:id', component: ShopDetailComponent },
  
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }


