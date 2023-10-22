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
              color: Color(0xFF211F30),
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onPlayAgain,
                  child: Text('Play Again'),
                ),
                ElevatedButton(
                  onPressed: onBackToMain,
                  child: Text('Back to Main'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
