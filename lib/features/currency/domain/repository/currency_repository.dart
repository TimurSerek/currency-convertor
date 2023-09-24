import 'package:currency_converter_test/core/resources/data_state.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';

abstract class CurrencyRepository{

  //API methods
  Future<DataState<List<CurrencyEntity>>> getCurrencies();

  //Database methods
  Future<List<CurrencyEntity>> getSavedCurrencies();

  Future<void> saveCurrencies(List<CurrencyEntity> currencies);

  Future<void> removeCurrencies();
}