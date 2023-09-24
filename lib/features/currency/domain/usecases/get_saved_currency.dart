import 'package:currency_converter_test/core/usecases/usecase.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:currency_converter_test/features/currency/domain/repository/currency_repository.dart';

class GetSavedCurrencyUseCase implements UseCase<List<CurrencyEntity>, void> {
  final CurrencyRepository _currencyRepository;

  GetSavedCurrencyUseCase(this._currencyRepository);

  @override
  Future<List<CurrencyEntity>> call({void params}) {
    return _currencyRepository.getSavedCurrencies();
  }
}