abstract class CurrencyEvent {
  const CurrencyEvent();
}

class GetCurrencyEvent extends CurrencyEvent {
  const GetCurrencyEvent();
}

class ConvertCurrencyEvent extends CurrencyEvent{
  final double fromCurrency;
  final double toCurrency;
  final int value;

  const ConvertCurrencyEvent({
    required this.fromCurrency,
    required this.toCurrency,
    required this.value,
});
}

class CalculateCurrencyEvent extends CurrencyEvent {
  const CalculateCurrencyEvent();
}