import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/core/api/pokemon_api.dart';
import 'package:taskmaster/app/core/dio_client.dart';
import 'package:taskmaster/app/managers/session_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await _setupInstance();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TaskMaster",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(
          color: AppColors.taskmasterPrimaryColor,
        ),
        scaffoldBackgroundColor: AppColors.taskmasterPrimaryGray,
        textTheme: GoogleFonts.kanitTextTheme().apply(
          bodyColor: Colors.white,
        ),
      ),
    ),
  );
}

Future<void> _setupInstance() async {
  await GetStorage.init();

  //Call PokemonAPI
  Get.put(Dio());
  final Dio dio = Get.find();
  Get.put(DioClient(dio));

  final DioClient dioClient = Get.find();
  Get.put(PokemonAPI(dioClient));

  // Call Storage to use in session
  Get.put(GetStorage());
  final GetStorage getStorage = Get.find();
  Get.put(SessionManager(getStorage));

  return;
}
