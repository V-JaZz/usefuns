import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/auth_provider.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/club/club_page.dart';
import 'package:live_app/screens/club/special_id_page.dart';
import 'package:live_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/local/sharedpreferences/storage_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  await storageService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => MomentsProvider()),
        ChangeNotifierProvider(create: (context) => RoomsProvider()),
        ChangeNotifierProvider(create: (context) => ZegoRoomProvider()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Live App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9E26BC)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
