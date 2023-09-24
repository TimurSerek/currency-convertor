import 'package:floor/floor.dart';
import '../../models/currency.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'DAO/currency_dao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [CurrencyModel])
abstract class AppDatabase extends FloorDatabase {
  CurrencyDao get currencyDAO;
}