import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final String? id;
  final bool? verified;
  final String? siretNumber;
  final String? name;
  final Map<String, dynamic>? location;
  final String? merchantId;
  final String? type;
  final Map<String, dynamic>? hours;
  final String? reward;

  const Shop({
    this.id,
    this.verified,
    this.siretNumber,
    this.location,
    this.merchantId,
    this.name,
    this.type,
    this.hours,
    this.reward,
  });

  Shop copyWith(
      {String? id,
      bool? verified,
      String? siretNumber,
      String? name,
      Map<String, dynamic>? location,
      String? merchantId,
      String? type,
      Map<String, dynamic>? hours,
      String? reward}) {
    return Shop(
      id: id ?? this.id,
      verified: verified ?? this.verified,
      siretNumber: siretNumber ?? this.siretNumber,
      name: name ?? this.name,
      location: location ?? this.location,
      merchantId: merchantId ?? this.merchantId,
      type: type ?? this.type,
      hours: hours ?? this.hours,
      reward: reward ?? this.reward,
    );
  }

  Shop.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        verified = json['verified'],
        siretNumber = json['siret_number'],
        name = json['name'],
        location = json['location'],
        merchantId = json['merchant'],
        type = json['type'],
        hours = json['hours'],
        reward = json['reward'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'verified': verified,
        'siret_number': siretNumber,
        'name': name,
        'location': location,
        'merchant': merchantId,
        'type': type,
        'hours': hours,
        'reward': reward
      };

  @override
  String toString() {
    return 'Shop { id: $id,' +
        ' | name: $name' +
        ' | location: $location ' +
        ' | reward: $reward ' +
        ' | type: $hours }';
  }

  @override
  List<Object?> get props => [
        this.id,
        this.verified,
        this.siretNumber,
        this.location,
        this.merchantId,
        this.name,
        this.type,
        this.hours,
      ];
}
