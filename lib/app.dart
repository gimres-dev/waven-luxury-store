import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/theme/theme.dart';
import 'package:t_store/bindings/general_bindings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      
      /// -- Initialize General Bindings (To manage loaders, network, etc.)
      initialBinding: GeneralBindings(),
      
      /// -- The "Waiting Room"
      /// Show a loader while the Authentication Repository decides the initial screen.
      /// In a luxury app, this ensures a smooth transition without UI flickering.
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}