import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegetable_app/Screens/categories.dart';
import 'package:vegetable_app/Screens/home_screen.dart';
import 'package:vegetable_app/Screens/user.dart';
import '../providers/cart_provider.dart';
import 'cart/cart_screen.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  var _selectedIndex = 0;
  List _pages = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    UserScreen(),
  ];
  void _selectedpages(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //showSelectedLabels: false,
          //showUnselectedLabels: false,
          onTap: _selectedpages,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon:Consumer<CartProvider>(
                  builder: (_, myCart, ch) {
                    return Badge(
                      toAnimate: true,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent:
                          FittedBox(child: Text(myCart.getCartItems.length.toString(), style: TextStyle(color: Colors.white))),
                      child: Icon(
                          _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
                    );
                  }
                ),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: 'User')
          ]),
    );
  }
}
