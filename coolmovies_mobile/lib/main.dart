import 'package:coolmovies/app_routes.dart';
import 'package:coolmovies/core/inject/app_injectors.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppInjector().init();

  runApp(
    MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: 'CoolMovies',
      theme: ThemeData.dark(),
    ),
  );
}
