
import 'package:flutter/material.dart';




class WandListScreen extends StatelessWidget {
  const WandListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hogwarts CRUD')),
      body: const Center(child: Text('Wand List Screen')),
    );
  } 
}
