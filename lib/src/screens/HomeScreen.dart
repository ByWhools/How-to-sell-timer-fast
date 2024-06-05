import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydrugs/src/providers/TimerProvider.dart';
import 'package:provider/provider.dart';
/// The home screen of the application.
/// This screen displays a timer and provides options to manipulate the timer.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Semantics(
      label: 'Home Screen',
      child: GestureDetector(
        onTap: () {
          timerProvider.startTimer();
        },
        child: Scaffold(
          backgroundColor: timerProvider.screenColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.01,
                left: size.width / 30,
                right: size.width / 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: 'Timer Text',
                    child: Text(
                      '${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                          fontSize: 90,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (timerProvider.isGameOver)
                    const Text(
                      "Game Over",
                      style: TextStyle(
                          fontSize: 90,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Semantics(
                          label: 'Remove 10 seconds',
                          child: IconButton(
                              onPressed: () {
                                timerProvider.removeTenSeconds();
                              },
                              icon: const Row(
                                children: [
                                  Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '10',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                        Semantics(
                          label: 'Restart Timer',
                          child: IconButton(
                              onPressed: () {
                                timerProvider.resetTimer();
                              },
                              icon: const Icon(
                                Icons.restart_alt,
                                color: Colors.white,
                              )),
                        ),
                        Semantics(
                          label: 'Add 10 seconds',
                          child: IconButton(
                              onPressed: () {
                                timerProvider.addTenSeconds();
                              },
                              icon: const Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '10',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
