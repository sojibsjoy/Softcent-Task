import 'package:get/get.dart';
import 'package:softcent_test/state_management/controllers/products_controller.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(),
    );
  }
}
