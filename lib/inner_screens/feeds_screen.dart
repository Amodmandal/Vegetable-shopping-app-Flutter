import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:vegetable_app/widgets/back_widget.dart';

import '../services/utils.dart';
import '../widgets/feeds_items.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  FeedsScreen({Key? key}) : super(key: key);
  static const routeName = "/FeedsScreen";
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTexTFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTexTFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    return Scaffold(
      appBar: AppBar(
        leading:Backwidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
            text: ' All products', color: color, textSize: 24, isTitle: true),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1),
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
                              : color,
                        ),
                      )),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(10, (index) {
                return FeedsWidget();
              }),
            )
          ],
        ),
      ),
    );
  }
}
