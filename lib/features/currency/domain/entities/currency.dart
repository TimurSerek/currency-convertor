import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable{
  final int? id;
  final String? currency;
  final double? rate;

  const CurrencyEntity({
    this.id,
    this.currency,
    this.rate,
  });

  @override
  List < Object ? > get props {
    return [
      id,
      currency,
      rate,
    ];
  }
}