import 'package:currency_converter_test/core/resources/data_state.dart';
import 'package:currency_converter_test/features/currency/data/data_sources/local/app_database.dart';
import 'package:currency_converter_test/features/currency/data/data_sources/remote/currency_api_service.dart';
import 'package:currency_converter_test/features/currency/data/models/currency.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:currency_converter_test/features/currency/domain/repository/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyApiService _currencyApiService;
  final AppDatabase _appDatabase;

  CurrencyRepositoryImpl(this._currencyApiService, this._appDatabase);

  @override
  Future<DataState<List<CurrencyModel>>> getCurrencies() async {
    final response = await _currencyApiService.getCurrencies();
    return response;
  }

  @override
  Future<List<CurrencyModel>> getSavedCurrencies() async {
    return _appDatabase.currencyDAO.getCurrencies();
  }

  @override
  Future<void> removeCurrencies() {
    return _appDatabase.currencyDAO.deleteCurrencies();
  }

  @override
  Future<void> saveCurrencies(List<CurrencyEntity> currencies) {
    List<CurrencyModel> models = [];
    for (var article in currencies) {
      models.add(CurrencyModel.fromEntity(article));
    }
    return _appDatabase.currencyDAO.insertCurrencies(models);
  }
}