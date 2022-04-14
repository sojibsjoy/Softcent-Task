import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:softcent_test/state_management/bindings/products_binding.dart';
import 'package:softcent_test/ui/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: HomeScreen.routeName,
            page: () => const HomeScreen(),
            binding: ProductsBinding(),
          ),
        ],
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
