import 'package:currency_converter_test/core/constants/constants.dart';
import 'package:currency_converter_test/core/resources/data_state.dart';
import 'package:currency_converter_test/features/currency/data/models/currency.dart';
import 'package:dio/dio.dart';

class CurrencyApiService {
  Future<DataState<List<CurrencyModel>>> getCurrencies() async {
    String url = '$currencyAPIBaseURL$currencyAPIPath';
    Dio dio = Dio();

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List<CurrencyModel> rates = [];

        response.data['rates'].entries.forEach((entry) {
          rates.add(CurrencyModel(currency: entry.key, rate: entry.value.toDouble()));
        });

        return DataSuccess(rates);
      } else {
        return DataFailed(DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
