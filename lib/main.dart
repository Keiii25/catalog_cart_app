import 'dart:io';

import 'package:catalog_cart_app/core/controllers/locale_controller.dart';
import 'package:catalog_cart_app/core/controllers/shared_preference_controller.dart';
import 'package:catalog_cart_app/core/enums.dart';
import 'package:catalog_cart_app/core/extension.dart';
import 'package:catalog_cart_app/modules/cart/presentation/cart_screen.dart';
import 'package:catalog_cart_app/modules/cart/presentation/controllers/cart_controller.dart';
import 'package:catalog_cart_app/modules/catolog/presentation/catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/drivers/api_helper.dart';
import 'modules/catolog/data/data_sources/product_remote_data_source.dart';
import 'modules/catolog/data/repositories/product_repository_impl.dart';
import 'modules/catolog/domain/repositories/product_repository.dart';
import 'modules/catolog/presentation/controllers/products_controller.dart';
import 'shared/services/cart_service.dart';

void main() {
  Get.put(CartService());
  Get.put(ApiHelper()); // Register ApiHelper instead of Dio
  Get.put(ProductRemoteDataSource(Get.find<ApiHelper>())); // Use ApiHelper here
  Get.put<ProductRepository>(ProductRepositoryImpl(Get.find<ProductRemoteDataSource>()));
  Get.put(GetProductsUseCase(Get.find<ProductRepository>()));
  Get.put(ProductController(getProductsUseCase: Get.find<GetProductsUseCase>()));
  Get.put(CartController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final localeController = LocaleController();
  final sharedPreferencesController = SharedPreferencesController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Catalog',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              systemOverlayStyle: Platform.isIOS
                  ? SystemUiOverlayStyle.dark
                  : const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent)),
          fontFamily: 'Nunito Sans'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoute.root.path,
      getPages: [
        GetPage<void>(name: AppRoute.root.path, page: () => const CatalogScreen()),
        GetPage<void>(name: AppRoute.cart.path, page: () => const CartScreen()),
      ],
    );
  }
}
