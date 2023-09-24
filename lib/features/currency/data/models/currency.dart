import 'dart:math';

import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'currency', primaryKeys: ['id'])
class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    int? id,
    String? currency,
    double? rate,
  }) : super(
    id: id,
    currency: currency,
    rate: rate,
  );

  factory CurrencyModel.fromJson(Map < String, dynamic > map) {
    return CurrencyModel(
      currency: map.keys.first,
      rate: (map.values.first as num).toDouble(),
    );
  }

  factory CurrencyModel.fromEntity(CurrencyEntity entity) {
    return CurrencyModel(
        currency: entity.currency,
        rate: entity.rate,
    );
  }
}