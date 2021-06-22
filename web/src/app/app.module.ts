import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { HeaderComponent } from './header/header.component';
import { LoginComponent } from './login/login.component';
import { AppRoutingModule } from './app-routing.module';
import { SignupComponent } from './signup/signup.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { SideMenuComponent } from './side-menu/side-menu.component';
import { NewShopComponent } from './new-shop/new-shop.component';
import { ShopDetailComponent } from './shop-detail/shop-detail.component';
import { ShopsService } from './.services/shops.services';
import { UserService } from './.services/user.services';
import { LoginService } from './.services/login.services';
import { HttpClientModule } from '@angular/common/http';
import { FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HoursComponent } from './new-shop/hours/hours.component';
import { ModifyShopComponent } from './modify-shop/modify-shop.component';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    LoginComponent,
    SignupComponent,
    DashboardComponent,
    SideMenuComponent,
    NewShopComponent,
    ShopDetailComponent,
    HoursComponent,
    ModifyShopComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  providers: [
    ShopsService, 
    UserService,
    LoginService,
    FormBuilder
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
