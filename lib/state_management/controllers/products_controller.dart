import 'package:get/get.dart';
import 'package:softcent_test/state_management/models/products_model.dart';
import 'package:softcent_test/state_management/services/products_service.dart';

class ProductsController extends GetxController {
  var isLoading = true.obs;

  var products = <Products>[].obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    isLoading(true);
    try {
      products.value = await ProductsService.getProducts();
    } finally {
      isLoading(false);
    }
  }
}
