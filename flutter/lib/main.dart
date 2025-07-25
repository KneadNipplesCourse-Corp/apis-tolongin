import 'package:flutter/material.dart';
import 'package:flutter_restapi/controller/product_controller.dart';
import 'package:flutter_restapi/login.dart';
import 'package:flutter_restapi/middleware/auth_middleware.dart';
import 'package:flutter_restapi/products.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/products",
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(
          name: "/products",
          page: () => ProductPage(),
          middlewares: [AuthMiddleware()],
        ),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(ProductController());
      }),
    );
  }
}
