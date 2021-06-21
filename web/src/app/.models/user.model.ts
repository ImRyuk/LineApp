import {Deserializable} from "./deserializable.model";



  export class User implements Deserializable {
    id : String;
    roles: String;
    firstname: String;
    lastname: String;
    mail: String;
    password: String;
    
  
    deserialize(input: any) {
      Object.assign(this, input);
      return this;
    }
  }