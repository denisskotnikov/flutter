import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

class KeyStore {
  KeyStore._();
  static const String productsKey = 'products_key';
  static const List<Map<String, dynamic>> productsDefault = [];
}

class DataBasePrefs {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final value = _prefs.getString(KeyStore.productsKey);
      if (value == null) return KeyStore.productsDefault;
      
      final list = json.decode(value) as List;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return KeyStore.productsDefault;
    }
  }

  Future<void> saveProducts(List<Product> products) async {
    final productsJson = products.map((p) => p.toJson()).toList();
    await _prefs.setString(KeyStore.productsKey, json.encode(productsJson));
  }
}