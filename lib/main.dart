
import 'package:flutter/material.dart';
import 'package:mydrugs/src/providers/TimerProvider.dart';
import 'package:mydrugs/src/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => TimerProvider(),
    child: const TimerHowToSell(),
  ));
}

class TimerHowToSell extends StatelessWidget {
  const TimerHowToSell({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen()
    );
  }
}
