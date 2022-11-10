import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';

class EsewaIntegration extends StatefulWidget {
  EsewaIntegration({Key? key}) : super(key: key);

  @override
  State<EsewaIntegration> createState() => _EsewaIntegrationState();
}

class _EsewaIntegrationState extends State<EsewaIntegration> {
  ESewaPnp? _esewaPnp;
  final ESewaConfiguration _configuration = ESewaConfiguration(
    clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );
  @override
  void initState() {
    super.initState();
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ESewa PNP"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.parse(value);
                });
              },
              decoration: InputDecoration(
                labelText: "Enter amount",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Default",
              style: TextStyle(color: Colors.black45),
            ),
            ESewaPaymentButton(
              _esewaPnp!,
              amount: _amount,
              callBackURL: "https://example.com",
              productId: "abc123",
              productName: "Flutter SDK Example",
              onSuccess: (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.message.toString())));
              },
              onFailure: (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message.toString())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
