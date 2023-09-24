import 'package:currency_converter_test/core/resources/data_state.dart';
import 'package:currency_converter_test/core/usecases/usecase.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:currency_converter_test/features/currency/domain/repository/currency_repository.dart';

class GetCurrencyUseCase implements UseCase<DataState<List<CurrencyEntity>>, void> {
  final CurrencyRepository _currencyRepository;

  GetCurrencyUseCase(this._currencyRepository);

  @override
  Future<DataState<List<CurrencyEntity>>> call({void params}) {
      return _currencyRepository.getCurrencies();
  }
}