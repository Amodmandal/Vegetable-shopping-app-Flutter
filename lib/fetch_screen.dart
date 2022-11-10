import 'package:flutter/material.dart';

import 'Screens/btm_bar.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              SizedBox(
                height: 300,
              ),
              Center(
                child: Text('Tarkari',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Lobster",
                        fontSize: 50,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                  child: Text("SHOP now".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) =>  BottomBarScreen(),
                    ));
                  })
            ],
          ),
        ],
      ),
    );
  }
}
