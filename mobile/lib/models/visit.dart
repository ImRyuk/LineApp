import 'package:equatable/equatable.dart';

class Visit extends Equatable {
  final String? id;
  final String? shopId;
  final DateTime? startDate;
  final DateTime? endDate;

  const Visit({
    this.id,
    this.shopId,
    this.startDate,
    this.endDate,
  });

  Visit copyWith(
      {String? id, String? shopId, DateTime? startDate, DateTime? endDate}) {
    return Visit(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Visit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        shopId = json['shop'],
        startDate = json['start'],
        endDate = json['end'];

  Map<String, dynamic> toJson() => {
        'shop': shopId,
        'start': startDate!.toIso8601String(),
        'end': endDate!.toIso8601String(),
      };

  @override
  String toString() {
    return 'Reward { id: $id,' +
        ' | shopId: $shopId' +
        ' | date: $startDate | $endDate}';
  }

  @override
  List<Object?> get props =>
      [this.id, this.shopId, this.startDate, this.endDate];
}
