// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/auth_provider.dart';
import 'package:live_app/provider/club_provider.dart';
import 'package:live_app/provider/gifts_provider.dart';
import 'package:live_app/provider/messages_provider.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/provider/seller_agency_provider.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'data/datasource/local/sharedpreferences/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  final storageService = StorageService();
  await storageService.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow only portrait mode
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
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
        ChangeNotifierProvider(create: (context) => ClubProvider()),
        ChangeNotifierProvider(create: (context) => ShopWalletProvider()),
        ChangeNotifierProvider(create: (context) => GiftsProvider()),
        ChangeNotifierProvider(create: (context) => MessagesProvider()),
        ChangeNotifierProvider(create: (context) => SellerAgencyProvider()),
      ],

      child: GetMaterialApp(
        title: 'Usefuns',
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
