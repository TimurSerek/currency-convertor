import 'package:currency_converter_test/core/usecases/usecase.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:currency_converter_test/features/currency/domain/repository/currency_repository.dart';

class RemoveCurrencyUseCase implements UseCase<void, CurrencyEntity>{
  final CurrencyRepository _currencyRepository;

  RemoveCurrencyUseCase(this._currencyRepository);

  @override
  Future<void> call({CurrencyEntity? params}) {
    return _currencyRepository.removeCurrencies();
  }
}