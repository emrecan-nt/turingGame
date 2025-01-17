import 'package:flutter/material.dart';
import 'package:turing_game/GameScreen.dart';

class UsernameScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade200,
        title: Text(
          'Giriş Ekranı',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
            
              controller: _controller,
              decoration: InputDecoration(
              
                labelText: 'Kim Oynayacak',
                labelStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor:  Colors.yellow.shade200,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GameScreen(username: _controller.text),
                    ),
                  );
                }
              },
              child: Text('Oyun Başlasın',style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Developed by Emre Mızrak © 2024',
          style: TextStyle(fontSize: 12, color: Colors.black),
          textAlign: TextAlign.center,
          )
          )
    );
  }
}

