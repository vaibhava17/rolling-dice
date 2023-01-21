import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Dice Roller'),
          backgroundColor: Colors.red,
        ),
        body: const DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  int selectedValue = 7;

  void reset() {
    setState(() {
      selectedValue = 7;
    });
  }

  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
    // check if the sum of the dice is above 7
    if (leftDiceNumber + rightDiceNumber == 7 && selectedValue == 7 ||
        leftDiceNumber + rightDiceNumber < 7 && selectedValue == 6 ||
        leftDiceNumber + rightDiceNumber > 7 && selectedValue == 8) {
      // show dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('You Win!'),
              content: const Text('Your guess was correct!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    reset();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          });
    } else {
      // show dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('You Lose!'),
              content: const Text('You have guessed the wrong sum!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    reset();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          });
    }
  }

  void getRadioItem(int? val) {
    setState(() {
      selectedValue = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        const SizedBox(
          height: 50.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  rollDice();
                },
                child: Image.asset('assets/images/dice$leftDiceNumber.png'),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  rollDice();
                },
                child: Image.asset('assets/images/dice$rightDiceNumber.png'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
                value: 6,
                groupValue: selectedValue,
                onChanged: (val) {
                  getRadioItem(val);
                }),
            const Text('Below 7'),
            Radio(
                value: 7,
                groupValue: selectedValue,
                onChanged: (val) {
                  getRadioItem(val);
                }),
            const Text('7'),
            Radio(
                value: 8,
                groupValue: selectedValue,
                onChanged: (val) {
                  getRadioItem(val);
                }),
            const Text('Above 7'),
          ],
        ),
        ElevatedButton(
            onPressed: () {
              rollDice();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
            child: const Text(
              'Roll Dice',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )),
      ],
    ));
  }
}
