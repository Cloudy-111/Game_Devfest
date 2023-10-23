import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  final Function() onPlayAgain;
  final Function() onBackToMain;

  EndScreen({required this.onPlayAgain, required this.onBackToMain});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.3, // Tỷ lệ chiều rộng của khung
          heightFactor: 1, // Tỷ lệ chiều cao của khung
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset('assets/images/Background/start_background.png').image,
                fit: BoxFit.fill,
              ),
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'K1',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: onPlayAgain,
                  child: Text(
                      'Play Again',
                    style: TextStyle(
                      fontFamily: 'K1',
                      fontSize: 18,
                    )
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: onBackToMain,
                  child: Text(
                      'Back to Main Menu',
                      style: TextStyle(
                        fontFamily: 'K1',
                        fontSize: 18,
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
