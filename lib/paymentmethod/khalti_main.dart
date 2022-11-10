import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:vegetable_app/PaymentMethod/khalti_payment_page%20.dart';

void main() => runApp(const KhaltiPaymentApp());

class KhaltiPaymentApp extends StatelessWidget {
  const KhaltiPaymentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_d5f560acc7bf4130a55a7d860e6788d7",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates:  [
              KhaltiLocalizations.delegate,
                
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: const Color(0xFF56328c),
                appBarTheme: const AppBarTheme(
                  color: Color(0xFF56328c),
                )),
            title: 'Khalti Payment',
            home: KhaltiPaymentPage(),
          );
        });
  }
}
