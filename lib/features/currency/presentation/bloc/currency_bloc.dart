import 'package:currency_converter_test/core/resources/data_state.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/get_currency.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/get_saved_currency.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/remove_saved_currency.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/save_currency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent,CurrencyState> {

  final GetCurrencyUseCase _getCurrencyUseCase;
  final GetSavedCurrencyUseCase _getSavedCurrencyUseCase;
  final RemoveCurrencyUseCase _removeCurrencyUseCase;
  final SaveCurrencyUseCase _saveCurrencyUseCase;

  CurrencyBloc(
      this._getCurrencyUseCase,
      this._getSavedCurrencyUseCase,
      this._saveCurrencyUseCase,
      this._removeCurrencyUseCase
      ): super(const CurrencyLoadingState()){
    on<GetCurrencyEvent>(onGetCurrency);
    on<ConvertCurrencyEvent>(onCalculateCurrency);
  }

  void onGetCurrency(GetCurrencyEvent event, Emitter < CurrencyState > emit) async {
    final dataState = await _getCurrencyUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      await _removeCurrencyUseCase();
      await _saveCurrencyUseCase(params: dataState.data);
      final currencies = await _getSavedCurrencyUseCase();
      emit(CurrencyDoneState(currencies));
    }

    if (dataState is DataFailed) {
      final currencies = await _getSavedCurrencyUseCase();
      emit(CurrencyDoneState(currencies));
    }
  }

  void onCalculateCurrency(ConvertCurrencyEvent event, Emitter <CurrencyState> emit) async {
      final result = ((1/event.fromCurrency) * (1/event.toCurrency)) * event.value;
      emit(CurrencyCalculatedState(result));
  }
}