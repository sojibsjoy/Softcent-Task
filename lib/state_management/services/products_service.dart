import 'dart:convert';

import 'package:softcent_test/state_management/constants/string_constants.dart';
import 'package:softcent_test/state_management/models/products_model.dart';
import 'package:softcent_test/state_management/services/base_client.dart';

class ProductsService {
  static Future<List<Products>> getProducts() async {
    var response = await BaseClient().getData(ConstantStrings.kUrl);
    ProductsModel obj = ProductsModel.fromJson(jsonDecode(response));
    return obj.products;
  }
}
