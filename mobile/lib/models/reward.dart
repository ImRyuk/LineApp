import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? qrCode;
  final String? idShop;

  const Reward({
    this.id,
    this.name,
    this.description,
    this.qrCode,
    this.idShop,
  });

  Reward copyWith({
    int? id,
    String? name,
    String? description,
    String? qrCode,
    String? idShop,
  }) {
    return Reward(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      qrCode: qrCode ?? this.qrCode,
      idShop: idShop ?? this.idShop,
    );
  }

  Reward.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        qrCode = json['qrCode'],
        idShop = json['idShop'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'qrCode': qrCode,
        'idShop': idShop,
      };

  @override
  String toString() {
    return 'Reward { id: $id,' + ' | name: $name' + ' | address: $description}';
  }

  @override
  List<Object?> get props => [
        this.id,
        this.name,
        this.description,
        this.qrCode,
        this.idShop,
      ];
}
