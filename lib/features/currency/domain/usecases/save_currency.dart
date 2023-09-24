import 'package:currency_converter_test/core/usecases/usecase.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:currency_converter_test/features/currency/domain/repository/currency_repository.dart';

class SaveCurrencyUseCase implements UseCase<void, List<CurrencyEntity>>{
  final CurrencyRepository _currencyRepository;

  SaveCurrencyUseCase(this._currencyRepository);

  @override
  Future<void> call({List<CurrencyEntity>? params}) {
    return _currencyRepository.saveCurrencies(params!);
  }
}