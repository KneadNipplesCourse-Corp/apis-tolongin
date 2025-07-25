import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/model/product_model.dart';
import 'package:flutter_restapi/services/api_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ApiService _service = ApiService();

  var isLoggedIn = false.obs;
  var products = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    _service.onInit();
    // fetchProducts();
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      isLoading(true);
      final success = await _service.login(email, password);
      isLoggedIn.value = success;

      if (!success) {
        Get.snackbar('Error', 'Login failed');
      }
    }

    isLoading(false);
  }

  void logout() {
    _service.logout();
    isLoggedIn.value = false;
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final result = await _service.fetchProducts();
      products.value = result;
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error on fetchProducts', "Error on fetchProducts: $e");
    } finally {
      isLoading(false);
    }
  }
}
