import 'package:currency_converter_test/core/constants/strings.dart';
import 'package:currency_converter_test/core/di/injection_container.dart';
import 'package:currency_converter_test/features/currency/domain/entities/currency.dart';
import 'package:currency_converter_test/features/currency/presentation/bloc/currency_bloc.dart';
import 'package:currency_converter_test/features/currency/presentation/bloc/currency_event.dart';
import 'package:currency_converter_test/features/currency/presentation/bloc/currency_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: BlocProvider<CurrencyBloc>(
        create: (context) => sl()..add(const GetCurrencyEvent()),
        child: _Body(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        AppStrings.currencyConvertor,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(builder: (_, state) {
      if (state is CurrencyLoadingState) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is CurrencyErrorState) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is CurrencyDoneState || state is CurrencyCalculatedState) {
        return _CurrencyWidget(state: state);
      }
      return const SizedBox();
    });
  }
}

class _CurrencyWidget extends StatefulWidget {
  _CurrencyWidget({Key? key, required this.state}) : super(key: key);
  CurrencyState? state;
  CurrencyEntity? fromCurrency;
  CurrencyEntity? toCurrency;
  int? newValue;

  @override
  State<_CurrencyWidget> createState() => _CurrencyWidgetState();
}

class _CurrencyWidgetState extends State<_CurrencyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(AppStrings.youSend),
          Row(
            children: [
              Expanded(
                  child: TextField(
                    onChanged: (value) {
                      widget.newValue = value.isNotEmpty ? int.parse(value) : 0;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  )),
              const SizedBox(width: 40),
              DropdownButton<CurrencyEntity>(
                value: widget.fromCurrency,
                items: widget.state?.currencies?.map((CurrencyEntity currency) {
                  return DropdownMenuItem<CurrencyEntity>(
                    value: currency,
                    child: Text(currency.currency ?? ''),
                  );
                }).toList(),
                onChanged: (CurrencyEntity? newValue) {
                  setState(() {
                    widget.fromCurrency = newValue;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
              child: IconButton(
                  onPressed: () {
                    if(widget.fromCurrency?.rate != null && widget.toCurrency?.rate != null && widget.newValue != null) {
                      context.read<CurrencyBloc>().add(ConvertCurrencyEvent(
                          fromCurrency: widget.fromCurrency!.rate!,
                          toCurrency: widget.toCurrency!.rate!,
                          value: widget.newValue!));
                    }
                  },
                  icon: const Icon(Icons.swap_vert))),
          const SizedBox(height: 40),
          const Text(AppStrings.theyGet),
          Row(
            children: [
              BlocBuilder<CurrencyBloc, CurrencyState>(
                builder: (context, state) {
                  return Expanded(child: Text('${state.currencyRate ?? 0}'));
                },
              ),
              const SizedBox(width: 40),
              DropdownButton<CurrencyEntity>(
                value: widget.toCurrency,
                items: widget.state?.currencies?.map((CurrencyEntity currency) {
                  return DropdownMenuItem<CurrencyEntity>(
                    value: currency,
                    child: Text(currency.currency ?? ''),
                  );
                }).toList(),
                onChanged: (CurrencyEntity? newValue) {
                  setState(() {
                    widget.toCurrency = newValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


