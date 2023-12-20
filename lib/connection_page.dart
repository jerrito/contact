import 'package:flutter/material.dart';
import 'package:house_rental/src/authentication/presentation/pages/phone_number_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text("Connection Page")),
        Center(
          child: TextButton(
            onPressed: () {
             Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondary) =>
                      const PhoneNumberPage(),
                  transitionsBuilder: (context, animation, secondary, child) {
                    var begin = const Offset(0.0, 0.1);
                    var end = Offset.zero;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOutCirc));
                    var offSetPosition = animation.drive(tween);

                    return SlideTransition(
                      position: offSetPosition,
                      child: child,
                    );
                  }));
           
            },
            child: const Text(
              "Next",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ));
  }
}



