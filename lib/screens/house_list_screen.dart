
import 'package:flutter/material.dart';




class HouseListScreen extends StatelessWidget {
  const HouseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hogwarts CRUD')),
      body: const Center(child: Text('House List Screen')),
    );
  } 
}
