import 'package:flutter/material.dart';



class HouseFormScreen extends StatelessWidget {
  const HouseFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hogwarts CRUD')),
      body: const Center(child: Text('House Form Screen')),
    );
  } 
}

