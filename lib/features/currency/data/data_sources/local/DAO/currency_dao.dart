import 'package:currency_converter_test/features/currency/data/models/currency.dart';
import 'package:floor/floor.dart';

@dao
abstract class CurrencyDao {

  @Query('SELECT * FROM currency')
  Future<List<CurrencyModel>> getCurrencies();

  @Query('DELETE FROM currency')
  Future<void> deleteCurrencies();

  @insert
  Future<void> insertCurrencies(List<CurrencyModel> currencies);
}