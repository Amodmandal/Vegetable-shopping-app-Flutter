import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../inner_screens/product_details.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreensize;
    return ListTile(
      subtitle: const Text('Paid: \RS 120'),
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'https://www.pngmart.com/files/8/Cauliflower-PNG-Image-HD.png',
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(text: 'Title  x12', color: color, textSize: 18),
      trailing: TextWidget(text: '03/08/2022', color: color, textSize: 18),
    );
  }
}
