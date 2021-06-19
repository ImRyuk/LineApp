import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final int? id;
  final String? verified;
  final String? name;
  final String? city;
  final String? address;
  final String? logoUrl;
  final List<double>? position;
  final int? idUser;
  final String? type;
  final List<DateTime>? hours;

  const Shop({
    this.id,
    this.verified,
    this.name,
    this.city,
    this.address,
    this.logoUrl,
    this.position,
    this.idUser,
    this.type,
    this.hours,
  });

  Shop copyWith(
      {int? id,
      String? verified,
      String? name,
      String? city,
      String? address,
      String? logoUrl,
      List<double>? position,
      int? idUser,
      String? type,
      List<DateTime>? hours}) {
    return Shop(
      id: id ?? this.id,
      verified: verified ?? this.verified,
      name: name ?? this.name,
      city: city ?? this.city,
      address: address ?? this.address,
      logoUrl: logoUrl ?? this.logoUrl,
      position: position ?? this.position,
      idUser: idUser ?? this.idUser,
      type: type ?? this.type,
      hours: hours ?? this.hours,
    );
  }

  Shop.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        verified = json['verified'],
        name = json['name'],
        city = json['city'],
        address = json['address'],
        logoUrl = json['logoUrl'],
        position = json['position'],
        idUser = json['idUser'],
        type = json['type'],
        hours = json['hours'];

    Map<String, dynamic> toJson() => {
        'id': id,
        'verified': verified,
        'name': name,
        'city': city,
        'address': address,
        'logoUrl': logoUrl,
        'position': position,
        'idUser': idUser,
        'type': type,
        'hours': hours
      };

  @override
  String toString() {
    return 'Shop { id: $id,' + ' | name: $name' + ' | address: $address}';
  }

  @override
  List<Object?> get props => [
        this.id,
        this.verified,
        this.name,
        this.city,
        this.address,
        this.logoUrl,
        this.position,
        this.idUser,
        this.type,
        this.hours,
      ];
}
