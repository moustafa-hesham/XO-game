import 'package:flutter/material.dart';
import 'package:xo_app/constants.dart';
import 'package:xo_app/models/gameBoardArguments.dart';
import 'package:xo_app/screens/GameScreen.dart';
import 'package:xo_app/widgets/CustomFormField.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static String iD = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController player1Controller = TextEditingController();

  TextEditingController player2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void clearForm() {
    player1Controller.clear();
    player2Controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      // appBar: AppBar(title: Text('XO Game')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Enter Players Name',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              player: player1Controller,
              hintText: 'Player 1',
            ),
            CustomFormField(
              player: player2Controller,
              hintText: 'Player 2',
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(
                    context,
                    GameScreen.iD,
                    arguments: GameBoardArguments(
                      player1Name: player1Controller.text,
                      player2Name: player2Controller.text,
                    ),
                  ).then((value) => clearForm());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.all(18),
                child: Center(
                  child: Text(
                    'Start Game',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
