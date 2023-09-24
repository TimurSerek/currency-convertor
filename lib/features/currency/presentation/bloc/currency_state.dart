import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class CurrencyState extends Equatable {
    final List<CurrencyEntity>? currencies;
    final double? currencyRate;
    final DioException? error;

  const CurrencyState({this.currencies, this.currencyRate, this.error});

    @override
    List<Object> get props => [currencies!, error!, currencyRate!];
}

class CurrencyLoadingState extends CurrencyState{
  const CurrencyLoadingState();
}

class CurrencyDoneState extends CurrencyState{
  const CurrencyDoneState(List<CurrencyEntity> articles) : super(currencies: articles);
}

class CurrencyErrorState extends CurrencyState{
  const CurrencyErrorState(DioException error) : super(error: error);
}

class CurrencyCalculatedState extends CurrencyState{
  const CurrencyCalculatedState(double currencyRate) : super(currencyRate: currencyRate);
}