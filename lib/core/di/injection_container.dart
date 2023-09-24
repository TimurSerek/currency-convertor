import 'package:currency_converter_test/features/currency/data/data_sources/local/app_database.dart';
import 'package:currency_converter_test/features/currency/data/data_sources/remote/currency_api_service.dart';
import 'package:currency_converter_test/features/currency/data/repository/currency_repository_impl.dart';
import 'package:currency_converter_test/features/currency/domain/repository/currency_repository.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/get_currency.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/get_saved_currency.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/remove_saved_currency.dart';
import 'package:currency_converter_test/features/currency/domain/usecases/save_currency.dart';
import 'package:currency_converter_test/features/currency/presentation/bloc/currency_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio());

  //Database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dependencies
  sl.registerSingleton<CurrencyApiService>(CurrencyApiService());

  sl.registerSingleton<CurrencyRepository>(
      CurrencyRepositoryImpl(sl(), sl())
  );

  //UseCases
  sl.registerSingleton<GetCurrencyUseCase>(
      GetCurrencyUseCase(sl())
  );

  sl.registerSingleton<SaveCurrencyUseCase>(
      SaveCurrencyUseCase(sl())
  );

  sl.registerSingleton<RemoveCurrencyUseCase>(
      RemoveCurrencyUseCase(sl())
  );

  sl.registerSingleton<GetSavedCurrencyUseCase>(
      GetSavedCurrencyUseCase(sl())
  );
  //Blocs
  sl.registerFactory<CurrencyBloc>(
          ()=> CurrencyBloc(sl(), sl(), sl(), sl())
  );
}