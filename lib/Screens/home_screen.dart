import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:provider/provider.dart';
import 'package:vegetable_app/inner_screens/0nsale_screen.dart';
import 'package:vegetable_app/inner_screens/feeds_screen.dart';
import 'package:vegetable_app/provider/dark_theme_provider.dart';
import 'package:vegetable_app/services/utils.dart';
import 'package:vegetable_app/widgets/feeds_items.dart';
import 'package:vegetable_app/widgets/on_sale_widget.dart';
import 'package:vegetable_app/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTexTFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTexTFocusNode.dispose();
    super.dispose();
  }

  final List<String> _offerImage = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).getscreensize;
    final Color color = Utils(context).color;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _search(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: size.height * 0.26,
                  width: size.width * 1.5,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(_offerImage[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    itemCount: _offerImage.length,
                    pagination: SwiperPagination(),
                    autoplay: true,
                    viewportFraction: 0.7,
                    scale: 0.9,
                  )),
              SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, OnSaleScreen.routeName);
                },
                child: TextWidget(
                  text: 'View all',
                  color: Colors.blue,
                  textSize: 19,
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        Text('On sale',
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Lobster",
                                fontSize: 22,
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(IconlyLight.discount, color: Colors.red)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: size.height * 0.22,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return OnSaleWidget();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextWidget(
                      text: 'Our products',
                      color: color,
                      textSize: 20,
                      isTitle: true,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, FeedsScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'Browse all',
                        color: Colors.blue,
                        textSize: 19,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                childAspectRatio: size.width / (size.height * 0.6),
                children: List.generate(6, (index) {
                  return FeedsWidget();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: TextField(
          focusNode: _searchTexTFocusNode,
          controller: _searchTextController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.greenAccent, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.greenAccent, width: 1),
              ),
              hintText: "What's is your mind",
              prefixIcon: Icon(Icons.search),
              suffix: IconButton(
                onPressed: () {
                  _searchTextController!.clear();
                  _searchTexTFocusNode.unfocus();
                },
                icon: Icon(
                  Icons.close,
                  color: _searchTexTFocusNode.hasFocus
                      ? Colors.red
                      : Color.fromARGB(255, 20, 31, 35),
                ),
              )),
        ),
      ),
    );
  }
}
