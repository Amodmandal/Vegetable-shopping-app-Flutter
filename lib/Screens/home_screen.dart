import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vegetable_app/provider/dark_theme_provider.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImage = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: SizedBox(
        height: 300,
          child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            _offerImage[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: _offerImage.length,
        viewportFraction: 0.8,
        scale: 0.9,
         pagination: SwiperPagination(),
        autoplay: true,
      )),
    );
  }
}
