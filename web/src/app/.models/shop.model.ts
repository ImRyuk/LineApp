import {Deserializable} from "./deserializable.model";

export class Hours {
    monday:Array<Number>;
    tuesday:Array<Number>;
    wednesday:Array<Number>;
    thursday:Array<Number>;
    friday:Array<Number>;
    saturday:Array<Number>;
    sunday:Array<Number>;
}

  export class Shop implements Deserializable {
    id:String; 
    verified:String;  
    siret_number:String;
    name:String;
    address_name:String; 
    number_address:String;  
    zip_code:String;
    position:String;
    id_user:String;
    type:String;  
    //???
    city?: String;
    phone?:String;
    description?:String;
    hours:Hours;
    shopowner: String;
  
    deserialize(input: any) {
      Object.assign(this, input);
      return this;
    }
  }